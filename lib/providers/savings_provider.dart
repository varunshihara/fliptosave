import 'dart:math';
import 'package:flutter/material.dart';
import '../models/flip_record.dart';
import '../models/app_data.dart';
import '../db/database_service.dart';

class SavingsProvider with ChangeNotifier {
  AppData _appData = AppData();
  List<FlipRecord> _flipRecords = [];
  bool _isLoading = false;
  String? _lastMotivationalMessage;

  // Motivational messages
  static const List<String> _motivationalMessages = [
    "You just saved money ✨",
    "Future you says thanks 🙏",
    "Impulse stopped. Wallet secured 💰",
    "That was close… but you won 🎉",
    "Your savings account is smiling 😊",
    "Smart choice! Money saved 💪",
    "Impulse defeated! Victory is yours 🏆",
    "Another dollar saved, another step closer to your goals 🎯",
    "You're building wealth one 'No' at a time 🏗️",
    "Your future self just high-fived you 🙌",
    "Saving mode: ACTIVATED 🚀",
    "You're stronger than that impulse! 💪",
    "Money in the bank beats regret in the heart 💖",
    "Discipline today, freedom tomorrow 🗽",
    "You just chose needs over wants like a pro 🎓",
  ];

  // Getters
  AppData get appData => _appData;
  List<FlipRecord> get flipRecords => _flipRecords;
  bool get isLoading => _isLoading;
  String? get lastMotivationalMessage => _lastMotivationalMessage;

  double get totalSaved => _appData.totalSaved;
  int get currentStreak => _appData.currentStreak;
  int get bestStreak => _appData.bestStreak;
  int get totalFlips => _flipRecords.length;

  Future<void> initialize() async {
    _isLoading = true;
    notifyListeners();

    try {
      await DatabaseService.initialize();
      await loadData();
    } catch (e) {
      debugPrint('Error initializing SavingsProvider: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadData() async {
    try {
      _appData = DatabaseService.getAppData();
      _flipRecords = DatabaseService.getAllFlipRecords();
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading data: $e');
    }
  }

  String getRandomMotivationalMessage() {
    final random = Random();
    final message =
        _motivationalMessages[random.nextInt(_motivationalMessages.length)];
    _lastMotivationalMessage = message;
    return message;
  }

  Future<void> addFlipRecord(double amount) async {
    if (amount <= 0) return;

    try {
      _isLoading = true;
      notifyListeners();

      final motivationalMessage = getRandomMotivationalMessage();

      final record = FlipRecord(
        date: DateTime.now(),
        amount: amount,
        motivationalMessage: motivationalMessage,
      );

      await DatabaseService.addFlipRecord(record);
      await DatabaseService.addSavings(amount);

      // Reload data to ensure consistency
      await loadData();
    } catch (e) {
      debugPrint('Error adding flip record: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> resetAllData() async {
    try {
      _isLoading = true;
      notifyListeners();

      await DatabaseService.resetAllData();
      await loadData();
    } catch (e) {
      debugPrint('Error resetting data: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Statistics methods
  double getAverageSavings() {
    if (_flipRecords.isEmpty) return 0.0;

    final total = _flipRecords.fold<double>(
      0.0,
      (sum, record) => sum + record.amount,
    );
    return total / _flipRecords.length;
  }

  double getMonthlyTotal([DateTime? month]) {
    final targetMonth = month ?? DateTime.now();
    final startOfMonth = DateTime(targetMonth.year, targetMonth.month, 1);
    final endOfMonth = DateTime(targetMonth.year, targetMonth.month + 1, 0);

    final monthlyRecords = _flipRecords.where((record) {
      return record.date.isAfter(
            startOfMonth.subtract(const Duration(days: 1)),
          ) &&
          record.date.isBefore(endOfMonth.add(const Duration(days: 1)));
    }).toList();

    return monthlyRecords.fold<double>(
      0.0,
      (sum, record) => sum + record.amount,
    );
  }

  List<FlipRecord> getRecentFlips([int count = 10]) {
    final sortedRecords = List<FlipRecord>.from(_flipRecords);
    sortedRecords.sort((a, b) => b.date.compareTo(a.date));
    return sortedRecords.take(count).toList();
  }

  // Check if user has flipped today
  bool hasFlippedToday() {
    final today = DateTime.now();
    final todayStart = DateTime(today.year, today.month, today.day);
    final todayEnd = todayStart.add(const Duration(days: 1));

    return _flipRecords.any(
      (record) =>
          record.date.isAfter(todayStart) && record.date.isBefore(todayEnd),
    );
  }

  // Get formatted currency string
  String formatCurrency(double amount) {
    return '₹${amount.toStringAsFixed(2)}';
  }
}

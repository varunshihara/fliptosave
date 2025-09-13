import 'package:hive_flutter/hive_flutter.dart';
import '../models/flip_record.dart';
import '../models/app_data.dart';

class DatabaseService {
  static const String _flipRecordsBox = 'flipRecords';
  static const String _appDataBox = 'appData';
  static const String _appDataKey = 'appData';

  static late Box<FlipRecord> _flipRecordsHive;
  static late Box<AppData> _appDataHive;

  static Future<void> initialize() async {
    await Hive.initFlutter();

    // Register adapters
    Hive.registerAdapter(FlipRecordAdapter());
    Hive.registerAdapter(AppDataAdapter());

    // Open boxes
    _flipRecordsHive = await Hive.openBox<FlipRecord>(_flipRecordsBox);
    _appDataHive = await Hive.openBox<AppData>(_appDataBox);

    // Initialize app data if it doesn't exist
    if (_appDataHive.get(_appDataKey) == null) {
      await _appDataHive.put(_appDataKey, AppData());
    }
  }

  // FlipRecord operations
  static Future<void> addFlipRecord(FlipRecord record) async {
    await _flipRecordsHive.add(record);
  }

  static List<FlipRecord> getAllFlipRecords() {
    return _flipRecordsHive.values.toList();
  }

  static List<FlipRecord> getFlipRecordsByDateRange(
    DateTime start,
    DateTime end,
  ) {
    return _flipRecordsHive.values
        .where(
          (record) =>
              record.date.isAfter(start.subtract(const Duration(days: 1))) &&
              record.date.isBefore(end.add(const Duration(days: 1))),
        )
        .toList();
  }

  static Future<void> clearAllFlipRecords() async {
    await _flipRecordsHive.clear();
  }

  // AppData operations
  static AppData getAppData() {
    return _appDataHive.get(_appDataKey) ?? AppData();
  }

  static Future<void> updateAppData(AppData appData) async {
    await _appDataHive.put(_appDataKey, appData);
  }

  static Future<void> addSavings(double amount) async {
    final appData = getAppData();
    appData.updateTotalSaved(amount);
    appData.updateStreak();
    await updateAppData(appData);
  }

  static Future<void> resetAllData() async {
    final appData = getAppData();
    appData.resetData();
    await updateAppData(appData);
    await clearAllFlipRecords();
  }

  // Statistics
  static double getTotalSaved() {
    return getAppData().totalSaved;
  }

  static int getCurrentStreak() {
    return getAppData().currentStreak;
  }

  static int getBestStreak() {
    return getAppData().bestStreak;
  }

  static int getTotalFlips() {
    return _flipRecordsHive.length;
  }

  static double getAverageSavings() {
    final records = getAllFlipRecords();
    if (records.isEmpty) return 0.0;

    final total = records.fold<double>(
      0.0,
      (sum, record) => sum + record.amount,
    );
    return total / records.length;
  }

  // Get savings for current month
  static double getMonthlyTotal([DateTime? month]) {
    final targetMonth = month ?? DateTime.now();
    final startOfMonth = DateTime(targetMonth.year, targetMonth.month, 1);
    final endOfMonth = DateTime(targetMonth.year, targetMonth.month + 1, 0);

    final monthlyRecords = getFlipRecordsByDateRange(startOfMonth, endOfMonth);
    return monthlyRecords.fold<double>(
      0.0,
      (sum, record) => sum + record.amount,
    );
  }

  static Future<void> dispose() async {
    await _flipRecordsHive.close();
    await _appDataHive.close();
  }
}

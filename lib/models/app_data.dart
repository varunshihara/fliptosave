import 'package:hive/hive.dart';

part 'app_data.g.dart';

@HiveType(typeId: 1)
class AppData extends HiveObject {
  @HiveField(0)
  double totalSaved;

  @HiveField(1)
  int currentStreak;

  @HiveField(2)
  int bestStreak;

  @HiveField(3)
  DateTime? lastFlipDate;

  AppData({
    this.totalSaved = 0.0,
    this.currentStreak = 0,
    this.bestStreak = 0,
    this.lastFlipDate,
  });

  void updateTotalSaved(double amount) {
    totalSaved += amount;
  }

  void updateStreak() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    if (lastFlipDate == null) {
      // First time using the app
      currentStreak = 1;
      lastFlipDate = today;
    } else {
      final lastFlip = DateTime(
        lastFlipDate!.year,
        lastFlipDate!.month,
        lastFlipDate!.day,
      );

      final dayDifference = today.difference(lastFlip).inDays;

      if (dayDifference == 0) {
        // Same day, don't update streak
        return;
      } else if (dayDifference == 1) {
        // Consecutive day
        currentStreak++;
        lastFlipDate = today;
      } else {
        // Broke the streak
        currentStreak = 1;
        lastFlipDate = today;
      }
    }

    if (currentStreak > bestStreak) {
      bestStreak = currentStreak;
    }
  }

  void resetData() {
    totalSaved = 0.0;
    currentStreak = 0;
    bestStreak = 0;
    lastFlipDate = null;
  }
}

import 'package:hive/hive.dart';

part 'flip_record.g.dart';

@HiveType(typeId: 0)
class FlipRecord extends HiveObject {
  @HiveField(0)
  DateTime date;

  @HiveField(1)
  double amount;

  @HiveField(2)
  String motivationalMessage;

  FlipRecord({
    required this.date,
    required this.amount,
    required this.motivationalMessage,
  });

  String get formattedDate {
    return '${date.day}/${date.month}/${date.year}';
  }

  bool isSameDay(DateTime other) {
    return date.year == other.year &&
        date.month == other.month &&
        date.day == other.day;
  }
}

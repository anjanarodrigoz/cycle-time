import 'package:hive/hive.dart';
part '../db/cycle_time.g.dart';

@HiveType(typeId: 1)
class CycleTime extends HiveObject {
  @HiveField(0)
  final Duration start;

  @HiveField(1)
  final Duration loading;

  @HiveField(2)
  final Duration uphill;

  @HiveField(3)
  final Duration dumping;

  @HiveField(4)
  final Duration downhill;

  @HiveField(5)
  final Duration cycle;

  @HiveField(6)
  final DateTime startTime;

  @HiveField(7)
  final DateTime endTime;

  @HiveField(8)
  final int index;

  CycleTime(
      {required this.start,
      required this.loading,
      required this.uphill,
      required this.dumping,
      required this.downhill,
      required this.cycle,
      required this.startTime,
      required this.endTime,
      required this.index});
}

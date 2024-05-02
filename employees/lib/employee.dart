import 'package:hive/hive.dart';

part 'employee.g.dart';

@HiveType(typeId: 0)
enum Position {
  @HiveField(0)
  manager,
  @HiveField(1)
  developer,
  @HiveField(2)
  designer,
  @HiveField(3)
  tester,
}

@HiveType(typeId: 1)
class Employee extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String lastName;
  @HiveField(2)
  Position position;
  @HiveField(3)
  DateTime arrivalTime;
  @HiveField(4)
  DateTime departureTime;

  Employee({
    required this.name,
    required this.lastName,
    required this.position,
    required this.arrivalTime,
    required this.departureTime,
  });
}
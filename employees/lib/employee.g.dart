// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EmployeeAdapter extends TypeAdapter<Employee> {
  @override
  final int typeId = 1;

  @override
  Employee read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Employee(
      name: fields[0] as String,
      lastName: fields[1] as String,
      position: fields[2] as Position,
      arrivalTime: fields[3] as DateTime,
      departureTime: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Employee obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.lastName)
      ..writeByte(2)
      ..write(obj.position)
      ..writeByte(3)
      ..write(obj.arrivalTime)
      ..writeByte(4)
      ..write(obj.departureTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmployeeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PositionAdapter extends TypeAdapter<Position> {
  @override
  final int typeId = 0;

  @override
  Position read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Position.manager;
      case 1:
        return Position.developer;
      case 2:
        return Position.designer;
      case 3:
        return Position.tester;
      default:
        return Position.manager;
    }
  }

  @override
  void write(BinaryWriter writer, Position obj) {
    switch (obj) {
      case Position.manager:
        writer.writeByte(0);
        break;
      case Position.developer:
        writer.writeByte(1);
        break;
      case Position.designer:
        writer.writeByte(2);
        break;
      case Position.tester:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PositionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

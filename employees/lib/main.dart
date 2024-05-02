import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:employees/employees.dart';
import 'package:employees/employee.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Employee>(EmployeeAdapter());
  Hive.registerAdapter<Position>(PositionAdapter());
  await Hive.openBox<Employee>('employees');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const Employees(),
    );
  }
}

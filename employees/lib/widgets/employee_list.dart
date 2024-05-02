import 'package:flutter/material.dart';

import 'package:employees/employee.dart';
import 'package:employees/widgets/employee_item.dart';

class EmployeesList extends StatelessWidget {
  const EmployeesList({super.key, required this.employees});

  final List<Employee> employees;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: employees.length,
      itemBuilder: (ctx, index) => Card(
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
        key: ValueKey(employees[index]),
        child: EmployeeItem(employees[index])
      ),
    );
  }

}
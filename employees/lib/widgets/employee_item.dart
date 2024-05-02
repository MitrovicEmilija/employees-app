import 'package:flutter/material.dart';

import 'package:employees/employee.dart';

class EmployeeItem extends StatelessWidget {
  const EmployeeItem(this.employee, {super.key});

  final Employee employee;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        children: [
          Text(
            employee.name,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            employee.lastName,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 15,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(employee.position.name.toString().toUpperCase(),
              style: const TextStyle(
                fontSize: 15,
              )),
        ],
      ),
    );
  }
}

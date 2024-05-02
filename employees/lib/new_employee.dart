import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:employees/employee.dart';

final formatter = DateFormat.yMd();
final box = Hive.openBox<Employee>('employees');

class NewEmployee extends StatefulWidget {
  const NewEmployee({super.key, required this.onAddEmployee});

  final void Function(Employee) onAddEmployee;

  @override
  State<NewEmployee> createState() {
    return _NewEmployeeState();
  }
}

class _NewEmployeeState extends State<NewEmployee> {
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  Position _selectedPosition = Position.developer;
  DateTime? _selectedArrivalTime;
  DateTime? _selectedDepartureTime;

  void _presentDatePickerArrival() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = DateTime(now.year + 1, now.month, now.day);

    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: lastDate);
    setState(() {
      _selectedArrivalTime = pickedDate;
    });
  }

  void _presentDatePickerDepart() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = DateTime(now.year + 1, now.month, now.day);

    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: lastDate);
    setState(() {
      _selectedDepartureTime = pickedDate;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Add Employee',
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold,
        ),
      )),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Employee>('employees').listenable(),
        builder: (context, Box<Employee> box, _) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                    ),
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(
                      labelText: 'Last Name',
                    ),
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: DropdownButton(
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                      value: _selectedPosition,
                      items: Position.values
                          .map(
                            (position) => DropdownMenuItem(
                              value: position,
                              child: Text(position.name.toUpperCase()),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value == null) return;
                        setState(() {
                          _selectedPosition = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: Row(
                      children: [
                        Text(
                          _selectedArrivalTime == null
                              ? 'Choose arrival time!'
                              : 'Arrival Time: ${formatter.format(_selectedArrivalTime!)}',
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        IconButton(
                            onPressed: _presentDatePickerArrival,
                            icon: const Icon(Icons.calendar_month_outlined),
                            color: Theme.of(context).primaryColor,
                            iconSize: 25),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: Row(
                      children: [
                        Text(
                          _selectedDepartureTime == null
                              ? 'Choose departure time!'
                              : 'Departure Time: ${formatter.format(_selectedDepartureTime!)}',
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        IconButton(
                            onPressed: _presentDatePickerDepart,
                            icon: const Icon(Icons.calendar_month_outlined),
                            color: Theme.of(context).primaryColor,
                            iconSize: 25),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).secondaryHeaderColor,
                      ),
                      onPressed: () {
                        widget.onAddEmployee(
                          Employee(
                            name: _nameController.text,
                            lastName: _lastNameController.text,
                            position: _selectedPosition,
                            arrivalTime: _selectedArrivalTime!,
                            departureTime: _selectedDepartureTime!,
                          ),
                        );
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Employee added!'),
                              content: const Text('Employee added to Hive!'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text('Add'),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

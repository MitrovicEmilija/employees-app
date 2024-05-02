import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

import 'package:employees/employee.dart';
import 'package:employees/new_employee.dart';
//import 'package:employees/widgets/employee_list.dart';

final formatter = DateFormat.yMd();

class Employees extends StatefulWidget {
  const Employees({super.key});

  @override
  State<Employees> createState() {
    return _EmployeesState();
  }
}

class _EmployeesState extends State<Employees> {
  final List<Employee> listOfEmployees = [
    Employee(
      name: 'Emilia',
      lastName: 'Mitrović',
      position: Position.developer,
      arrivalTime: DateTime.now(),
      departureTime: DateTime.now(),
    ),
    Employee(
        name: 'Dijana',
        lastName: 'Mitrović',
        position: Position.manager,
        arrivalTime: DateTime.now(),
        departureTime: DateTime.now()),
  ];

  final _box = Hive.box<Employee>('employees');
  List<Employee> get employees => _box.values.toList();

  void addEmployee(Employee employee) {
    print("Adding employee to Hive: ${employee.name}");
    print(employees);
    _box.add(employee);
  }

  Future<void> _editEmployee(Employee employee, int index) async {
    final nameController = TextEditingController();
    final lastNameController = TextEditingController();
    Position selectedPosition = employee.position;
    DateTime? selectedArrivalTime;
    DateTime? selectedDepartureTime;

    nameController.text = employee.name;
    lastNameController.text = employee.lastName;
    selectedPosition = employee.position;
    selectedArrivalTime = employee.arrivalTime;
    selectedDepartureTime = employee.departureTime;

    Future<void> presentDatePickerArrival() async {
      final now = DateTime.now();
      final firstDate = DateTime(now.year - 1, now.month, now.day);
      final lastDate = DateTime(now.year + 1, now.month, now.day);

      final pickedDate = await showDatePicker(
          context: context,
          initialDate: now,
          firstDate: firstDate,
          lastDate: lastDate);
      if (pickedDate != null) {
        setState(() {
          employee.arrivalTime = pickedDate;
        });
      }
      print("Arrival time: ${employee.arrivalTime}");
    }

    Future<void> presentDatePickerDepart() async {
      final now = DateTime.now();
      final firstDate = DateTime(now.year - 1, now.month, now.day);
      final lastDate = DateTime(now.year + 1, now.month, now.day);

      final pickedDate = await showDatePicker(
          context: context,
          initialDate: now,
          firstDate: firstDate,
          lastDate: lastDate);
      if (pickedDate != null) {
        setState(() {
          employee.departureTime = pickedDate;
        });
      }
      print(employee.departureTime);
    }

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Edit employee',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      )),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: lastNameController,
                  decoration: InputDecoration(
                      labelText: 'Last name',
                      labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      )),
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField(
                  value: selectedPosition,
                  items: Position.values
                      .map((position) => DropdownMenuItem(
                            value: position,
                            child: Text(position.name.toString().toUpperCase()),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedPosition = value as Position;
                    });
                  },
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Arrival Time: ${formatter.format(selectedArrivalTime!)}',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    presentDatePickerArrival();
                  },
                  icon: const Icon(Icons.calendar_month_outlined),
                  color: Theme.of(context).primaryColor,
                  iconSize: 25,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Departure Time: ${formatter.format(selectedDepartureTime!)}',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    presentDatePickerDepart();
                  },
                  icon: const Icon(Icons.calendar_month_outlined),
                  color: Theme.of(context).primaryColor,
                  iconSize: 25,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                final editedEmployee = Employee(
                  name: nameController.text,
                  lastName: lastNameController.text,
                  position: selectedPosition,
                  arrivalTime: employee.arrivalTime,
                  departureTime: employee.departureTime,
                );
                _box.putAt(index, editedEmployee);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            'Employees',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          IconButton(
            padding: const EdgeInsets.only(right: 25),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                return NewEmployee(
                  onAddEmployee: addEmployee,
                );
              }));
            },
            icon: Icon(Icons.add_circle, color: Theme.of(context).primaryColor),
          )
        ],
      ),
      body: ValueListenableBuilder(
          valueListenable: Hive.box<Employee>('employees').listenable(),
          builder: (context, Box<Employee> box, _) {
            return ListView.builder(
              padding: const EdgeInsets.only(left: 10),
              itemCount: _box.length,
              itemBuilder: (ctx, index) {
                final employee = _box.getAt(index);
                return ListTile(
                  title: Text(
                    employee!.name,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(employee.lastName),
                  leading: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      _editEmployee(employee, index);
                    },
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).primaryColorLight),
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      box.deleteAt(index);
                    },
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).primaryColor),
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}

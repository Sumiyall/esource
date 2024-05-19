import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/table_provider.dart';
import 'package:firebase_database/firebase_database.dart';

class RepairDetailsPage extends StatefulWidget {
  final Map<String, dynamic> task;

  const RepairDetailsPage({Key? key, required this.task}) : super(key: key);

  @override
  _RepairDetailsPageState createState() => _RepairDetailsPageState();
}

class _RepairDetailsPageState extends State<RepairDetailsPage> {
  int _selectedHours = 0;
  String status = 'Засагдаж байна';
  Map<String, int> selectedMaterials = {};
  String _selectedItem = '';
  double _totalPrice = 0.0;

  
  final double hourlyRate = 20000.0; 

  @override
void initState() {
  super.initState();
  _selectedItem = widget.task['name'] ?? '';
  status = 'Засагдаж байна'; 
  _fetchTaskDetails();
}

  Future<void> _fetchTaskDetails() async {
    final taskId = widget.task['id'];
    final databaseURL =
        'https://esource-bed3f-default-rtdb.asia-southeast1.firebasedatabase.app';
    DatabaseReference taskRef =
        FirebaseDatabase(databaseURL: databaseURL).reference().child('tasks').child(taskId);

    taskRef.onValue.listen((event) {
      final dataSnapshot = event.snapshot;
      if (dataSnapshot.value != null) {
        final taskData = Map<String, dynamic>.from(dataSnapshot.value as Map<dynamic, dynamic>);
        setState(() {
          _selectedHours = taskData['selectedHours'] ?? 0;
          status = taskData['status'] ?? 'Засагдаж байна';
          selectedMaterials = Map<String, int>.from(taskData['selectedMaterials'] ?? {});
          _totalPrice = taskData['totalPrice'] ?? 0.0;
        });
      }
    });
  }

  void _calculateTotalPrice() {
    final tableDataProvider = Provider.of<TableDataProvider>(context, listen: false);
    num totalMaterialPrice = 0;
    selectedMaterials.forEach((code, quantity) {
      final material = tableDataProvider.tableData.firstWhere(
        (item) => item['code'] == code,
        orElse: () => {},
      );
      totalMaterialPrice += (material['price'] ?? 0) * quantity;
    });

    double laborCost = _selectedHours * hourlyRate;


    setState(() {
      _totalPrice = totalMaterialPrice + laborCost;
    });
  }

  Future<void> _updateTaskDetails() async {
    final taskId = widget.task['id'];
    print('Update hiij baina : $taskId');

    final databaseURL =
        'https://esource-bed3f-default-rtdb.asia-southeast1.firebasedatabase.app';
    DatabaseReference taskRef =
        FirebaseDatabase(databaseURL: databaseURL).reference().child('tasks').child(taskId);

    Map<String, int> sanitizedMaterials = {};
    selectedMaterials.forEach((key, value) {
      String sanitizedKey = key.replaceAll(RegExp(r'[/\.#$\[\]]'), '_');
      sanitizedMaterials[sanitizedKey] = value;
    });

    try {
      await taskRef.update({
        'selectedHours': _selectedHours,
        'status': status,
        'selectedMaterials': sanitizedMaterials,
        'totalPrice': _totalPrice,
      });
      print('Task amjilttai hadgalagdlaa');
    } catch (error) {
      print('Task hadgalahad aldaa garlaa: $error');
      
    }
  }

  @override
  Widget build(BuildContext context) {
    final tableDataProvider = Provider.of<TableDataProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Засварын дэлгэрэнгүй',
          style: TextStyle(fontFamily: 'Mogul3', fontSize: 28),
        ),
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Нэр: $_selectedItem',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Тайлбар: ${widget.task['description'] ?? ''}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 24),
              Text(
                'Ашиглагдах материал',
                style: TextStyle(
                  fontSize: 18, 
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              ...tableDataProvider.tableData.map((material) {
                return CheckboxListTile(
                  title: Text(material['name'] ?? ''),
                  value: selectedMaterials.containsKey(material['code']),
                  onChanged: (value) {
                    setState(() {
                      if (value == true) {
                        selectedMaterials[material['code'] ?? ''] = 1;
                      } else {
                        selectedMaterials.remove(material['code']);
                      }
                      _calculateTotalPrice();
                    });
                  },
                  secondary: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (selectedMaterials[material['code'] ?? ''] != null &&
                                selectedMaterials[material['code'] ?? '']! > 1) {
                              selectedMaterials[material['code'] ?? ''] =
                                  selectedMaterials[material['code'] ?? '']! - 1;
                            }
                            _calculateTotalPrice();
                          });
                        },
                      ),
                      Text(selectedMaterials[material['code'] ?? '']?.toString() ?? '0'),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            if (selectedMaterials[material['code'] ?? ''] != null) {
                              selectedMaterials[material['code'] ?? ''] =
                                  selectedMaterials[material['code'] ?? '']! + 1;
                            } else {
                              selectedMaterials[material['code'] ?? ''] = 1;
                            }
                            _calculateTotalPrice();
                          });
                        },
                      ),
                    ],
                  ),
                );
              }).toList(),
              SizedBox(height: 16),
              Text(
                'Тооцоолж буй хугацаа',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: List.generate(10, (index) {
                  return ChoiceChip(
                    label: Text('${index + 1} цаг'),
                    selected: _selectedHours == index + 1,
                    onSelected: (selected) {
                      setState(() {
                        _selectedHours = selected ? index + 1 : 0;
                        _calculateTotalPrice();
                      });
                    },
                    selectedColor: Color.fromARGB(255, 175, 209, 255),
                  );
                }),
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: status,
                decoration: InputDecoration(
                  labelText: 'Үйл явц',
                  border: OutlineInputBorder(),
                ),
                items: ['Засагдаж байна', 'Дууссан'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    status = value!;
                  });
                },
              ),
              SizedBox(height: 24),
              Text(
                'Нийт үнэ: $_totalPrice',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _calculateTotalPrice();
                  _updateTaskDetails();
                  // Show the total price in a dialog
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Нийт үнэ'),
                        content: Text('Нийт үнэ нь : $_totalPrice'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('OK', style: TextStyle(color: Color(0xFF4894FE),)),
                          ),
                        ],
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color(0xFF4894FE),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 24.0),
                        ),
                child: Text('Шинэчлэх'),
              ),
              SizedBox(height: 16),
              // Text(
              //   'Нийт үнэ: $_totalPrice',
              //   style: TextStyle(
              //     fontSize: 18,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
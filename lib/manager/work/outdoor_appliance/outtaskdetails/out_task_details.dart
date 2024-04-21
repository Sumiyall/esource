import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class OutTaskDetailsPage extends StatefulWidget {
  final Map<String, String> task;
  final Function(Map<String, String>) onSave;
  final Function() onDelete;

  const OutTaskDetailsPage({
    Key? key,
    required this.task,
    required this.onSave,
    required this.onDelete,
  }) : super(key: key);

  @override
  _OutTaskDetailsPageState createState() => _OutTaskDetailsPageState();
}

class _OutTaskDetailsPageState extends State<OutTaskDetailsPage> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  late TextEditingController _typeController;
  late TextEditingController _brandController;
  late TextEditingController _modelController;
  late TextEditingController _numberController;
  late TextEditingController _descriptionController;
  late TextEditingController _categoryController;
  late TextEditingController _dateController;

  DateTime _selectedDate = DateTime.now();
  String _selectedWorker = '';
  List<String> _workerOptions = [];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.task['name']);
    _phoneController = TextEditingController(text: widget.task['phone']);
    _addressController = TextEditingController(text: widget.task['address']);
    _typeController = TextEditingController(text: widget.task['type']);
    _brandController = TextEditingController(text: widget.task['brand']);
    _modelController = TextEditingController(text: widget.task['model']);
    _numberController = TextEditingController(text: widget.task['number']);
    _descriptionController = TextEditingController(text: widget.task['description']);
    _categoryController = TextEditingController(text: widget.task['category']);
    _dateController = TextEditingController(text: widget.task['date']);
    _loadWorkerOptions();
  }

  Future<void> _loadWorkerOptions() async {
    String jsonString = await rootBundle.loadString('assets/json/workers.json');
    List<dynamic> workerList = json.decode(jsonString);
    setState(() {
      _workerOptions = workerList.cast<String>();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _typeController.dispose();
    _brandController.dispose();
    _modelController.dispose();
    _numberController.dispose();
    _descriptionController.dispose();
    _categoryController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ажил өөрчлөх',
          style: TextStyle(fontFamily: 'Mogul3', fontSize: 28),
        ),
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Захиалагчийн нэр'),
            ),
            SizedBox(height: 24),
            GestureDetector(
              onTap: _selectDate,
              child: AbsorbPointer(
                child: TextFormField(
                  controller: _dateController,
                  decoration: InputDecoration(labelText: 'Огноо'),
                ),
              ),
            ),
            SizedBox(height: 24),
            DropdownButtonFormField<String>(
              value: _selectedWorker.isNotEmpty ? _selectedWorker : null,
              onChanged: (value) {
                setState(() {
                  _selectedWorker = value!;
                });
              },
              items: _workerOptions.map((worker) {
                return DropdownMenuItem<String>(
                  value: worker,
                  child: Text(worker),
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'Гүйцэтгэх ажилтан'),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _saveTask,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue, 
                    onPrimary: Colors.white, 
                    shape: RoundedRectangleBorder( 
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 24.0), 
                  ),
                  child: Text(
                    'Хадгалах',
                    style: TextStyle(
                      fontSize: 18.0, 
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),


                ElevatedButton(
                  onPressed: _deleteTask,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red, 
                    onPrimary: Colors.white, 
                    shape: RoundedRectangleBorder( 
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 24.0), 
                  ),
                  child: Text(
                    'Устгах',
                    style: TextStyle(
                      fontSize: 18.0, 
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(_selectedDate);
      });
    }
  }

  void _saveTask() {
    final updatedTask = {
      'name': _nameController.text,
      'phone': _phoneController.text,
      'address': _addressController.text,
      'type': _typeController.text,
      'brand': _brandController.text,
      'model': _modelController.text,
      'number': _numberController.text,
      'description': _descriptionController.text,
      'category': _categoryController.text,
      'date': _dateController.text,
      'assignedWorker': _selectedWorker,
    };

    widget.onSave(updatedTask);
    Navigator.pop(context);
  }

  void _deleteTask() {
    widget.onDelete();
    Navigator.pop(context);
  }
}
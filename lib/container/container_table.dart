import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ContainerTable extends StatefulWidget {
  @override
  _ContainerTableState createState() => _ContainerTableState();
}

class _ContainerTableState extends State<ContainerTable> {
  List<Map<String, dynamic>> _workRequests = [];

  @override
  void initState() {
    super.initState();
    _loadWorkRequests();
  }

  Future<void> _loadWorkRequests() async {
    try {
      String jsonData = await rootBundle.loadString('assets/table_data.json');
      print("test");
      List<dynamic> itemsJson = json.decode(jsonData);
      List<Map<String, dynamic>> items = itemsJson.cast<Map<String, dynamic>>();
      setState(() {
        _workRequests = items;
      });
    } catch (e) {
      print('Error loading table data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 12),
          const SizedBox(height: 16),
          Table(
            children: [
              TableRow(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 225, 244, 255),
                ),
                children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '  Зураг',
                        style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Mogul3'),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '  Нэр',
                        style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Mogul3'),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '  Код',
                        style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Mogul3'),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '  Тоо',
                        style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Mogul3'),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '  Үнэ',
                        style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Mogul3'),
                      ),
                    ),
                  ),
                ],
              ),
              
              ..._workRequests.map((request) {
                return TableRow(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 225, 244, 255),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          request['imagePath'] ?? '',
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(request['name'] ?? ''),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(request['code'] ?? ''),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(request['quantity']?.toString() ?? ''),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(request['price']?.toString() ?? ''),
                    ),
                  ],
                );
              }).expand((row) sync* {
                yield row;
                yield TableRow(children: [
                  SizedBox(height: 4),
                  SizedBox(height: 4),
                  SizedBox(height: 4),
                  SizedBox(height: 4),
                  SizedBox(height: 4),
                ]);
              }).toList(),
            ],
          ),
        ],
      ),
    );
  }
}
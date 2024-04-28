import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class ReportPage extends StatefulWidget {
  final String userEmail;
  const ReportPage({Key? key, required this.userEmail}) : super(key: key);

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  List<Map<String, dynamic>> _tasks = [];
  int _totalTasks = 0;
  int _completedTasks = 0;
  int _inProgressTasks = 0;
  double _totalPrice = 0;

  @override
  void initState() {
    super.initState();
    _fetchReportData();
  }

  Future<void> _fetchReportData() async {
  final databaseUrl = 'https://esource-bed3f-default-rtdb.asia-southeast1.firebasedatabase.app';
  final databaseRef = FirebaseDatabase(databaseURL: databaseUrl).reference();
  DatabaseReference tasksRef = databaseRef.child('tasks');

  DataSnapshot dataSnapshot = (await tasksRef.once()).snapshot;
  if (dataSnapshot.value != null) {
    Map<dynamic, dynamic> tasksMap = dataSnapshot.value as Map<dynamic, dynamic>;
    List<Map<String, dynamic>> tasks = [];
    int totalTasks = 0;
    int completedTasks = 0;
    int inProgressTasks = 0;
    double totalPrice = 0;

    tasksMap.forEach((key, value) {
      if (value is Map<dynamic, dynamic>) {
        Map<String, dynamic> task = Map<String, dynamic>.from(value);
        if (task['name'] != null) {
          totalTasks++;
          if (task['status'] == 'Дууссан') {
            completedTasks++;
          } else if (task['status'] == 'Засагдаж байна') {
            inProgressTasks++;
          }
          totalPrice += task['totalPrice'] ?? 0;
        }
        tasks.add(task);
      }
    });

    setState(() {
      _tasks = tasks;
      _totalTasks = totalTasks;
      _completedTasks = completedTasks;
      _inProgressTasks = inProgressTasks;
      _totalPrice = totalPrice;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ажлын тайлан',
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
              Table(
                border: TableBorder.all(),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                    ),
                    children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Тайлангийн нэр',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Утга',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                    ),
                    children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Нийт ажлын тоо'),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('$_totalTasks'),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Дууссан ажлын тоо'),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('$_completedTasks'),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                    ),
                    children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Засагдаж байгаа ажлын тоо'),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('$_inProgressTasks'),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Нийт үнэ'),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('$_totalPrice'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 24),
              Text(
                'Ажлын дэлгэрэнгүй мэдээлэл',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Table(
                border: TableBorder.all(),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                    ),
                    children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Ажлын нэр',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Явц',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Нийт үнэ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ..._tasks.asMap().entries.map((entry) {
                    final index = entry.key;
                    final task = entry.value;
                    final isEvenRow = index % 2 == 0;

                    return TableRow(
                      decoration: BoxDecoration(
                        color: isEvenRow ? Colors.blue.shade50 : null,
                      ),
                      children: [
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(task['name'] ?? ''),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(task['status'] ?? ''),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text((task['totalPrice'] ?? 0).toString()),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
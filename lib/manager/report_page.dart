import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class ReportPage extends StatefulWidget {
  final String userEmail;
  const ReportPage({Key? key, required this.userEmail}) : super(key: key);

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
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
      int totalTasks = 0;
      int completedTasks = 0;
      int inProgressTasks = 0;
      double totalPrice = 0;

      tasksMap.forEach((key, value) {
        if (value['name'] != null) {
          totalTasks++;
          if (value['status'] == 'Дууссан') {
            completedTasks++;
          } else if (value['status'] == 'Засагдаж байна') {
            inProgressTasks++;
          }
          totalPrice += value['totalPrice'] ?? 0;
        }
      });

      setState(() {
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Нийт ажлын тоо: $_totalTasks',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Дууссан ажлын тоо: $_completedTasks',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Засагдаж байгаа ажлын тоо: $_inProgressTasks',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'Нийт үнэ: $_totalPrice',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
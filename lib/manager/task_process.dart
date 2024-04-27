import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class TaskDetailsPage extends StatefulWidget {
  final String taskId;

  const TaskDetailsPage({Key? key, required this.taskId}) : super(key: key);

  @override
  _TaskDetailsPageState createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends State<TaskDetailsPage> {
  Map<String, dynamic> _taskDetails = {};

  @override
  void initState() {
    super.initState();
    _fetchTaskDetails();
  }

  Future<void> _fetchTaskDetails() async {
    final databaseURL =
        'https://esource-bed3f-default-rtdb.asia-southeast1.firebasedatabase.app';
    DatabaseReference taskRef =
        FirebaseDatabase(databaseURL: databaseURL).reference().child('tasks').child(widget.taskId);

    DatabaseEvent event = await taskRef.once();
    DataSnapshot dataSnapshot = event.snapshot;
    if (dataSnapshot.value != null) {
      final taskData = Map<String, dynamic>.from(dataSnapshot.value as Map<dynamic, dynamic>);
      setState(() {
        _taskDetails = taskData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ажлын явц',
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
              if (_taskDetails['imageUrl'] != null && _taskDetails['imageUrl'].isNotEmpty)
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(_taskDetails['imageUrl']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              SizedBox(height: 16),
              Text(
                'Нэр: ${_taskDetails['name'] ?? ''}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Тайлбар: ${_taskDetails['description'] ?? ''}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 8),
              Text(
                'Хугацааны хүсэлт: ${_taskDetails['category'] ?? ''}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 8),
              Text(
                'Явц: ${_taskDetails['status'] ?? ''}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                'Тооцоолж буй хугацаа: ${_taskDetails['selectedHours'] ?? 0}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 8),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: (_taskDetails['selectedMaterials'] as Map<String, dynamic>? ?? {})
              //       .entries
              //       .map((entry) => Text('${entry.key}: ${entry.value}'))
              //       .toList(),
              // ),
              SizedBox(height: 16),
              Text(
                'Нийт үнэ: ${_taskDetails['totalPrice'] ?? 0}',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

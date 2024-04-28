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
        title: Text(
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
              TextBlock(title: 'Нэр', content: _taskDetails['name'] ?? ''),
              TextBlock(title: 'Тайлбар', content: _taskDetails['description'] ?? ''),
              TextBlock(title: 'Хугацааны хүсэлт', content: _taskDetails['category'] ?? ''),
              TextBlock(title: 'Явц', content: _taskDetails['status'] ?? ''),
              TextBlock(title: 'Тооцоолж буй хугацаа', content: _taskDetails['selectedHours']?.toString() ?? ''),
              TextBlock(title: 'Нийт үнэ', content: _taskDetails['totalPrice']?.toString() ?? ''),
            ],
          ),
        ),
      ),
    );
  }
}

class TextBlock extends StatelessWidget {
  final String title;
  final String content;

  const TextBlock({Key? key, required this.title, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Mogul3'),
        ),
        SizedBox(height: 4),
        Text(
          content,
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 4),
        Divider(),
      ],
    );
  }
}

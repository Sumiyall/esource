import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'home_task_details/home_task_details.dart';

class HomeTaskListPage extends StatefulWidget {
  @override
  _HomeTaskListPageState createState() => _HomeTaskListPageState();
}

class _HomeTaskListPageState extends State<HomeTaskListPage> {
  List<Map<String, dynamic>> _tasks = [];

  @override
  void initState() {
    super.initState();
    _fetchTasks();
  }

  Future<void> _fetchTasks() async {
    final databaseURL =
        'https://esource-bed3f-default-rtdb.asia-southeast1.firebasedatabase.app';
    DatabaseReference tasksRef =
        FirebaseDatabase(databaseURL: databaseURL).reference().child('tasks');

    tasksRef.onValue.listen((event) {
      final dataSnapshot = event.snapshot;
      if (dataSnapshot.value != null) {
        final tasksMap = Map<String, dynamic>.from(
            dataSnapshot.value as Map<dynamic, dynamic>);
        final fetchedTasks = tasksMap.entries.map((entry) {
          final taskId = entry.key;
          final taskData =
              Map<String, dynamic>.from(entry.value as Map<dynamic, dynamic>);
          taskData['id'] = taskId;
          return taskData;
        }).toList();

        setState(() {
          _tasks = fetchedTasks;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Нэмэгдсэн ажлууд',
          style: TextStyle(fontFamily: 'Mogul3', fontSize: 28),
        ),
      ),
      body: ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (BuildContext context, int index) {
          final task = _tasks[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeTaskDetailsPage(
                    task: task,
                    onSave: (updatedTask) {
                      // Update the task in the database
                      final taskId = task['id'];
                      final databaseURL =
                          'https://esource-bed3f-default-rtdb.asia-southeast1.firebasedatabase.app';
                      DatabaseReference taskRef =
                          FirebaseDatabase(databaseURL: databaseURL)
                              .reference()
                              .child('tasks')
                              .child(taskId);
                      taskRef.update(updatedTask);
                    },
                    onDelete: () {
                      // Delete the task from the database
                      final taskId = task['id'];
                      final databaseURL =
                          'https://esource-bed3f-default-rtdb.asia-southeast1.firebasedatabase.app';
                      DatabaseReference taskRef =
                          FirebaseDatabase(databaseURL: databaseURL)
                              .reference()
                              .child('tasks')
                              .child(taskId);
                      taskRef.remove();
                    },
                  ),
                ),
              );
            },
            child: Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Color(0xFF4894FE)),
              ),
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task['name'] ?? '',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Утасны дугаар: ${task['phone'] ?? ''}',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Гэрийн хаяг: ${task['address'] ?? ''}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 24),
                    Text(
                      'Засвар хийлгэх хэрэгслийн тодорхойлолт',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Төрөл: ${task['type'] ?? ''}',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Бренд: ${task['brand'] ?? ''}',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Загвар: ${task['model'] ?? ''}',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Дугаар: ${task['number'] ?? ''}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 24),
                    Text(
                      'Тайлбар',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      task['description'] ?? '',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 24),
                    Text(
                      'Ангилал',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      task['category'] ?? '',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 24),
                    Text(
                      'Date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      task['date'] ?? '',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 24),
                    Text(
                      'Assigned Worker',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      task['assignedWorker'] ?? '',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

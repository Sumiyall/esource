import 'dart:io';
import 'package:flutter/material.dart';
import 'home_task_details/home_task_details.dart';
import 'package:firebase_database/firebase_database.dart';

class HomeTaskListPage extends StatefulWidget {
  @override
  _HomeTaskListPageState createState() => _HomeTaskListPageState();
}

class _HomeTaskListPageState extends State<HomeTaskListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Нэмэгдсэн ажлууд',
          style: TextStyle(fontFamily: 'Mogul3', fontSize: 28),
        ),
      ),
      body: FutureBuilder<DatabaseEvent>(
        future: FirebaseDatabase.instance.reference().child('tasks').once(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print('Snapshot data: ${snapshot.data?.snapshot.value}');
            if (snapshot.data!.snapshot.value != null) {
              Map<dynamic, dynamic> tasksMap = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
              List<Map<String, dynamic>> tasks = tasksMap.entries.map((entry) {
                return {
                  'key': entry.key,
                  ...Map<String, dynamic>.from(entry.value),
                };
              }).toList();
              return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (BuildContext context, int index) {
                  final task = tasks[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeTaskDetailsPage(
                            task: task,
                            onSave: (updatedTask) {
                              // Update the task in Firebase Realtime Database
                              FirebaseDatabase.instance.reference().child('tasks').child(task['key']).update(updatedTask);
                            },
                            onDelete: () {
                              // Delete the task from Firebase Realtime Database
                              FirebaseDatabase.instance.reference().child('tasks').child(task['key']).remove();
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
                            Container(
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: task['image'] != null && task['image']!.isNotEmpty
                                    ? DecorationImage(
                                        image: FileImage(File(task['image']!)),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              task['name']!,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 12),
                            Text(
                              'Утасны дугаар: ${task['phone']}',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              'Гэрийн хаяг: ${task['address']}',
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
                              'Төрөл: ${task['type']}',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              'Бренд: ${task['brand']}',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              'Загвар: ${task['model']}',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              'Дугаар: ${task['number']}',
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
                              task['description']!,
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
                              task['category']!,
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
              );
            } else {
              return Center(
                child: Text('No tasks available.'),
              );
            }
          } else if (snapshot.hasError) {
            print('Snapshot error: ${snapshot.error}');
            return Center(
              child: Text('Error loading tasks.'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
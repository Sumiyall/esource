import 'package:flutter/material.dart';
import 'home_task_details/home_task_details.dart';
import 'package:provider/provider.dart';
import '../../../provider/task_provider.dart';

class HomeTaskListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<TaskProvider>(context).tasks;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Нэмэгдсэн ажлууд',
          style: TextStyle(fontFamily: 'Mogul3', fontSize: 28),
        ),
      ),
      body: ListView.builder(
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
                      Provider.of<TaskProvider>(context, listen: false).updateTask(index, updatedTask);
                    },
                    onDelete: () {
                      Provider.of<TaskProvider>(context, listen: false).deleteTask(index);
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
      ),
    );
  }
}

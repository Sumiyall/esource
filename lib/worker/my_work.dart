import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:esource/manager/work/home_appliance/home_task_list.dart';
import 'package:provider/provider.dart';
import '../provider/job_request_provider.dart'; 

class MyWorkPage extends StatefulWidget {
  const MyWorkPage({Key? key}) : super(key: key);

  @override
  _MyWorkPageState createState() => _MyWorkPageState();
}

class _MyWorkPageState extends State<MyWorkPage> {
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

  void _showWorkDetails(BuildContext context, Map<String, dynamic> task) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(task['name'] ?? ''),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Хаах'),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle job request logic here
                // You can show a dialog or navigate to a confirmation page
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Ажил хүсэлт'),
                      content: Text('Та энэ ажлыг хүсэх үү?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Үгүй'),
                        ),
                        TextButton(
                          onPressed: () {
                            // Perform the job request logic here
                            final jobRequest = {
                              'name': task['name'],
                              'huselt': 1,
                              'batalga': 0,
                            };
                            Provider.of<JobRequestProvider>(context, listen: false).addJobRequest(jobRequest);
                            Navigator.pop(context);
                          },
                          child: Text('Тийм'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Ажил хүсэх'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ажил',
          style: TextStyle(fontFamily: 'Mogul3', fontSize: 28),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Ажлын хүсэлт гаргах',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCategoryCard(context, 'assets/images/addWork/ger1.png', 'Гэр ахуй'),
                  _buildCategoryCard(context, 'assets/images/addWork/tech.png', 'Технологи'),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCategoryCard(context, 'assets/images/addWork/gadna.png', 'Гадна талбай'),
                  _buildCategoryCard(context, 'assets/images/addWork/ger1.png', 'Технологи'),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Ажлын жагсаалт',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _tasks.length,
                itemBuilder: (BuildContext context, int index) {
                  final task = _tasks[index];
                  return GestureDetector(
                    onTap: () {
                      _showWorkDetails(context, task);
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        title: Text(
                          task['name'] ?? '',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          task['description'] ?? '',
                          style: TextStyle(fontSize: 14),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, String imagePath, String title) {
    return GestureDetector(
      onTap: () {
        if (title == 'Гэр ахуй') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeTaskListPage()),
          );
        } else if (title == 'Технологи') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeTaskListPage()),
          );
        } else if (title == 'Гадна талбай') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeTaskListPage()),
          );
        }
      },
      child: Column(
        children: [
          Container(
            width: 155,
            height: 92,
            decoration: BoxDecoration(
              border: Border.all(
                color: Color.fromARGB(255, 28, 100, 225),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Transform.scale(
                scale: 1.1,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 28, 100, 225),
            ),
          ),
        ],
      ),
    );
  }
}
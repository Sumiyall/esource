import 'package:esource/worker/repair_details.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/task_provider.dart';
import '../provider/repair_details_provider.dart';

class UndsenPage1 extends StatefulWidget {
  final String userEmail;

  UndsenPage1({Key? key, required this.userEmail}) : super(key: key);

  @override
  _UndsenPage1State createState() => _UndsenPage1State();
}

class _UndsenPage1State extends State<UndsenPage1> {
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
    final databaseReference = FirebaseDatabase.instance.reference().child('tasks');

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Сайн уу',
              style: TextStyle(fontFamily: 'Mogul3', fontSize: 28),
            ),
            Text(
              'Ажилтан',
              style: TextStyle(
                fontSize: 12,
                color: Color.fromARGB(200, 113, 125, 151),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF4894FE),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(19.0),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          backgroundImage: NetworkImage('https://th-thumbnailer.cdn-si-edu.com/5a79C6jJ8BrChMX5tgEKiMI_qqo=/1000x750/filters:no_upscale():focal(792x601:793x602)/https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer/52/e4/52e44474-c2dc-41e0-bb77-42a904695196/this-image-shows-a-portrait-of-dragon-man-credit-chuang-zhao_web.jpg'),
                          radius: 27,
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.userEmail,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                'Ajiltan gsh',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => CalendarPage()),
                            );
                          },
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: Colors.white,
                    height: 7,
                    thickness: 0.3,
                    indent: 20,
                    endIndent: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CalendarPage()),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: const [
                              Icon(
                                Icons.calendar_today,
                                color: Colors.white,
                              ),
                              SizedBox(width: 9),
                              Text(
                                'Хуваарь харах',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CallPage()),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: const [
                              Icon(
                                Icons.timer_outlined,
                                color: Colors.white,
                              ),
                              SizedBox(width: 9),
                              Text(
                                '11:00 - 12:00 AM',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Миний ажлууд',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  final task = _tasks[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RepairDetailsPage(task: task),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            task['imageUrl'] != null && task['imageUrl'].isNotEmpty
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      task['imageUrl'],
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Icon(Icons.image, color: Colors.grey[400]),
                                  ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    task['name'] ?? '',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    task['description'] ?? '',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[600],
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(Icons.category, size: 16, color: Colors.grey[400]),
                                      SizedBox(width: 4),
                                      Text(
                                        task['category'] ?? '',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CalendarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar Page'),
      ),
      body: Center(
        child: Text('Calendar Page Content'),
      ),
    );
  }
}

class CallPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Call Page'),
      ),
      body: Center(
        child: Text('Call Page Content'),
      ),
    );
  }
}
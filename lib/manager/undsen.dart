import 'package:esource/manager/task_process.dart';
import 'package:flutter/material.dart';
import 'profile.dart';
import 'package:flutter/material.dart';
import 'profile.dart';
import 'package:esource/manager/work/work_req_table.dart';
import 'package:flutter/material.dart';
import 'profile.dart';
import 'package:firebase_database/firebase_database.dart';


import 'package:flutter/material.dart';
import 'profile.dart';
import 'package:firebase_database/firebase_database.dart';
import 'task_process.dart';
import 'calendar.dart';

class UndsenPage extends StatefulWidget {
  final String userEmail;

  UndsenPage({Key? key, required this.userEmail}) : super(key: key);

  @override
  _UndsenPageState createState() => _UndsenPageState();
}

class _UndsenPageState extends State<UndsenPage> {
  List<Map<String, dynamic>> _tasks = [];
  String _userName = '';

  @override
  void initState() {
    super.initState();
    _fetchTasks();
    _fetchUserName();
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

  Future<void> _fetchUserName() async {
    final databaseUrl = 'https://esource-bed3f-default-rtdb.asia-southeast1.firebasedatabase.app';
    final databaseRef = FirebaseDatabase(databaseURL: databaseUrl).reference();
    DatabaseReference userRef = databaseRef.child('users');

    userRef.orderByChild('email').equalTo(widget.userEmail).onChildAdded.listen((event) {
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.exists) {
        Map<dynamic, dynamic> userData = snapshot.value as Map<dynamic, dynamic>;
        setState(() {
          _userName = userData['name'] ?? '';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Сайн уу',
              style: TextStyle(fontFamily: 'Mogul3', fontSize: 28),
            ),
            Text(
              'Менежер',
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
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.all(19.0),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/image.png'),
                            radius: 27,
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _userName,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  'Менежер',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          ),
                        ],
                      ),
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
                            MaterialPageRoute(
                                builder: (context) => CalendarPage()),
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
                                    color: Colors.white, fontSize: 16),
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
                                Icons.timer_sharp,
                                color: Colors.white,
                              ),
                              SizedBox(width: 9),
                              Text(
                                '11:00 - 12:00 AM',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
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
              'Нийт ажлууд',
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
                          builder: (context) => TaskDetailsPage(taskId: task['id']),
                        ),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xFF4894FE)!,
                                  width: 0.5,
                                ),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: task['imageUrl'] != null && task['imageUrl'].isNotEmpty
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: Image.network(
                                        task['imageUrl'],
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      child: Icon(Icons.image, color: Color(0xFF4894FE)),
                                    ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    task['name'] ?? '',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    task['description'] ?? '',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[600],
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      Icon(Icons.category, size: 18, color: Colors.grey[400]),
                                      SizedBox(width: 6),
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

// class CalendarPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Calendar Page'),
//       ),
//       body: Center(
//         child: Text('Calendar Page Content'),
//       ),
//     );
//   }
// }

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
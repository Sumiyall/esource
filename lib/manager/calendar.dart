import 'dart:math';

import 'package:esource/manager/task_process.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> _tasks = [];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _fetchTasks();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
          final uniqueCategories = _getUniqueCategories();
          _tabController = TabController(length: uniqueCategories.isEmpty ? 1 : uniqueCategories.length, vsync: this);
        });
      }
    });
  }

  List<String> _getUniqueCategories() {
    Set<String> categories = _tasks
        .map((task) => task['category'] as String? ?? 'Uncategorized')
        .where((category) => category != null)
        .toSet();
    return categories.toList();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, List<Map<String, dynamic>>> tasksByCategory = {};
    for (var task in _tasks) {
      final category = task['category'] as String? ?? 'Uncategorized';
      if (tasksByCategory.containsKey(category)) {
        tasksByCategory[category]!.add(task);
      } else {
        tasksByCategory[category] = [task];
      }
    }

    final uniqueCategories = _getUniqueCategories();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Хуваарь',
          style: TextStyle(fontFamily: 'Mogul3', fontSize: 28, color: Colors.white),
        ),
        // centerTitle: true,
        backgroundColor: Color(0xFF4894FE),
        iconTheme: IconThemeData(
          color: Colors.white, 
        ),
        bottom: TabBar(
          controller: _tabController,
          // isScrollable: true,
          indicatorColor: Colors.white,
          indicatorWeight: 4.0,
          labelStyle: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontSize: 15, color: Colors.white),
          tabs: uniqueCategories.map((category) => Tab(text: category)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: uniqueCategories.map((category) {
          final tasks = tasksByCategory[category] ?? [];
          return ListView.separated(
            padding: EdgeInsets.all(16),
            itemCount: tasks.length,
            separatorBuilder: (context, index) => SizedBox(height: 12),
            itemBuilder: (context, index) {
              final task = tasks[index];
              final timeRemaining = _calculateTimeRemaining(task);
              return Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  title: Text(
                    task['name'] ?? '',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8),
                      Text(
                        'Гүйцэтгэх хугацаа: $timeRemaining',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: _getProgressValue(task),
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      ),
                    ],
                  ),
                  trailing: Icon(
                    Icons.chevron_right,
                    size: 24,
                    color: Colors.blue,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaskDetailsPage(taskId: task['id']),
                      ),
                    );
                  },
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  String _calculateTimeRemaining(Map<String, dynamic> task) {
    int selectedHours = task['selectedHours'] ?? 0;
    return '$selectedHours цаг';
  }


  double _getProgressValue(Map<String, dynamic> task) {
  // Create an instance of Random
    Random random = Random();

    // Generate a random double between 0 and 1
    double progressValue = random.nextDouble();

    // Return the generated progress value
    return progressValue;
  }
}
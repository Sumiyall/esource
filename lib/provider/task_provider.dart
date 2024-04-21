import 'package:flutter/material.dart';

class TaskProvider extends ChangeNotifier {
  List<Map<String, String>> _tasks = [];

  List<Map<String, String>> get tasks => _tasks;

  void addTask(Map<String, String> task) {
    _tasks.add(task);
    notifyListeners();
  }

  void updateTask(int index, Map<String, String> updatedTask) {
    _tasks[index] = updatedTask;
    notifyListeners();
  }

  void deleteTask(int index) {
    _tasks.removeAt(index);
    notifyListeners();
  }

  // void requestJob(int taskIndex) {
  //   // Implement the job request logic here
  //   // For example, you can update the task status or assign the worker to the task
  //   _tasks[taskIndex]['status'] = 'Requested';
  //   _tasks[taskIndex]['assignedWorker'] = 'Worker Name'; // Replace with the actual worker name
  //   notifyListeners();
  // }
  void requestJob(String taskId, String workerName) {
    final task = _tasks.firstWhere((task) => task['id'] == taskId);
    task['status'] = 'Requested';
    task['requestedWorker'] = workerName;
    notifyListeners();
  }

}
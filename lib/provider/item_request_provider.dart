import 'package:flutter/material.dart';

class ItemRequestProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _pendingRequests = [];

  List<Map<String, dynamic>> get pendingRequests => _pendingRequests;

  void addRequest(Map<String, dynamic> request) {
    _pendingRequests.add(request);
    notifyListeners();
  }

  void removeRequest(Map<String, dynamic> request) {
    _pendingRequests.remove(request);
    notifyListeners();
  }

  void clearRequests() {
    _pendingRequests.clear();
    notifyListeners();
  }
}
import 'package:flutter/material.dart';

class ItemRequestProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _pendingRequests = [];

  List<Map<String, dynamic>> get pendingRequests => _pendingRequests;

  void setPendingRequests(List<Map<String, dynamic>> requests) {
    _pendingRequests = requests;
    notifyListeners();
  }

  void removeRequest(Map<String, dynamic> request) {
    _pendingRequests.remove(request);
    notifyListeners();
  }
}
import 'package:flutter/foundation.dart';

class JobRequestProvider with ChangeNotifier {
  List<Map<String, dynamic>> _jobRequests = [];

  List<Map<String, dynamic>> get jobRequests => _jobRequests;

  void addJobRequest(Map<String, dynamic> request) {
    _jobRequests.add(request);
    notifyListeners();
  }

  void removeJobRequest(Map<String, dynamic> request) {
    _jobRequests.remove(request);
    notifyListeners();
  }
}
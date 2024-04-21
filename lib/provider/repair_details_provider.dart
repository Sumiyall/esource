import 'package:flutter/foundation.dart';

class RepairDetailsProvider with ChangeNotifier {
  int _selectedHours = 0;
  String _status = 'In Progress';
  Map<String, int> _selectedMaterials = {};

  int get selectedHours => _selectedHours;
  String get status => _status;
  Map<String, int> get selectedMaterials => _selectedMaterials;

  void setSelectedHours(int hours) {
    _selectedHours = hours;
    notifyListeners();
  }

  void setStatus(String status) {
    _status = status;
    notifyListeners();
  }

  void setSelectedMaterials(Map<String, int> materials) {
    _selectedMaterials = materials;
    notifyListeners();
  }

  void resetState() {
    _selectedHours = 0;
    _status = 'In Progress';
    _selectedMaterials = {};
    notifyListeners();
  }
}
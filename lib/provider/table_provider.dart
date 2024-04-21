import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class TableDataProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _tableData = [];

  List<Map<String, dynamic>> get tableData => _tableData;

  Future<void> loadTableData() async {
    try {
      String jsonData = await rootBundle.loadString('assets/json/table_data.json');
      List<dynamic> itemsJson = json.decode(jsonData);
      _tableData = itemsJson.cast<Map<String, dynamic>>();
      notifyListeners();
    } catch (e) {
      print('Error loading table data: $e');
    }
  }

  void addItemToTableData(Map<String, dynamic> item) {
    _tableData.add(item);
    notifyListeners();
  }
}
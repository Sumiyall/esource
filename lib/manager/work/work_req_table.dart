import 'package:flutter/material.dart';
import '../add_work.dart';

class WorkRequestsTable extends StatefulWidget {
  final String selectedDuration;
  final Function(String?) onDurationChanged;
  final List<Map<String, dynamic>> workerJobRequests; // Add this line

  const WorkRequestsTable({
    Key? key,
    required this.selectedDuration,
    required this.onDurationChanged,
    required this.workerJobRequests, // Add this line
  }) : super(key: key);

  @override
  _WorkRequestsTableState createState() => _WorkRequestsTableState();
}

class _WorkRequestsTableState extends State<WorkRequestsTable> {
  List<Map<String, dynamic>> _getWorkRequests() {
    // Replace this with your actual data retrieval logic based on the selected duration
    if (widget.selectedDuration == 'Сүүлийн 7 хоног') {
      return [
        {'name': 'Sumiya Batsuuri', 'huselt': 2, 'batalga': 32},
        {'name': 'Garid Gots', 'huselt': 0, 'batalga': 41},
        {'name': 'Batts Dulguun', 'huselt': 2, 'batalga': 12},
      ];
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Ажлын хүсэлтүүд',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            DropdownButton<String>(
              value: widget.selectedDuration,
              onChanged: widget.onDurationChanged,
              items: <String>['Сүүлийн 7 хоног', 'Сүүлийн 3 хоног', 'Сүүлийн сар']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Table(
          children: [
            TableRow(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
              ),
              children: [
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Нэр',
                      style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Mogul3'),
                    ),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Хүсэлт',
                      style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Mogul3'),
                    ),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Баталгаажсан',
                      style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Mogul3'),
                    ),
                  ),
                ),
              ],
            ),
            ...widget.workerJobRequests.map((request) {
              return TableRow(
                children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(request['name'] ?? ''),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(request['huselt']?.toString() ?? ''),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(request['batalga']?.toString() ?? ''),
                    ),
                  ),
                ],
              );
            }).toList(),
          ],
        ),
      ],
    );
  }
}
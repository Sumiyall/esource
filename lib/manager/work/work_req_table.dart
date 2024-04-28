import 'package:flutter/material.dart';
import '../add_work.dart';

class WorkRequestsTable extends StatefulWidget {
  final String selectedDuration;
  final Function(String?) onDurationChanged;
  final List<Map<String, dynamic>> workerJobRequests;

  const WorkRequestsTable({
    Key? key,
    required this.selectedDuration,
    required this.onDurationChanged,
    required this.workerJobRequests,
  }) : super(key: key);

  @override
  _WorkRequestsTableState createState() => _WorkRequestsTableState();
}

class _WorkRequestsTableState extends State<WorkRequestsTable> {
  void _showConfirmationDialog(BuildContext context, Map<String, dynamic> request) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ажлын хүсэлт'),
          content: const Text('Хүсэлтийг зөвшөөрөх үү?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Үгүй'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  request['batalga'] = (request['batalga'] ?? 0) + (request['huselt'] ?? 0);
                  request['huselt'] = 0;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Тийм'),
            ),
          ],
        );
      },
    );
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
                  GestureDetector(
                    onTap: () {
                      _showConfirmationDialog(context, request);
                    },
                    child: TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(request['huselt']?.toString() ?? ''),
                      ),
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
import 'package:flutter/material.dart';

class ApplianceReqTable extends StatefulWidget {
  final String selectedDuration;
  final Function(String?) onDurationChanged;

  const ApplianceReqTable({
    Key? key,
    required this.selectedDuration,
    required this.onDurationChanged,
  }) : super(key: key);

  @override
  _ApplianceReqTableState createState() => _ApplianceReqTableState();
}

class _ApplianceReqTableState extends State<ApplianceReqTable> {
  List<Map<String, dynamic>> _getApplianceRequests() {
   
    if (widget.selectedDuration == 'Сүүлийн 7 хоног') {
      return [
        {'name': 'Sumiya Batsuuri', 'huselt': 2, 'batalga': 32},
        {'name': 'Garid Gots', 'huselt': 0, 'batalga': 41},
        {'name': 'Batts Dulguun', 'huselt': 2, 'batalga': 12},
      ];
    } else {
      // Placeholder data for other durations
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
              'Ирсэн хүсэлтүүд',
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
                      style: TextStyle(
                        fontWeight: FontWeight.bold, 
                        fontFamily: 'Mogul3',
                        color: Color.fromARGB(255, 92, 111, 136),
                      ),
                    ),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Хүсэлт',
                      style: TextStyle(
                        fontWeight: FontWeight.bold, 
                        fontFamily: 'Mogul3',
                        color: Color.fromARGB(255, 92, 111, 136),
                      ),
                    ),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Баталгаажсан',
                      style: TextStyle(
                        fontWeight: FontWeight.bold, 
                        fontFamily: 'Mogul3',
                        color: Color.fromARGB(255, 92, 111, 136),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ..._getApplianceRequests().map((request) {
              return TableRow(
                children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(request['name']),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(request['huselt'].toString()),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(request['batalga'].toString()),
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
// appliance_req_table.dart
import 'package:flutter/material.dart';

class ApplianceReqTable extends StatefulWidget {
  final String selectedDuration;
  final Function(String?) onDurationChanged;
  final List<Map<String, dynamic>> acceptedRequests;

  const ApplianceReqTable({
    Key? key,
    required this.selectedDuration,
    required this.onDurationChanged,
    required this.acceptedRequests,
  }) : super(key: key);

  @override
  _ApplianceReqTableState createState() => _ApplianceReqTableState();
}

class _ApplianceReqTableState extends State<ApplianceReqTable> {
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
                      'Тоо ширхэг',
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
                      'Код',
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
            ...(widget.acceptedRequests.isNotEmpty
                ? [
                    TableRow(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                      ),
                      children: [
                        const TableCell(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Баталгаажсан хүсэлтүүд',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Mogul3',
                              ),
                            ),
                          ),
                        ),
                        const TableCell(
                          child: SizedBox.shrink(),
                        ),
                        const TableCell(
                          child: SizedBox.shrink(),
                        ),
                      ],
                    ),
                    ...widget.acceptedRequests.map((request) {
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
                              child: Text(request['quantity'].toString()),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(request['code']),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ]
                : []),
          ],
        ),
      ],
    );
  }
}
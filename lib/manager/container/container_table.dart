import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../provider/table_provider.dart';

class ContainerTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tableDataProvider = Provider.of<TableDataProvider>(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 12),
          const SizedBox(height: 16),
          Table(
            children: [
              TableRow(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 225, 244, 255),
                ),
                children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '  Зураг',
                        style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Mogul3'),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '  Нэр',
                        style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Mogul3'),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '  Код',
                        style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Mogul3'),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '  Тоо',
                        style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Mogul3'),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '  Үнэ',
                        style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Mogul3'),
                      ),
                    ),
                  ),
                ],
              ),
              ...tableDataProvider.tableData.map((item) {
                return TableRow(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 225, 244, 255),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          item['imagePath'] ?? '',
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(item['name'] ?? ''),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(item['code'] ?? ''),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(item['quantity']?.toString() ?? ''),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(item['price']?.toString() ?? ''),
                    ),
                  ],
                );
              }).expand((row) sync* {
                yield row;
                yield TableRow(children: [
                  SizedBox(height: 4),
                  SizedBox(height: 4),
                  SizedBox(height: 4),
                  SizedBox(height: 4),
                  SizedBox(height: 4),
                ]);
              }).toList(),
            ],
          ),
        ],
      ),
    );
  }
}
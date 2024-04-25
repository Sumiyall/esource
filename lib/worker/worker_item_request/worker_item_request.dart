import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../provider/item_request_provider.dart';

class WorkerItemRequestPage extends StatefulWidget {
  const WorkerItemRequestPage({Key? key}) : super(key: key);

  @override
  _WorkerItemRequestPageState createState() => _WorkerItemRequestPageState();
}

class _WorkerItemRequestPageState extends State<WorkerItemRequestPage> {
  List<Map<String, dynamic>> items = [];
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTableData();
  }

  Future<void> _loadTableData() async {
    final jsonString = await rootBundle.loadString('assets/json/table_data.json');
    final jsonData = json.decode(jsonString) as List<dynamic>;
    setState(() {
      items = jsonData.map((item) => {
        ...item as Map<String, dynamic>,
        'requestedQuantity': 0,
      }).toList();
    });
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Worker Item Requests'),
      ),
      body: Column(
        children: [
          Expanded(
            child: items.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return ListTile(
                        leading: Image.asset(
                          item['imagePath'],
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(item['name']),
                        subtitle: Text('Code: ${item['code']}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                if (item['requestedQuantity'] > 0) {
                                  setState(() {
                                    item['requestedQuantity']--;
                                  });
                                }
                              },
                            ),
                            Text(item['requestedQuantity'].toString()),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                if (item['requestedQuantity'] < item['quantity']) {
                                  setState(() {
                                    item['requestedQuantity']++;
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Handle submit button press
                final description = _descriptionController.text.trim();
                _submitRequest(description, context);
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }

  void _submitRequest(String description, BuildContext context) {
    final itemRequestProvider = Provider.of<ItemRequestProvider>(context, listen: false);
    final requestedItems = items.where((item) => item['requestedQuantity'] > 0).toList();

    if (requestedItems.isNotEmpty) {
      for (var item in requestedItems) {
        final request = {
          'name': item['name'],
          'code': item['code'],
          'quantity': item['requestedQuantity'],
          'price': item['price'],
          'imagePath': item['imagePath'],
          'description': description,
        };
        itemRequestProvider.addRequest(request);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Хүсэлт амжилттай илгээгдлээ')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Хүсэлт илгээхийн өмнө бараа сонгоно уу')),
      );
    }
  }
}
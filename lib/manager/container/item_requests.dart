// item_request.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/table_provider.dart';
import '../../provider/item_request_provider.dart';

class ItemRequestPage extends StatefulWidget {
  const ItemRequestPage({Key? key}) : super(key: key);

  @override
  _ItemRequestPageState createState() => _ItemRequestPageState();
}

class _ItemRequestPageState extends State<ItemRequestPage> {
  List<Map<String, dynamic>> acceptedRequests = [];

  @override
  Widget build(BuildContext context) {
    final itemRequestProvider = Provider.of<ItemRequestProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ирсэн хүсэлтүүд',
          style: TextStyle(fontFamily: 'Mogul3', fontSize: 28),
        ),
        automaticallyImplyLeading: true,
      ),
      body: itemRequestProvider.pendingRequests.isEmpty
          ? const Center(child: Text('Хүсэлт байхгүй байна'))
          : ListView.builder(
              itemCount: itemRequestProvider.pendingRequests.length,
              itemBuilder: (context, index) {
                final item = itemRequestProvider.pendingRequests[index];
                return ListTile(
                  leading: Image.asset(item['imagePath']),
                  title: Text(item['name']),
                  subtitle: Text(
                      'Code: ${item['code']}, Quantity: ${item['quantity']}, Price: ${item['price']}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () =>
                            acceptItemRequest(item, itemRequestProvider),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color(0xFF4894FE),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 24.0),
                        ),
                        child: const Text('Тийм'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () =>
                            rejectItemRequest(item, itemRequestProvider),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color.fromARGB(255, 255, 35, 35),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 24.0),
                        ),
                        child: const Text('Үгүй'),
                      ),
                    ],
                  ),
                  onTap: () => showRequestDetails(item),
                );
              },
            ),
    );
  }

  Future<void> acceptItemRequest(Map<String, dynamic> item,
      ItemRequestProvider itemRequestProvider) async {
    try {
      final tableDataProvider =
          Provider.of<TableDataProvider>(context, listen: false);
      tableDataProvider.addItemToTableData(item);

      itemRequestProvider.removeRequest(item);

      // Add the accepted request to the acceptedRequests list
      final acceptedRequest = {
        'name': item['name'],
        'quantity': item['quantity'],
        'code': item['code'],
      };
      acceptedRequests.add(acceptedRequest);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Хүсэлтийг зөвшөөрөн агуулах хэсэгт нэмэгдлээ')),
      );
    } catch (error) {
      print('Алдаа гарлаа: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Хүсэлтийг зөвшөөрөхөд алдаа гарлаа')),
      );
    }
  }

  void rejectItemRequest(
      Map<String, dynamic> item, ItemRequestProvider itemRequestProvider) {
    itemRequestProvider.removeRequest(item);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Хүсэлт цуцлагдлаа')),
    );
  }

  void showRequestDetails(Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(item['name']),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Code: ${item['code']}'),
            Text('Quantity: ${item['quantity']}'),
            Text('Price: ${item['price']}'),
            const SizedBox(height: 16),
            Text('Description: ${item['description'] ?? 'No description'}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

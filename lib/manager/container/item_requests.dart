import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../provider/table_provider.dart';
import '../../provider/item_request_provider.dart';



class ItemRequestPage extends StatefulWidget {
  const ItemRequestPage({Key? key}) : super(key: key);

  @override
  _ItemRequestPageState createState() => _ItemRequestPageState();
}

class _ItemRequestPageState extends State<ItemRequestPage> {
  List<Map<String, dynamic>> _pendingRequests = [];

  @override
  void initState() {
    super.initState();
    fetchItemRequests();
  }

  Future<void> fetchItemRequests() async {
    await Future.delayed(const Duration(seconds: 0));
    List<Map<String, dynamic>> itemRequests = [
      {
        'name': 'Бараа 1',
        'code': '#00001',
        'quantity': 10,
        'price': 1000,
        'imagePath': 'assets/images/light.jpg',
      },
      {
        'name': 'Item 2',
        'code': '#00002',
        'quantity': 5,
        'price': 2000,
        'imagePath': 'assets/images/light.jpg',
      },
    ];
    setState(() {
      _pendingRequests = itemRequests;
    });
  }

  Future<void> acceptItemRequest(Map<String, dynamic> item) async {
    try {
      final tableDataProvider = Provider.of<TableDataProvider>(context, listen: false);
      tableDataProvider.addItemToTableData(item);

      setState(() {
        _pendingRequests.remove(item);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Хүсэлтийг зөвшөөрөн агуулах хэсэгт нэмэгдлээ')),
      );
    } catch (error) {
      print('Алдаа гарлаа: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Хүсэлтийг зөвшөөрөхөд алдаа гарлаа')),
      );
    }
  }

  void rejectItemRequest(Map<String, dynamic> item) {
    setState(() {
      _pendingRequests.remove(item);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Хүсэлт цуцлагдлаа')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ирсэн хүсэлтүүд',
          style: TextStyle(fontFamily: 'Mogul3', fontSize: 28),
        ),
        automaticallyImplyLeading: true,
      ),
      body: ListView.builder(
        itemCount: _pendingRequests.length,
        itemBuilder: (context, index) {
          final item = _pendingRequests[index];
          return ListTile(
            leading: Image.asset(item['imagePath']),
            title: Text(item['name']),
            subtitle: Text('Code: ${item['code']}, Quantity: ${item['quantity']}, Price: ${item['price']}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () => acceptItemRequest(item),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF4894FE), 
                    onPrimary: Colors.white, 
                    shape: RoundedRectangleBorder( 
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 24.0), 
                  ),
                  child: const Text('Тийм'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => rejectItemRequest(item),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 255, 35, 35), 
                    onPrimary: Colors.white, 
                    shape: RoundedRectangleBorder( 
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 24.0), 
                  ),
                  child: const Text('Үгүй'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
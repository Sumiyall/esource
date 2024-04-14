import 'package:flutter/material.dart';
import 'container/container_table.dart';

class ContainerPage extends StatefulWidget {
  const ContainerPage({Key? key}) : super(key: key);

  @override
  _ContainerPageState createState() => _ContainerPageState();
}

class _ContainerPageState extends State<ContainerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Агуулах',
          style: TextStyle(fontFamily: 'Mogul3', fontSize: 28),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RequestPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 72, 148, 254),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ).copyWith(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white)
                  ),
                  icon: const Icon(Icons.add_box_outlined),
                  label: const Text(
                    'Хүсэлт гаргах',
                    style: TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'Mogul3'),
                  ),
                ),
                
                const SizedBox(width: 18),

                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(118, 123, 173, 243).withOpacity(0.1),
                          spreadRadius: 8,
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Хайх',
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey[400],
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color.fromARGB(255, 72, 148, 254), width: 0.7),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onChanged: (value) {
                        // handle hiih 
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
          ),
          ContainerTable(),
        ],
      ),
    );
  }
}

class RequestPage extends StatelessWidget {
  const RequestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Request'),
      ),
      body: const Center(
        child: Text('This is the request page'),
      ),
    );
  }
}

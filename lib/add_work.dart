import 'package:flutter/material.dart';
import 'undsen.dart';
import 'package:esource/work/work_req_table.dart';
import 'package:esource/work/appliance_req_table.dart';

class AddWorkPage extends StatefulWidget {
  const AddWorkPage({Key? key}) : super(key: key);

  @override
  _AddWorkPageState createState() => _AddWorkPageState();
}

class _AddWorkPageState extends State<AddWorkPage> {
  String _selectedDuration = 'Сүүлийн 7 хоног';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ажил',
          style: TextStyle(fontFamily: 'Mogul3', fontSize: 28),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Ажил бүртгэх',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCategoryCard('assets/images/addWork/ger1.png', 'Гэр ахуй'),
                  _buildCategoryCard('assets/images/addWork/tech.png', 'Технологи'),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCategoryCard('assets/images/addWork/gadna.png', 'Гадна талбай'),
                  _buildCategoryCard('assets/images/addWork/ger1.png', 'Технологи'),
                ],
              ),


              WorkRequestsTable(
                selectedDuration: _selectedDuration,
                onDurationChanged: (String? newValue) {
                  setState(() {
                    _selectedDuration = newValue!;
                  });
                },
              ),

              ApplianceReqTable(
                selectedDuration: _selectedDuration,
                onDurationChanged: (String? newValue) {
                  setState(() {
                    _selectedDuration = newValue!;
                  });
                },
              ),


            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(String imagePath, String title) {
    return GestureDetector(
      onTap: () {
        // Navigate to another page here
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UndsenPage()),
        );
      },
      child: Column(
        children: [
          Container(
            width: 155,
            height: 92,
            decoration: BoxDecoration(
              border: Border.all(
                color: Color.fromARGB(255, 28, 100, 225),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Transform.scale(
                scale: 1.1,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 28, 100, 225),
            ),
          ),
        ],
      ),
    );
  }
}
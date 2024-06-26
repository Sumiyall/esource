import 'package:flutter/material.dart';
import 'undsen.dart';
import 'package:esource/manager/work/work_req_table.dart';
import 'package:esource/manager/work/appliance_req_table.dart';
import 'work/home_appliance/add_home_work.dart';
import 'work/tech_appliance/add_tech_work.dart';
import 'work/outdoor_appliance/add_out_work.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';
import '../provider/item_request_provider.dart';
import '../provider/job_request_provider.dart';

class AddWorkPage extends StatefulWidget {
  final List<Map<String, dynamic>> acceptedRequests;

  const AddWorkPage({Key? key, this.acceptedRequests = const []})
      : super(key: key);

  @override
  _AddWorkPageState createState() => _AddWorkPageState();
}

class _AddWorkPageState extends State<AddWorkPage> {
  String _selectedDuration = 'Сүүлийн 7 хоног';

  @override
  Widget build(BuildContext context) {
    final itemRequestProvider = Provider.of<ItemRequestProvider>(context);
    final jobRequestProvider = Provider.of<JobRequestProvider>(context);

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
                workerJobRequests: jobRequestProvider.jobRequests,
              ),
              ApplianceReqTable(
                selectedDuration: _selectedDuration,
                onDurationChanged: (String? newValue) {
                  setState(() {
                    _selectedDuration = newValue!;
                  });
                },
                acceptedRequests: widget.acceptedRequests,
                itemRequests: itemRequestProvider.pendingRequests,
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
        if (title == 'Гэр ахуй') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddHomeWorkPage()),
          );
        } else if (title == 'Технологи') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTechWorkPage()),
          );
        } else if (title == 'Гадна талбай') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddOutWorkPage()),
          );
        } else {
          // Handle other cases if needed
        }
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
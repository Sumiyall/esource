import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/task_provider.dart';

class MyWorkPage extends StatelessWidget {
  const MyWorkPage({Key? key}) : super(key: key);

  void _showWorkDetails(BuildContext context, Map<String, dynamic> task) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(task['name']!),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12),
                Text(
                  'Утасны дугаар: ${task['phone']}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Гэрийн хаяг: ${task['address']}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 24),
                Text(
                  'Засвар хийлгэх хэрэгслийн тодорхойлолт',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Төрөл: ${task['type']}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Бренд: ${task['brand']}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Загвар: ${task['model']}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Дугаар: ${task['number']}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 24),
                Text(
                  'Тайлбар',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  task['description']!,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 24),
                Text(
                  'Ангилал',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  task['category']!,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Хаах'),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle job request logic here
                // You can show a dialog or navigate to a confirmation page
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Ажил хүсэлт'),
                      content: Text('Та энэ ажлыг хүсэх үү?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Үгүй'),
                        ),
                        TextButton(
                          onPressed: () {
                            // Perform the job request logic here
                            Navigator.pop(context);
                          },
                          child: Text('Тийм'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Ажил хүсэх'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final tasks = taskProvider.tasks;

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
                'Ажлын хүсэлт гаргах',
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
              const SizedBox(height: 24),
              const Text(
                'Ажлын хүсэлтүүд',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: tasks.length,
                itemBuilder: (BuildContext context, int index) {
                  final task = tasks[index];
                  return GestureDetector(
                    onTap: () {
                      _showWorkDetails(context, task);
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        title: Text(
                          task['name']!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          task['description']!,
                          style: TextStyle(fontSize: 14),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  );
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
        // Handle category card tap
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
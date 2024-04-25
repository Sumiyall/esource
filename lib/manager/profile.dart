import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class ProfilePage extends StatefulWidget {
  final int userId;

  const ProfilePage({Key? key, required this.userId}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _userName = '';
  String _userPhone = '';

  @override
  void initState() {
    super.initState();
    _fetchUserData(widget.userId);
  }

  Future<void> _fetchUserData(int userId) async {
    final databaseRef = FirebaseDatabase.instance.reference();
    final userRef =
        databaseRef.child('users').orderByChild('id').equalTo(userId);

    final snapshot = await userRef.once();
    if (snapshot.snapshot.value != null) {
      print('orloo1');
      final userData =
          (snapshot.snapshot.value as Map<dynamic, dynamic>).values.first;
      setState(() {
        _userName = userData['name'] ?? '';
        _userPhone = userData['phoneNo']?.toString() ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Профайл',
          style: TextStyle(fontFamily: 'Mogul3', fontSize: 28),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),
            const CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('assets/images/image.png'),
            ),
            const SizedBox(height: 16),
            Text(
              _userName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Software Engineer',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text('Email'),
              subtitle: const Text('johndoe@example.com'),
              onTap: () {
                // Handle email tap
              },
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text('Phone'),
              subtitle: Text(_userPhone),
              onTap: () {
                // Handle phone tap
              },
            ),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: const Text('Location'),
              subtitle: const Text('San Francisco, CA'),
              onTap: () {
                // Handle location tap
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Handle edit profile button tap
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Edit Profile',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

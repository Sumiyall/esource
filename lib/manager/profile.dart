import 'package:esource/manager/login.dart';
import 'package:esource/manager/report_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class ProfilePage extends StatefulWidget {
  final String userEmail;
  const ProfilePage({Key? key, required this.userEmail}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _userName = '';
  String _userPhoneNumber = '';

  @override
  void initState() {
    super.initState();
    _fetchUserName();
  }

  Future<void> _fetchUserName() async {
    final databaseUrl = 'https://esource-bed3f-default-rtdb.asia-southeast1.firebasedatabase.app';
    final databaseRef = FirebaseDatabase(databaseURL: databaseUrl).reference();
    DatabaseReference userRef = databaseRef.child('users');

    userRef.orderByChild('email').equalTo(widget.userEmail).onChildAdded.listen((event) {
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.exists) {
        Map<dynamic, dynamic> userData = snapshot.value as Map<dynamic, dynamic>;
        setState(() {
          _userName = userData['name'] ?? '';
          _userPhoneNumber = userData['phoneNo']?.toString() ?? '';
        });
      }
    });
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
              subtitle: Text(widget.userEmail),
              onTap: () {
                // Handle email tap
              },
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text('Утас'),
              subtitle: Text(_userPhoneNumber),
              onTap: () {
                // Handle phone tap
              },
            ),
            ListTile(
              leading: const Icon(Icons.note_add),
              title: const Text('Тайлан'),
              subtitle: const Text('Ажлын гүйцэтгэлийн тайлан үзэх'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReportPage(userEmail: widget.userEmail)),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.note_alt),
              title: const Text('Тайлан'),
              subtitle: const Text('Материалын тайлан үзэх'),
              onTap: () {
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Гарах',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'login.dart';
import 'test/booking.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      // home: HomePage(),
      // home: Booking(),
      home: LoginPage(),
    );
  }
}
import 'package:esource/manager/home_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            Image.asset('assets/images/logopng.png', 
              width: 300,
              height: 140,
            ),
            const SizedBox(height: 26),
            const Text(
              'E-Resource',
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'Mogul3',
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),
            TextField(
              decoration: InputDecoration(
                labelText: 'Менежерийн нэр',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.grey.withOpacity(0.5), 
                    width: 1.0, 
                  ),
                ),
                filled: true,
                fillColor: Color.fromARGB(255, 255, 255, 255),
                prefixIcon: Icon(Icons.person_outline_sharp),
              ),
            ),




            SizedBox(height: 16),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Нууц үг',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0), 
                  borderSide: BorderSide( 
                    color: Colors.grey, 
                    width: 2.0, 
                  ),
                ),
                filled: true,
                fillColor: Color.fromARGB(255, 255, 255, 255), 
                prefixIcon: Icon(Icons.lock_person),
              ),
            ),

            const SizedBox(height: 16),
            TextButton(
              onPressed: (){
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()), 
              );
              } ,
              child: Text(
                'Нууц үгээ мартсан уу?',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: (){
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()), 
              );
              } ,
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 28, 100, 225),
                minimumSize: const Size(double.infinity, 58),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Нэвтрэх',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),

            const SizedBox(height: 26),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Эсвэл',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Expanded(
                  child: Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 26),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    // Handle Facebook login
                  },
                  icon: Image.asset(
                    'assets/images/facebookIcon.png',
                    width: 44,
                    height: 44,
                  ),
                ),
                const SizedBox(width: 16),
                IconButton(
                  onPressed: () {
                    // Handle Google login
                  },
                  icon: Image.asset(
                    'assets/images/googleIcon.png',
                    width: 44,
                    height: 44,
                  ),
                ),
                const SizedBox(width: 16),
                IconButton(
                  onPressed: () {
                    // Handle Apple login
                  },
                  icon: Image.asset(
                    'assets/images/appleIcon.png',
                    width: 44,
                    height: 44,
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
      ),
    );
    
  }
}
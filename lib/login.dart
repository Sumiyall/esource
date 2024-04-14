import 'package:esource/home_page.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            Image.asset('assets/images/logo1.png', 
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
                labelText: 'Хэрэглэгчийн нэр',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.grey.withOpacity(0.5), // Adjust opacity to make it lighter
                    width: 1.0, // Decrease width to make it thinner
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
                  borderRadius: BorderRadius.circular(10.0), // Set border radius
                  borderSide: BorderSide( // Customize border thickness and color
                    color: Colors.grey, // Change to the desired border color
                    width: 2.0, // Adjust the border thickness
                  ),
                ),
                filled: true,
                fillColor: Color.fromARGB(255, 255, 255, 255), // Change to the desired background color
                prefixIcon: Icon(Icons.lock_person), // Add an icon to the left of the input field
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
// worker's login
import 'home_page1.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage1 extends StatefulWidget {
  const LoginPage1({Key? key}) : super(key: key);

  @override
  _LoginPage1State createState() => _LoginPage1State();
}

class _LoginPage1State extends State<LoginPage1> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  userLogin() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // User is signed in
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage1(userEmail: _emailController.text),
          settings: RouteSettings(name: '/worker/home'),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        content: Text(
          "Амжилттай нэвтэрлээ",
          style: TextStyle(fontSize: 18.0),
        ),
      ));
    } on FirebaseAuthException catch (e) {
      String errorMessage = "";
      if (e.code == 'user-not-found') {
        errorMessage = "Имэйл олдсонгүй";
      } else if (e.code == 'wrong-password') {
        errorMessage = "Нууц үг буруу байна";
      } else {
        errorMessage = "Нэвтрэхэд алдаа гарлаа";
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          errorMessage,
          style: TextStyle(fontSize: 18.0),
        ),
      ));
    }
  }

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
              Image.asset(
                'assets/images/logopng.png',
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
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Ажилтны имэйл',
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
                controller: _passwordController,
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            HomePage1(userEmail: _emailController.text)),
                  );
                },
                child: Text(
                  'Нууц үгээ мартсан уу?',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: userLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 28, 100, 225),
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

              const SizedBox(height: 40),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    // side: BorderSide(color: Color.fromARGB(255, 28, 100, 225), width: 2),
                  ),
                ),
                child: const Text(
                  'Буцах',
                  style: TextStyle(
                    color: Color.fromARGB(255, 28, 100, 225),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

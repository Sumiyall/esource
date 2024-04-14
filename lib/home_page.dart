import 'package:flutter/material.dart';
import 'add_work.dart';
import 'container.dart';
import 'profile.dart';
import 'undsen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const UndsenPage(),
    const AddWorkPage(),
    const ContainerPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: Color(0xFF4894FE),

        selectedIconTheme: IconThemeData(
          size: 30, // Adjust the size of the selected icon
          color: Color(0xFF4894FE), // Adjust the color of the selected icon
        ),
        unselectedIconTheme: IconThemeData(
          size: 24, // Adjust the size of the unselected icons
          color: Colors.grey, // Adjust the color of the unselected icons
        ),

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, ),
            label: "Нүүр",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Ажил',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.warehouse),
            label: 'Агуулах',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Хэрэглэгч',
          ),
        ],
      ),
    );
  }
}
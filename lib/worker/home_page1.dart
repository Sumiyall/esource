import 'package:flutter/material.dart';
import 'my_work.dart';
import '../manager/container.dart';
import 'profile1.dart';
import 'undsen1.dart';
import 'profile1.dart';
// import 'work/home_appliance/add_home_work1.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const UndsenPage1(),
    const MyWorkPage(),
    const ContainerPage(),
    const ProfilePage1(),
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
          size: 30, 
          color: Color(0xFF4894FE), 
        ),
        unselectedIconTheme: IconThemeData(
          size: 24, 
          color: Colors.grey, 
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
import 'package:flutter/material.dart';
import 'my_work.dart';
import '../manager/container.dart';
import 'profile1.dart';
import 'undsen1.dart';
import 'profile1.dart';
// import 'work/home_appliance/add_home_work1.dart';


class HomePage1 extends StatefulWidget {
  final String userEmail;

  const HomePage1({Key? key, required this.userEmail}) : super(key: key);

  @override
  _HomePage1State createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  int _selectedIndex = 0;

  List<Widget> get _pages => [
        UndsenPage1(userEmail: widget.userEmail),
        MyWorkPage(),
        ContainerPage(),
        ProfilePage1(userEmail: widget.userEmail),
      ];
    // const UndsenPage1(),
    // const MyWorkPage(),
    // const ContainerPage(),
    // const ProfilePage1(),
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Scaffold(
                  body: ContainerPage(),
                  bottomNavigationBar: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    currentIndex: index,
                    onTap: (newIndex) {
                      if (newIndex != index) {
                        Navigator.pop(context);
                        setState(() {
                          _selectedIndex = newIndex;
                        });
                      }
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
                        icon: Icon(Icons.home),
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
                ),
                settings: RouteSettings(arguments: false),
              ),
            );
          } else {
            setState(() {
              _selectedIndex = index;
            });
          }
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
            icon: Icon(Icons.home),
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
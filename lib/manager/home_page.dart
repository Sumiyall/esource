import 'package:flutter/material.dart';
import 'add_work.dart';
import '../manager/container.dart';
import 'profile.dart';
import 'undsen.dart';

class HomePage extends StatefulWidget {
  final String userEmail;
  const HomePage({Key? key, required this.userEmail}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  List<Widget> get _pages => [
        UndsenPage(userEmail: widget.userEmail),
        AddWorkPage(),
        ContainerPage(),
        ProfilePage(userId: _getUserIdFromEmail(widget.userEmail)),
      ];

  int _getUserIdFromEmail(String email) {
    // Implement your logic to retrieve the user ID based on the email
    // For example, you can query the Firebase Realtime Database to get the user ID
    // Return the user ID as an integer
    // Placeholder implementation:
    return 1;
  }

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
                settings: RouteSettings(arguments: true),
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

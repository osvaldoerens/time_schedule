import 'package:flutter/material.dart';
import 'package:testmobile_flutter/test1/profile/profile_screen.dart';
import 'package:testmobile_flutter/test2/notes_list_screen.dart';

class HomeScreen extends StatefulWidget {

  final dynamic dataLogin;
  const HomeScreen({Key? key,this.dataLogin}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedNavbar = 0;

  void _changeSelectedNavBar(int index) {
    setState(() {
      _selectedNavbar = index;
    });
  }



  @override
  Widget build(BuildContext context) {

    List widgets = [
      ProfileScreen(dataLogin: widget.dataLogin),
      const NoteListScreen()
    ];

    return Scaffold(
      body: widgets[_selectedNavbar],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined),label: 'Profil'),
          BottomNavigationBarItem(icon: Icon(Icons.note_alt_outlined), label: 'Notes')
        ],
        currentIndex: _selectedNavbar,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: _changeSelectedNavBar,
      ),
    );
  }
}
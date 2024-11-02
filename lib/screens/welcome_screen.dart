import 'package:dynamic_form_generator/provider/updates_provider.dart';
import 'package:dynamic_form_generator/screens/main_screen.dart';
import 'package:dynamic_form_generator/screens/profile_page.dart';
import 'package:dynamic_form_generator/screens/updates_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final updatesProvider = Provider.of<UpdatesProvider>(context);
    final notificationCount = updatesProvider.getTotalNotificationCount();

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.black,
        items: [
          const BottomNavigationBarItem(
              icon: Icon(Icons.grid_view_outlined), label: "Home"),
          BottomNavigationBarItem(
              icon: Badge(
                label: Text(notificationCount.toString()),
                child: const Icon(FontAwesomeIcons.comments),
              ),
              label: "Update"),
          const BottomNavigationBarItem(
              icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          const MainScreen(),
          UpdatesPage(notificationCount: notificationCount),
          const ProfilePage()
        ],
      ),
    );
  }
}

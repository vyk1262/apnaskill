import 'package:apnaskill/constants/colors.dart';
import 'package:apnaskill/home.dart';
import 'package:apnaskill/screens/courses.dart';
import 'package:apnaskill/screens/register.dart';
import 'package:flutter/material.dart';

class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  String selectedScreen = 'Home'; // Default selected screen

  // Update the selected screen
  void onSelectScreen(String screen) {
    setState(() {
      selectedScreen = screen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onSelectScreen: onSelectScreen,
        selectedScreen: selectedScreen,
      ),
      body: _getSelectedScreenWidget(selectedScreen),
    );
  }

  // Return the correct widget based on the selected screen
  Widget _getSelectedScreenWidget(String screen) {
    switch (screen) {
      case 'Home':
        return HomePage();
      case 'Courses':
        return Courses();
      case 'Register':
        return AuthScreen();
      default:
        return HomePage();
    }
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function(String) onSelectScreen;
  final String selectedScreen;

  CustomAppBar({required this.onSelectScreen, required this.selectedScreen});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      flexibleSpace: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 80),
                Image.asset(
                  'assets/sfls.png',
                  width: 70,
                  height: 70,
                  fit: BoxFit.contain,
                ),
                Text('Skill Factorial'),
                Spacer(),
                _buildNavButton(context, label: 'Home', screenName: 'Home'),
                _buildNavButton(context,
                    label: 'Courses', screenName: 'Courses'),
                _buildNavButton(context,
                    label: 'Login →', screenName: 'Register'),
                SizedBox(width: 80),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavButton(BuildContext context,
      {required String label, required String screenName}) {
    bool isSelected = selectedScreen == screenName;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextButton(
        onPressed: () => onSelectScreen(screenName),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.blue : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: isSelected ? 24 : 20,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(70);
}

import 'package:apnaskill/home.dart';
import 'package:apnaskill/screens/contact.dart';
import 'package:apnaskill/screens/courses.dart';
import 'package:apnaskill/screens/faqs.dart';
import 'package:apnaskill/screens/explore.dart';
import 'package:apnaskill/screens/python.dart';
import 'package:apnaskill/screens/internships.dart';
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
      body: _getSelectedScreenWidget(
          selectedScreen), // Dynamically update body based on selected screen
    );
  }

  // Return the correct widget based on the selected screen
  Widget _getSelectedScreenWidget(String screen) {
    switch (screen) {
      case 'Home':
        return HomePage();
      case 'Courses':
        return Courses();
      case 'Explore':
        return InternshipsHome();
      case 'FAQs':
        return FaqsScreen();
      case 'Contact':
        return ContactScreen();
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
      backgroundColor: Colors.white, // Optional: gives a more modern look
      automaticallyImplyLeading: false, // Hide default back button
      flexibleSpace: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 16.0), // Add padding around the content
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Center the content vertically
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Image.asset(
                //   'assets/apna-bg.png',
                //   width: 100,
                //   height: 80,
                //   fit: BoxFit.contain,
                // ),
                Text('APNA SKILL'),
                Spacer(),
                _buildNavButton(context, label: 'Home', screenName: 'Home'),
                _buildNavButton(context,
                    label: 'Courses', screenName: 'Courses'),
                _buildNavButton(context,
                    label: 'Explore', screenName: 'Explore'),
                _buildNavButton(context, label: 'FAQs', screenName: 'FAQs'),
                _buildNavButton(context,
                    label: 'Register/Login', screenName: 'Register'),
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
      padding: const EdgeInsets.symmetric(
          horizontal: 8.0), // Spacing between buttons
      child: TextButton(
        onPressed: () => onSelectScreen(screenName),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.blue : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(80); // Adjusted height for a better fit
}

import 'package:flutter/material.dart';
import 'package:apnaskill/home.dart';
import 'package:apnaskill/programs.dart';
import 'package:apnaskill/about.dart';
import 'package:apnaskill/contact.dart';
import 'package:apnaskill/register.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  Header({Key? key})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('ApnaSkill'),
      actions: [
        HeaderButton(
            text: 'Home',
            onTap: () => navigateToScreen(context, const HomePage())),
        HeaderButton(
            text: 'Programs',
            onTap: () => navigateToScreen(context, ProgramsScreen())),
        HeaderButton(
            text: 'About',
            onTap: () => navigateToScreen(context, AboutScreen())),
        HeaderButton(
            text: 'Contact',
            onTap: () => navigateToScreen(context, ContactScreen())),
        HeaderButton(
            text: 'Register Now',
            onTap: () => navigateToScreen(context, RegisterScreen())),
      ],
    );
  }
}

class HeaderButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const HeaderButton({Key? key, required this.text, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

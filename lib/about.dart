import 'package:apnaskill/widgets/header.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: const Center(child: Text('About Screen')),
    );
  }
}

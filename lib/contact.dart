import 'package:apnaskill/widgets/header.dart';
import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: const Center(child: Text('Contact Screen')),
    );
  }
}

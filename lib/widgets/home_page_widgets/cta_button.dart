import 'package:flutter/material.dart';

Widget buildCtaButton(String text) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF4A90E2),
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
    ),
    onPressed: () {},
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 20,
        color: Colors.white,
      ),
    ),
  );
}

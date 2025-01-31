import 'package:flutter/material.dart';

void navigateTo(BuildContext context, Widget destinationScreen,
    {bool replace = false}) {
  if (replace) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => destinationScreen),
    );
  } else {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => destinationScreen),
    );
  }
}

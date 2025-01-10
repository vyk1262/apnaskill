import 'package:flutter/material.dart';

Widget buildTextCard(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12.0),
    child: Card(
      elevation: 10, // Stronger shadow effect for depth
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(20), // More rounded corners for elegance
      ),
      color: Colors.white,
      shadowColor: Colors.blueGrey, // Adjust shadow color for better contrast
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purpleAccent, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18, // Slightly larger font for better readability
              fontWeight:
                  FontWeight.w600, // Lighter weight for more sophistication
              color: Colors
                  .white, // Text color that contrasts nicely with the background
              letterSpacing:
                  1.2, // Adding space between letters for better readability
            ),
          ),
        ),
      ),
    ),
  );
}

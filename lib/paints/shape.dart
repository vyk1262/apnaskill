import 'package:flutter/material.dart';

class ShapeBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.teal,
            borderRadius: BorderRadius.circular(20),
          ),
          margin: EdgeInsets.only(top: 50, left: 50),
          width: 200,
          height: 200,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.circular(30),
          ),
          margin: EdgeInsets.only(top: 100, right: 50),
          width: 250,
          height: 250,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(40),
          ),
          margin: EdgeInsets.only(bottom: 50, left: 50),
          width: 300,
          height: 300,
        ),
      ],
    );
  }
}

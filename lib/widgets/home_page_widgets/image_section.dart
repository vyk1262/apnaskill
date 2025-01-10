import 'package:flutter/material.dart';

class ImageSectionOne extends StatelessWidget {
  const ImageSectionOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(12),
        bottomRight: Radius.circular(12),
      ),
      child: Image.asset(
        'assets/book_shelf.png',
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
      ),
    );
  }
}

class ImageSectionTwo extends StatelessWidget {
  const ImageSectionTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/it2.png',
      // width: double.infinity,
      // height: 550,
      fit: BoxFit.fill,
    );
  }
}

class ImageSectionThree extends StatelessWidget {
  const ImageSectionThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Image.asset(
        'assets/sfcmp.png',
        height: 300,
        fit: BoxFit.contain,
      ),
    );
  }
}

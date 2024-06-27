import 'package:flutter/material.dart';

class SubjectButton extends StatefulWidget {
  final String subject;
  final VoidCallback onTap;

  const SubjectButton({
    Key? key,
    required this.subject,
    required this.onTap,
  }) : super(key: key);

  @override
  _SubjectButtonState createState() => _SubjectButtonState();
}

class _SubjectButtonState extends State<SubjectButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => isHovered = true),
      onTapUp: (_) => setState(() => isHovered = false),
      onTapCancel: () => setState(() => isHovered = false),
      child: Container(
        decoration: BoxDecoration(
          color: isHovered ? Colors.grey[300] : Colors.blue,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            if (isHovered)
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0, 2),
              ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          widget.subject,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

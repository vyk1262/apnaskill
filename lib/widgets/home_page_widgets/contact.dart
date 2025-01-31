import 'package:flutter/material.dart';
import 'package:skill_factorial/widgets/home_page_widgets/cta_button.dart';

class ContactCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;
  final Widget? child;

  const ContactCard({
    required this.icon,
    required this.title,
    required this.text,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Add consistent padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Center-align content
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 40.0),
            const SizedBox(height: 8.0),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center, // Center-align text
            ),
            const SizedBox(height: 4.0),
            Text(
              text,
              textAlign: TextAlign.center, // Center-align text
            ),
            if (child != null) ...[
              const SizedBox(height: 8.0),
              child!,
            ],
          ],
        ),
      ),
    );
  }
}

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width / 2,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Message',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              maxLines: 5,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your message';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            buildCtaButton(
              text: "Send Message",
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Message Sent - Testing Purpose Only')),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

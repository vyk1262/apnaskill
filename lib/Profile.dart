import 'package:flutter/material.dart';
import 'package:skill_factorial/custom_app_bar.dart';

class Profile extends StatelessWidget {
  final Map<String, dynamic>? userData;

  const Profile({Key? key, required this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile "),
      ),
      body: Center(
        child: userData != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Name: ${userData!['name']}',
                      style: TextStyle(fontSize: 20)),
                  Text('Email: ${userData!['email'] ?? 'N/A'}',
                      style: TextStyle(fontSize: 20)),
                  Text("Name: ${userData!['name']}",
                      style: TextStyle(fontSize: 18)),
                  Text("DOB: ${userData!['dateOfBirth']}",
                      style: TextStyle(fontSize: 18)),
                  Text("Gender: ${userData!['gender']}",
                      style: TextStyle(fontSize: 18)),
                  Text("Email: ${userData!['email']}",
                      style: TextStyle(fontSize: 18)),
                ],
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}

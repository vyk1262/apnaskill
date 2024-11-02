import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Explore extends StatefulWidget {
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _buildLinkTile(String title, String url) {
    return ListTile(
      title: Text(title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      trailing: Icon(Icons.open_in_new, color: Colors.blue),
      onTap: () => _launchURL(url),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Text(
              "Trending Topics",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _buildLinkTile("ChatGPT by OpenAI", "https://chat.openai.com/"),
            _buildLinkTile("Midjourney AI", "https://www.midjourney.com/"),
            _buildLinkTile("Gemini AI by Google", "https://ai.google/"),
            SizedBox(height: 20),
            Text(
              "AI Learning Resources",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _buildLinkTile("Coursera - AI for Everyone",
                "https://www.coursera.org/learn/ai-for-everyone"),
            _buildLinkTile("Deep Learning Specialization by Andrew Ng",
                "https://www.coursera.org/specializations/deep-learning"),
            _buildLinkTile(
                "Fast.ai - Practical Deep Learning", "https://www.fast.ai/"),
            SizedBox(height: 20),
            Text(
              "Development Resources",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _buildLinkTile("Flutter Documentation", "https://flutter.dev/docs"),
            _buildLinkTile("Dart Language Tour",
                "https://dart.dev/guides/language/language-tour"),
            _buildLinkTile(
                "Firebase Documentation", "https://firebase.google.com/docs"),
            SizedBox(height: 20),
            Text(
              "Trending Technologies",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _buildLinkTile("Blockchain Technology",
                "https://www.ibm.com/topics/what-is-blockchain"),
            _buildLinkTile(
                "Quantum Computing", "https://quantum-computing.ibm.com/"),
            _buildLinkTile(
                "5G Technology", "https://www.qualcomm.com/5g/what-is-5g"),
            _buildLinkTile(
                "Augmented Reality (AR)", "https://developers.google.com/ar"),
          ],
        ),
      ),
    );
  }
}

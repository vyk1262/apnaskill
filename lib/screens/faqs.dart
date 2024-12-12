import 'dart:convert';
import 'package:apnaskill/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;

class FaqsScreen extends StatefulWidget {
  @override
  _FaqsScreenState createState() => _FaqsScreenState();
}

class _FaqsScreenState extends State<FaqsScreen> {
  List<dynamic> faqs = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFaqs();
  }

  Future<void> fetchFaqs() async {
    final String response =
        await rootBundle.rootBundle.loadString('assets/faqs.json');
    setState(() {
      faqs = jsonDecode(response)['results'];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("faqs"),
      ),
      body: Column(
        children: [
          SizedBox(height: 40),
          const Text(
            'Frequently Asked Questions',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 40.0),
                    itemCount: faqs.length,
                    itemBuilder: (context, index) {
                      final faq = faqs[index];
                      return Card(
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 50),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ExpansionTile(
                          title: Text(
                            faq['question'],
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor),
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: Text(
                                faq['answer'],
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                          ],
                          trailing: Icon(
                            Icons.arrow_drop_down_circle_rounded,
                            color: Colors.green,
                          ),
                        ),
                      );
                    },
                  ),
          )
        ],
      ),
    );
  }
}

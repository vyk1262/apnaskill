import 'dart:convert';
import 'package:apnaskill/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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

  // Future<void> fetchFaqs() async {
  //   final response = await http.get(Uri.parse(
  //       'https://gist.githubusercontent.com/vyk1262/a0d67e4365be9b7bfc0ed6998aa091a6/raw/a441fa02ba79985fd8333c15af2d93a90f7ac66a/faqs.json'));

  //   if (response.statusCode == 200) {
  //     setState(() {
  //       faqs = jsonDecode(response.body)['results'];
  //       isLoading = false;
  //     });
  //   } else {
  //     throw Exception('Failed to load FAQs');
  //   }
  // }

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

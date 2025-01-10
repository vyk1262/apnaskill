import 'package:flutter/material.dart';

class SuccessStoriesWidget extends StatefulWidget {
  @override
  _SuccessStoriesWidgetState createState() => _SuccessStoriesWidgetState();
}

class _SuccessStoriesWidgetState extends State<SuccessStoriesWidget> {
  // List of success stories
  final List<Map<String, String>> successStories = [
    {
      'content':
          'Skill Factorial in Hyderabad has transformed my learning journey. The courses are comprehensive and the instructors are incredibly supportive. I\'ve gained new skills and confidence to advance my career. Highly recommend!',
      'author': 'Sanjay Rao',
    },
    {
      'content':
          'The hands-on training and real-world projects at Skill Factorial have been invaluable. The instructors go above and beyond to ensure every concept is understood. Great experience!',
      'author': 'Priya Singh',
    },
    {
      'content':
          'I loved the friendly and professional environment at Skill Factorial. Their well-structured courses helped me get placed in a leading company. Truly grateful!',
      'author': 'Rahul Mehta',
    },
    {
      'content':
          'Thanks to Skill Factorial, I’ve been able to pivot my career into a field I’m passionate about. The learning support is top-notch, and I highly recommend it to anyone looking to upskill!',
      'author': 'Anjali Verma',
    },
  ];

  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _goToPage(int index) {
    setState(() {
      _currentPage = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
              child: Text(
                'Success Stories',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemCount: successStories.length,
                    itemBuilder: (context, index) {
                      final story = successStories[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 1.4,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.purpleAccent,
                                    Colors.blueAccent
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                story['content']!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              '- ${story['author']}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Positioned(
                    left: 16.0,
                    child: IconButton(
                      icon:
                          const Icon(Icons.arrow_back_ios, color: Colors.black),
                      onPressed: () {
                        int newIndex =
                            (_currentPage - 1) % successStories.length;
                        if (newIndex < 0) newIndex += successStories.length;
                        _goToPage(newIndex);
                      },
                    ),
                  ),
                  Positioned(
                    right: 16.0,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_forward_ios,
                          color: Colors.black),
                      onPressed: () {
                        int newIndex =
                            (_currentPage + 1) % successStories.length;
                        _goToPage(newIndex);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  successStories.length,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    width: _currentPage == index ? 12 : 8,
                    height: _currentPage == index ? 12 : 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index ? Colors.blue : Colors.black,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

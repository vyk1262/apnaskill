import 'package:flutter/material.dart';

import 'common_widgets/custom_app_bar.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _HeroSection(),
            _FeaturesSection(),
            _HowItWorksSection(),
            _PricingSection(),
            _BenefitsSection(),
            _FAQSection(),
            _FooterSection(),
          ],
        ),
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Text(
          'Master Skills with Quiz-First Learning',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        Text(
          'Practice targeted questions that mirror real interviews and exams. Track progress and build confidence.',
          style: TextStyle(
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 30),
        ElevatedButton(
          onPressed: () {}, // Scroll to pricing or signup
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
          ),
          child: Text(
            'Start Free Booster',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class _FeaturesSection extends StatelessWidget {
  static const List<Map<String, String>> featuresData = [
    {
      "emoji": "🎯",
      "title": "Quiz-First Learning",
      "description":
          "Skip long videos. Practice topic-wise questions that mirror interviews and exams."
    },
    {
      "emoji": "📊",
      "title": "Progress Tracking",
      "description":
          "See your best scores per quiz and improve over time with multiple attempts."
    },
    {
      "emoji": "🧠",
      "title": "Concept Recall",
      "description":
          "Strengthen fundamentals using active recall and spaced practice."
    },
    {
      "emoji": "⚡",
      "title": "Fast Revision",
      "description":
          "Quickly revise core concepts before tests, exams, or interviews."
    },
    {
      "emoji": "🏆",
      "title": "Interview Focused",
      "description":
          "Practice question patterns commonly seen in technical assessments."
    },
    {
      "emoji": "🧩",
      "title": "Topic-Wise Quizzes",
      "description":
          "Break large subjects into small quiz modules and focus where you're weak."
    },
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    int columns;
    if (width < 768) {
      columns = 1;
    } else if (width < 1100) {
      columns = 2;
    } else {
      columns = 3;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width < 768 ? 20 : 60,
        vertical: 80,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFF8F9FA), Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          const Text(
            'Why Choose Skill Factorial?',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            'Designed for faster learning and better results',
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
          const SizedBox(height: 60),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: featuresData.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              crossAxisSpacing: 30,
              mainAxisSpacing: 30,
              childAspectRatio: width < 768 ? 1.4 : 1.2,
            ),
            itemBuilder: (context, index) {
              final feature = featuresData[index];
              return _FeatureCard(
                emoji: feature['emoji']!,
                title: feature['title']!,
                description: feature['description']!,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String description;

  const _FeatureCard({
    required this.emoji,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 30,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 64,
            width: 64,
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                emoji,
                style: const TextStyle(fontSize: 32),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

class _HowItWorksSection extends StatelessWidget {
  static const List<Map<String, String>> stepsData = [
    {
      "step": "01",
      "title": "Pick a Skill",
      "desc": "Select from Java, Python, React, or Core CS fundamentals."
    },
    {
      "step": "02",
      "title": "Take the Quiz",
      "desc": "Solve 10-15 targeted questions in under 10 minutes."
    },
    {
      "step": "03",
      "title": "Review Solutions",
      "desc": "Read explanations for every wrong answer immediately."
    },
    {
      "step": "04",
      "title": "Track Growth",
      "desc": "Watch your skill score improve with every attempt."
    }
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 60,
        vertical: 60,
      ),
      child: Column(
        children: [
          const Text(
            'How It Works',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 60),

          /// 🔥 Responsive Steps Layout
          isMobile
              ? Column(
                  children: List.generate(
                    stepsData.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: _stepCard(
                        stepsData[index],
                        isMobile: true,
                        isLast: index == stepsData.length - 1,
                      ),
                    ),
                  ),
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    stepsData.length,
                    (index) => Expanded(
                      child: _stepCard(
                        stepsData[index],
                        isMobile: false,
                        isLast: index == stepsData.length - 1,
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

Widget _stepCard(
  Map<String, String> step, {
  required bool isMobile,
  required bool isLast,
}) {
  return Column(
    children: [
      Container(
        height: 100,
        width: 100,
        decoration: const BoxDecoration(
          color: Colors.orange,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            step['step']!,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      const SizedBox(height: 20),
      Text(
        step['title']!,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 8),
      Text(
        step['desc']!,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey[600],
          height: 1.5,
        ),
      ),

      /// Connector
      if (!isLast)
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: isMobile
              ? Container(
                  height: 40,
                  width: 2,
                  color: Colors.grey[300],
                )
              : Container(
                  height: 2,
                  width: 50,
                  color: Colors.grey[300],
                ),
        ),
    ],
  );
}

class _PricingSection extends StatelessWidget {
  static const List<Map<String, dynamic>> pricingPlans = [
    {
      "title": "Booster",
      "subtitle": "Quizzes Only · Live Now",
      "currentPrice": "₹0 (FREE)",
      "originalPrice": "₹100",
      "discountPercent": "100% OFF",
      "features": [
        "Access quizzes for your subjects subject",
        "Multiple attempts to improve your score",
        "Progress tracking in your profile",
        "Detailed solutions & explanations",
        "New quizzes added over time",
        "Existing content will be updated regularly",
        "Ideal for quick revision and practice",
      ],
      "buttonText": "Start Booster",
      "isBestValue": true,
      "badgeText": "LIVE",
      "isComingSoon": false,
    },
    {
      "title": "Accelerator",
      "subtitle": "Quizzes + Projects (Coming Soon)",
      "currentPrice": "₹499",
      "originalPrice": "₹1,000",
      "discountPercent": "50% OFF",
      "features": [
        "90-day structured learning",
        "Projects",
        "Projects + practice quizzes",
        "Track your progress in profile section",
        "Advanced capstone projects",
        "Expert mentor guidance",
        "Guided roadmap",
        "Comprehensive assessments",
      ],
      "buttonText": "Coming Soon",
      "isBestValue": false,
      "badgeText": "",
      "isComingSoon": true,
    },
    {
      "title": "Intensive",
      "subtitle": "Career Track (Coming Soon)",
      "currentPrice": "₹9,999",
      "originalPrice": "₹20,000",
      "discountPercent": "50% OFF",
      "features": [
        "Deep-dive curriculum",
        "Expert mentor guidance",
        "Doubt solving support",
        "Interview preparation",
        "Mock interviews (Tech & HR)",
        "Resume & LinkedIn review",
        "Access to exclusive job portal",
      ],
      "buttonText": "Coming Soon",
      "isBestValue": false,
      "badgeText": "",
      "isComingSoon": true,
    },
  ];

  Widget _pricingCard(Map plan) {
    final bool isBest = plan['isBestValue'] as bool;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
        border: isBest ? Border.all(color: Colors.orange, width: 2) : null,
      ),
      child: Column(
        children: [
          if (plan['badgeText'].toString().isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                plan['badgeText'],
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          const SizedBox(height: 20),
          Text(
            plan['title'],
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          Text(
            plan['subtitle'],
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
          const SizedBox(height: 20),
          Text(
            plan['currentPrice'],
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
          if (plan['originalPrice'] != null)
            Text(
              plan['originalPrice'],
              style: TextStyle(
                fontSize: 16,
                decoration: TextDecoration.lineThrough,
                color: Colors.grey[500],
              ),
            ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: plan['isComingSoon'] ? null : () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              minimumSize: const Size(double.infinity, 50),
            ),
            child: Text(plan['buttonText']),
          ),
          const SizedBox(height: 30),
          ...(plan['features'] as List).map(
            (feature) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  const Icon(Icons.check, color: Colors.green, size: 20),
                  const SizedBox(width: 12),
                  Expanded(child: Text(feature)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 60,
        vertical: 60,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFF8F9FA), Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          const Text(
            'Choose Your Plan',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            'Start with free quizzes and upgrade as you grow',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          const SizedBox(height: 60),

          /// 🔥 Responsive Pricing Layout
          isMobile
              ? Column(
                  children:
                      pricingPlans.map((plan) => _pricingCard(plan)).toList(),
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: pricingPlans
                      .map(
                        (plan) => Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: _pricingCard(plan),
                          ),
                        ),
                      )
                      .toList(),
                ),
        ],
      ),
    );
  }
}

class _BenefitsSection extends StatelessWidget {
  static const List<Map<String, String>> benefitsPoints = [
    {
      "emoji": "⚡",
      "title": "Rapid Concept Revision",
      "description":
          "Cover entire topics quickly. Use quizzes to revise instead of watching hours of content."
    },
    {
      "emoji": "🎯",
      "title": "Pinpoint Weaknesses",
      "description":
          "See exactly which topics need more work based on your quiz performance."
    },
    {
      "emoji": "📈",
      "title": "Track Real Progress",
      "description":
          "Compare your latest scores with previous attempts and see improvement."
    },
    {
      "emoji": "🧠",
      "title": "Boost Retention",
      "description":
          "Active recall via quizzes helps you remember concepts much longer."
    },
    {
      "emoji": "💪",
      "title": "Build Confidence",
      "description":
          "Regular practice builds confidence before exams and interviews."
    },
    {
      "emoji": "🏆",
      "title": "Interview Ready",
      "description":
          "Question patterns are designed to be close to real technical rounds."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(60),
      color: Color(0xFF1E3A8A),
      child: Column(
        children: [
          Text(
            'Benefits of Quizzes on Skill Factorial',
            style: TextStyle(
                fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 60),
          Wrap(
            spacing: 30,
            runSpacing: 30,
            children: benefitsPoints.map((benefit) {
              return Container(
                width: 300,
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      benefit['emoji']!,
                      style: TextStyle(fontSize: 32),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            benefit['title']!,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(height: 8),
                          Text(
                            benefit['description']!,
                            style:
                                TextStyle(fontSize: 14, color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _FAQSection extends StatefulWidget {
  @override
  _FAQSectionState createState() => _FAQSectionState();
}

class _FAQSectionState extends State<_FAQSection> {
  int? expandedIndex;

  static const List<Map<String, String>> faqData = [
    {
      "question": "Is the Booster plan really free forever?",
      "answer":
          "Yes! The Booster plan is designed to provide free access to core tech quizzes to help students practice."
    },
    {
      "question": "When will the Accelerator plan launch?",
      "answer":
          "We are currently finalizing the project modules. Sign up for our newsletter to get notified!"
    },
    {
      "question": "Can I use Skill Factorial on my phone?",
      "answer":
          "Currently, we are web-optimized, but Android and iOS apps are in active development."
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(60),
      color: Colors.white,
      child: Column(
        children: [
          Text(
            'Frequently Asked Questions',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 40),
          ...faqData.asMap().entries.map((entry) {
            int index = entry.key;
            final faq = entry.value;
            bool isExpanded = expandedIndex == index;
            return Container(
              margin: EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: ExpansionTile(
                onExpansionChanged: (expanded) {
                  setState(() {
                    expandedIndex = expanded ? index : null;
                  });
                },
                leading: Icon(Icons.help_outline),
                title: Text(faq['question']!,
                    style: TextStyle(fontWeight: FontWeight.w600)),
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(faq['answer']!),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _FooterSection extends StatelessWidget {
  static const Map<String, String> footerData = {
    "title": "Get Skill Factorial on your device",
    "subtitle": "Practice quizzes anywhere, anytime",
    "copyright":
        "© 2026 Skill Factorial. All rights reserved. Made with ❤️ in India.",
  };

  static const List<Map<String, String>> contactDetails = [
    {
      "emoji": "📧",
      "title": "Email",
      "text": "skillfactorial@gmail.com",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Color(0xFF1A1A1A),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Column(
        children: [
          Text(
            footerData['title']!,
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 12),
          Text(
            footerData['subtitle']!,
            style: TextStyle(fontSize: 16, color: Colors.grey[400]),
          ),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: contactDetails.map((contact) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Text(
                      contact['emoji']!,
                      style: TextStyle(fontSize: 32),
                    ),
                    SizedBox(height: 8),
                    Text(
                      contact['title']!,
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                    Text(
                      contact['text']!,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 40),
          Text(
            footerData['copyright']!,
            style: TextStyle(color: Colors.grey[500]),
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              // Launch URL
            },
            child: Text(
              'skillfactorial',
              style: TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

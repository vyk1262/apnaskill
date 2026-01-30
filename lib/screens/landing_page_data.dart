class LandingPageData {
  // Hero Section
  static const String heroTitle = 'Master Skills with Quiz-First Learning';
  static const String heroSubtitle =
      'Practice targeted questions that mirror real interviews and exams. Track progress and build confidence.';
  static const String heroButtonText = 'Start Free Booster';

  // Features Section
  static const List<Map<String, String>> features = [
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

  // How It Works Section
  static const List<Map<String, String>> howItWorksSteps = [
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

  // Pricing Section
  static const List<Map<String, dynamic>> pricingPlans = [
    {
      "title": "Booster",
      "subtitle": "Quizzes Only · Live Now",
      "currentPrice": "₹0",
      "originalPrice": "₹100",
      "discountPercent": "100% OFF",
      "features": [
        "Access quizzes for your subjects",
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

  // Benefits Section
  static const List<Map<String, String>> benefits = [
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

  // FAQ Section
  static const List<Map<String, String>> faqs = [
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

  // Footer Section
  static const Map<String, String> footer = {
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

  // Section Titles
  static const String featuresTitle = 'Why Choose Skill Factorial?';
  static const String featuresSubtitle =
      'Designed for faster learning and better results';
  static const String howItWorksTitle = 'How It Works';
  static const String pricingTitle = 'Choose Your Plan';
  static const String pricingSubtitle =
      'Start with free quizzes and upgrade as you grow';
  static const String benefitsTitle = 'Benefits of Quizzes on Skill Factorial';
  static const String faqTitle = 'Frequently Asked Questions';
}

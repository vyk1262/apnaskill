class InvestorPitchData {
  static const List<SlideData> slides = [
    // Slide 1: Title
    SlideData(
      title: "Skill Factorial",
      subtitle: "Active Learning Platform\nQuiz → Flashcard → Project",
      image: "assets/images/skillfaktorial_logo.png",
      keyPoints: ["skillfaktorial.com"],
    ),

    // Slide 2: Problem
    SlideData(
      title: "85% EdTech Dropout Rate",
      subtitle: "Passive video learning fails",
      keyPoints: [
        "Video courses: 20-30% retention",
        "Tier 2/3 city access gaps",
        "Students want interactive learning",
        "₹33,000 Cr market opportunity"
      ],
    ),

    // Slide 3: Solution
    SlideData(
      title: "Active Recall Learning Loop",
      subtitle: "4X Retention vs Video Platforms",
      keyPoints: [
        "📖 Topic Synopsis (2 min)",
        "🃏 Flashcards (Spaced Repetition)",
        "⚡ Live Quizzes (Competition)",
        "🚀 Small Projects (Practice)",
        "📚 Blogs (Deep Dives)"
      ],
    ),

    // Slide 4: Market Size
    SlideData(
      title: "1.5M B.Tech Graduates Yearly",
      subtitle: "65% of Technical Students seek outside coaching",
      keyPoints: [
        "Hyderabad Hub: 100K+ engineers/year (TS/AP focus)",
        "Skill Gap: Only 71.5% engineering employability in 2025",
        "India EdTech TAM: ₹2.7 Lakh Crore by 2034",
        "Shift: Students moving from Video (Passive) to Quiz (Active)"
      ],
    ),

    // Slide 5: Competition
    SlideData(
      title: "We Beat Video + Single-Feature Platforms",
      subtitle: "Complete Learning Stack",
      keyPoints: [
        "BYJU'S: Video-only (25% retention)",
        "Code 360: MCQs only",
        "Quizlet: Flashcards only",
        "Skill Factorial: Complete Loop ✅"
      ],
    ),

    // Slide 6: Target Customer
    SlideData(
      title: "Tier 2/3 Aspirational Students",
      subtitle: "18-25 years • ₹999/year pricing",
      keyPoints: [
        "70M addressable users",
        "Job skills + exam prep",
        "Mobile-first, vernacular",
        "₹99/month affordable"
      ],
    ),

    // Slide 7: Business Model
    SlideData(
      title: "Proven Revenue Model",
      subtitle: "85% Gross Margin",
      keyPoints: [
        "Subscriptions: 70% (₹999/yr)",
        "Live contests: 15%",
        "B2B colleges: 10%",
        "Certificates: 5%"
      ],
    ),

    // Slide 8: Financials
    SlideData(
      title: "The ₹1 Cr Revenue Roadmap",
      subtitle: "Freemium Model: 3M Free → ₹1,000/Year",
      keyPoints: [
        "Phase 1: 25K users on Free 'Booster' tier",
        "Phase 2: 5K conversions @ ₹1,000 (Month 6)",
        "Phase 3: 10K total paid users = ₹1 Cr ARR",
        "Upsell: Certificates & Live Contests (Extra 15%)"
      ],
    ),

    // Slide 9: Unit Economics
    SlideData(
      title: "18:1 LTV:CAC",
      subtitle: "Scalable Economics",
      keyPoints: [
        "CAC: ₹200/user",
        "ARPU: ₹999/year",
        "LTV: ₹18,000 (18 months)",
        "Churn: 8%/month"
      ],
    ),

    // Slide 10: Traction Plan
    SlideData(
      title: "12-Month Execution",
      subtitle: "Hyderabad → National",
      keyPoints: [
        "Month 3: 10K users, ₹25L revenue",
        "Month 6: 50K users, break-even",
        "Month 12: 1L users, ₹3Cr ARR"
      ],
    ),

    // Slide 11: Tech Stack
    SlideData(
      title: "Production Ready",
      subtitle: "Firebase + Flutter",
      keyPoints: [
        "Single JSON: Quiz = Flashcard content",
        "Real-time live quizzes",
        "iOS/Android/Web ready",
        "Scalable architecture"
      ],
    ),

    // Slide 12: Team
    SlideData(
      title: "IIT Kanpur Founder-Engineer",
      subtitle: "Expertise in Voice AI & Full-Stack",
      keyPoints: [
        "Yellesh: 4+ Years SDE experience at Startup",
        "Self-Reliant: Flutter, Firebase, & Data Analytics",
        "Low Burn: Product is built in-house, not outsourced",
        "Founder of Skill Factorial (EdTech Specialist)"
      ],
    ),

// Slide 13: The Ask (Refined)
    SlideData(
      title: "₹20 Lacs for 20% Equity",
      subtitle: "Building the Engine for 10K Paid Users",
      keyPoints: [
        "₹6L: Founder Salary (IIT Kanpur Lead with Full-Stack Skills and 4+ Years SDE Experience at a Startup company)",
        "₹4L: Tech Infra & Payment Gateway",
        "₹5L: Deep-Tech Content & Project Dev",
        "₹5L: Marketing & College Outreach"
      ],
    ),

    // Slide 14: Why Now
    SlideData(
      title: "Perfect Timing",
      subtitle: "Post-BYJU'S Reset",
      keyPoints: [
        "EdTech valuation reset",
        "Quiz platforms exploding",
        "Tier 2/3 demand surge",
        "Active learning trend"
      ],
    ),

    // Slide 15: Thank You
    SlideData(
      title: "Let's Build the Future of Learning",
      subtitle: "skillfaktorial.com",
      keyPoints: [
        "Contact: yellesh@skillfaktorial.com",
        "Demo available",
        "PDF Download 👇"
      ],
    ),
  ];
}

class SlideData {
  final String title;
  final String subtitle;
  final List<String> keyPoints;
  final String? image;

  const SlideData({
    required this.title,
    required this.subtitle,
    required this.keyPoints,
    this.image,
  });
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skill_factorial/screens/investor_pitch.dart';

import 'common_widgets/custom_app_bar.dart';
import 'landing_page_data.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: CustomAppBar(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _HeroSection()),
          SliverToBoxAdapter(child: _FeaturesSection()),
          SliverToBoxAdapter(child: _HowItWorksSection()),
          SliverToBoxAdapter(child: _PricingSection()),
          SliverToBoxAdapter(child: _BenefitsSection()),
          SliverToBoxAdapter(child: _FAQSection()),
          SliverToBoxAdapter(child: _FooterSection()),
        ],
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;

    return Container(
      width: double.infinity,
      // Adaptive height: slightly taller on desktop to show off the image
      height: isMobile ? null : 700,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: isMobile ? 60 : 0,
      ),
      decoration: const BoxDecoration(
        color: Color(
            0xFF0F172A), // color: const Color(0xFF0F172A), Soft off-white professional background
      ),
      child: isMobile
          ? Column(children: _buildHeroContent(isMobile))
          : Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _buildHeroContent(isMobile),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: _buildHeroImage(),
                  ),
                ),
              ],
            ),
    );
  }

  List<Widget> _buildHeroContent(bool isMobile) {
    return [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.orange.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          "🚀 10X YOUR LEARNING",
          style: GoogleFonts.poppins(
            color: Colors.orange[800],
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
          ),
        ),
      ),
      const SizedBox(height: 24),
      Text(
        LandingPageData.heroTitle,
        textAlign: isMobile ? TextAlign.center : TextAlign.left,
        style: GoogleFonts.poppins(
          fontSize: isMobile ? 36 : 56,
          fontWeight: FontWeight.w900,
          color: Color.fromARGB(255, 255, 255, 255),
          height: 1.1,
        ),
      ),
      const SizedBox(height: 24),
      Text(
        LandingPageData.heroSubtitle,
        textAlign: isMobile ? TextAlign.center : TextAlign.left,
        style: GoogleFonts.poppins(
          fontSize: isMobile ? 16 : 20,
          color: Colors.blueGrey[700],
          height: 1.6,
        ),
      ),
      const SizedBox(height: 48),
      Align(
        alignment: isMobile ? Alignment.center : Alignment.centerLeft,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange[500],
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 0,
          ),
          child: Text(
            LandingPageData.heroButtonText,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      if (isMobile) ...[
        const SizedBox(height: 60),
        _buildHeroImage(),
      ]
    ];
  }

  Widget _buildHeroImage() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.2),
            blurRadius: 100,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Image.network(
          // Curated high-quality EdTech image from Unsplash
          'https://images.unsplash.com/photo-1522202176988-66273c2fd55f?auto=format&fit=crop&q=80&w=1200',
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              height: 400,
              color: Colors.grey[200],
              child: const Center(child: CircularProgressIndicator()),
            );
          },
        ),
      ),
    );
  }
}

class _FeaturesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 100,
      ),
      child: Column(
        children: [
          // Section Label
          Text(
            "WHY CHOOSE US",
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.orange[700],
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 16),
          // Main Title
          Text(
            LandingPageData.featuresTitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 32 : 44,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF1E293B),
              height: 1.2,
            ),
          ),
          const SizedBox(height: 20),
          // Subtitle
          SizedBox(
            width: 700,
            child: Text(
              LandingPageData.featuresSubtitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 18, color: Colors.blueGrey[700], height: 1.6),
            ),
          ),
          const SizedBox(height: 80),

          Wrap(
            spacing: 30,
            runSpacing: 30,
            alignment: WrapAlignment.center,
            children: LandingPageData.features.map((feature) {
              return SizedBox(
                width: isMobile
                    ? double.infinity
                    : (width > 1200 ? 360 : (width - 200) / 2),
                child: _FeatureCard(
                  emoji: feature['emoji']!,
                  title: feature['title']!,
                  description: feature['description']!,
                ),
              );
            }).toList(),
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
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        // Subtle border to give it a "Glass" look on white backgrounds
        border: Border.all(color: const Color(0xFFF1F5F9), width: 2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withOpacity(0.05),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Left aligned looks more professional
        children: [
          Container(
            height: 64,
            width: 64,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange[400]!, Colors.orange[600]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.orange.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Center(
              child: Text(
                emoji,
                style: const TextStyle(fontSize: 30),
              ),
            ),
          ),
          const SizedBox(height: 32),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: GoogleFonts.poppins(
              fontSize: 15,
              color: Colors.blueGrey[700],
              height: 1.7,
            ),
          ),
          const SizedBox(height: 24),
          // Small "Learn More" or indicator arrow
          Icon(Icons.arrow_right_alt, color: Colors.orange[600]),
        ],
      ),
    );
  }
}

class _HowItWorksSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;

    return Container(
      width: double.infinity,
      color: const Color(0xFF0F172A), // Very light background to make cards pop
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 120,
      ),
      child: Column(
        children: [
          Text(
            "THE PROCESS",
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.orange[700],
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            LandingPageData.howItWorksTitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 32 : 44,
              fontWeight: FontWeight.w800,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          const SizedBox(height: 100),

          // Using a Flex to handle the flow properly
          isMobile
              ? Column(
                  children: List.generate(
                    LandingPageData.howItWorksSteps.length,
                    (index) => _StepCard(
                      step: LandingPageData.howItWorksSteps[index],
                      isMobile: true,
                      isLast:
                          index == LandingPageData.howItWorksSteps.length - 1,
                    ),
                  ),
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    LandingPageData.howItWorksSteps.length,
                    (index) => Expanded(
                      child: _StepCard(
                        step: LandingPageData.howItWorksSteps[index],
                        isMobile: false,
                        isLast:
                            index == LandingPageData.howItWorksSteps.length - 1,
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

class _StepCard extends StatelessWidget {
  final Map<String, String> step;
  final bool isMobile;
  final bool isLast;

  const _StepCard({
    required this.step,
    required this.isMobile,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        // The Connector Line (Desktop Only)
        if (!isLast && !isMobile)
          Positioned(
            top: 50,
            left: isMobile ? 0 : 60,
            right: isMobile ? 0 : -60,
            child: Container(
              height: 2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange.withOpacity(0.5), Colors.transparent],
                ),
              ),
            ),
          ),

        Column(
          children: [
            // Step Number Circle
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: -2,
                  ),
                ],
              ),
              child: Center(
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFFB923C),
                        Color(0xFFEA580C)
                      ], // Orange 400 to 600
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      step['step']!,
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              step['title']!,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                step['desc']!,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: const Color(0xFF64748B),
                  height: 1.6,
                ),
              ),
            ),

            // Vertical Connector for Mobile
            if (!isLast && isMobile)
              Container(
                margin: const EdgeInsets.symmetric(vertical: 30),
                height: 40,
                width: 2,
                color: Colors.orange.withOpacity(0.3),
              ),
          ],
        ),
      ],
    );
  }
}

class _PricingSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 120,
      ),
      child: Column(
        children: [
          Text(
            "SIMPLE PRICING",
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.orange[700],
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            LandingPageData.pricingTitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 32 : 44,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            LandingPageData.pricingSubtitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 18,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 80),
          isMobile
              ? Column(
                  children: LandingPageData.pricingPlans
                      .map((plan) => _PricingCard(plan: plan, isMobile: true))
                      .toList(),
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: LandingPageData.pricingPlans
                      .asMap()
                      .entries
                      .map((entry) => Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: _PricingCard(
                                plan: entry.value,
                                isMobile: false,
                              ),
                            ),
                          ))
                      .toList(),
                ),
        ],
      ),
    );
  }
}

class _PricingCard extends StatelessWidget {
  final Map<String, dynamic> plan;
  final bool isMobile;

  const _PricingCard({required this.plan, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final isBest = plan['isBestValue'] as bool;
    final isComingSoon = plan['isComingSoon'] ?? false;

    return Transform.scale(
      scale: isBest && !isMobile ? 1.05 : 1.0,
      child: Container(
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            color: isBest ? Colors.orange : const Color(0xFFE2E8F0),
            width: isBest ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isBest
                  ? Colors.orange.withOpacity(0.1)
                  : Colors.black.withOpacity(0.05),
              blurRadius: 40,
              offset: const Offset(0, 20),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (plan['badgeText'] != null && plan['badgeText'] != '')
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isBest ? Colors.orange[50] : const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  plan['badgeText'],
                  style: GoogleFonts.poppins(
                    color:
                        isBest ? Colors.orange[800] : const Color(0xFF475569),
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ),
            Text(
              plan['title'],
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              plan['subtitle'],
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: const Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 32),

            // Price Section with Strike-through
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (plan['originalPrice'] != null)
                  Text(
                    plan['originalPrice'],
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      decoration: TextDecoration.lineThrough,
                      color: const Color(
                          0xFF94A3B8), // Muted slate for strike-through
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      plan['currentPrice'],
                      style: GoogleFonts.poppins(
                        fontSize: 48,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF1E293B),
                        letterSpacing: -1,
                      ),
                    ),
                    Text(
                      " /subject",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isComingSoon ? null : () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isBest ? Colors.orange[600] : const Color(0xFF1E293B),
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: const Color(0xFFE2E8F0),
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  isComingSoon ? "Coming Soon" : plan['buttonText'],
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Divider(color: Color(0xFFE2E8F0)),
            const SizedBox(height: 32),
            ...((plan['features'] as List).map(
              (feature) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  children: [
                    Icon(Icons.check_circle,
                        color: isComingSoon
                            ? const Color(0xFF94A3B8)
                            : Colors.green[500],
                        size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        feature,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: const Color(0xFF475569),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}

class _BenefitsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 120,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF0F172A),
            Color(0xFF1E40AF)
          ], // Deeper Slate to Deep Blue
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          // Section Label
          Text(
            "CORE BENEFITS",
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.orange[400],
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            LandingPageData.benefitsTitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 32 : 44,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 80),
          Wrap(
            spacing: 32,
            runSpacing: 32,
            alignment: WrapAlignment.center,
            children: LandingPageData.benefits.map((benefit) {
              return SizedBox(
                // Adaptive width for responsiveness
                width: isMobile
                    ? double.infinity
                    : (width > 1200 ? 380 : (width - 200) / 2),
                child: _GlassBenefitCard(benefit: benefit),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _GlassBenefitCard extends StatelessWidget {
  final Map<String, String> benefit;

  const _GlassBenefitCard({required this.benefit});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        // Glassmorphism effect
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon Container
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              benefit['emoji']!,
              style: const TextStyle(fontSize: 32),
            ),
          ),
          const SizedBox(height: 32),
          Text(
            benefit['title']!,
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            benefit['description']!,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.white.withOpacity(0.7),
              height: 1.7,
            ),
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

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 120,
      ),
      child: Center(
        child: Container(
          width:
              900, // Keeps the FAQ from getting too wide on ultra-wide screens
          child: Column(
            children: [
              Text(
                "QUESTIONS?",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.orange[700],
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                LandingPageData.faqTitle,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 32 : 44,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 60),
              ...LandingPageData.faqs.asMap().entries.map((entry) {
                final index = entry.key;
                final faq = entry.value;
                final isExpanded = expandedIndex == index;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      color:
                          isExpanded ? Colors.white : const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: isExpanded
                            ? Colors.orange
                            : const Color(0xFFE2E8F0),
                        width: isExpanded ? 2 : 1,
                      ),
                      boxShadow: isExpanded
                          ? [
                              BoxShadow(
                                color: Colors.orange.withOpacity(0.05),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              )
                            ]
                          : [],
                    ),
                    child: Theme(
                      // Removes the default splash and lines from ExpansionTile
                      data: Theme.of(context).copyWith(
                        dividerColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                      ),
                      child: ExpansionTile(
                        onExpansionChanged: (expanded) {
                          setState(() {
                            expandedIndex = expanded ? index : null;
                          });
                        },
                        initiallyExpanded: isExpanded,
                        maintainState: true,
                        tilePadding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 8),
                        title: Text(
                          faq['question']!,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: isMobile ? 16 : 18,
                            color: const Color(0xFF1E293B),
                          ),
                        ),
                        trailing: Icon(
                          isExpanded
                              ? Icons.remove_circle_outline
                              : Icons.add_circle_outline,
                          color: isExpanded
                              ? Colors.orange
                              : const Color(0xFF64748B),
                        ),
                        childrenPadding:
                            const EdgeInsets.fromLTRB(24, 0, 24, 24),
                        children: [
                          Text(
                            faq['answer']!,
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: const Color(0xFF64748B),
                              height: 1.6,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class _FooterSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 80,
      ),
      decoration: const BoxDecoration(
        // Using a premium solid dark background to make orange pop
        color: Color(0xFF0D0D0D),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      child: Column(
        children: [
          // Header Section
          Text(
            LandingPageData.footer['title']!,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 28 : 36,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            LandingPageData.footer['subtitle']!,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 18,
              color: Colors.grey[500],
            ),
          ),

          const SizedBox(height: 50),

          // App Icons - Coming Soon
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: [
              _buildAppBadge(Icons.apple, "App Store"),
              _buildAppBadge(Icons.play_arrow_rounded, "Google Play"),
            ],
          ),

          const SizedBox(height: 60),
          const Divider(color: Colors.white10, thickness: 1),
          const SizedBox(height: 60),

          // Contact Details - Responsive Grid
          Wrap(
            spacing: isMobile ? 40 : 80,
            runSpacing: 40,
            alignment: WrapAlignment.center,
            children: LandingPageData.contactDetails.map((contact) {
              return Column(
                children: [
                  Text(
                    contact['title']!,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    contact['text']!,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        // navigate to Investor Pitch Page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InvestorPitch()),
                        );
                      },
                      child: Text(
                        "Growth",
                        style: GoogleFonts.poppins(
                          color: Colors.orange[400],
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                        ),
                      )),
                ],
              );
            }).toList(),
          ),

          const SizedBox(height: 80),

          // Copyright & Link
          Text(
            LandingPageData.footer['copyright']!,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {},
            child: Text(
              'skillfactorial',
              style: GoogleFonts.poppins(
                color: Colors.orange,
                fontWeight: FontWeight.w700,
                fontSize: 18,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Modern "Coming Soon" Badge Widget
  Widget _buildAppBadge(IconData icon, String store) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "COMING SOON",
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 9,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
              Text(
                store,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

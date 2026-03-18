import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skill_factorial/constants/colors.dart';
import 'package:skill_factorial/screens/investor_pitch.dart';

import 'common_widgets/custom_app_bar.dart';
import 'landing_page_data.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
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
        gradient: LinearGradient(
          colors: [
            AppColors.primaryColor,
            AppColors.secondaryColor,
            AppColors.accentColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
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
          color: AppColors.highlight.withOpacity(0.12),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          "🚀 10X YOUR LEARNING",
          style: GoogleFonts.poppins(
            color: AppColors.highlight,
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
          color: AppColors.white,
          height: 1.1,
        ),
      ),
      const SizedBox(height: 24),
      Text(
        LandingPageData.heroSubtitle,
        textAlign: isMobile ? TextAlign.center : TextAlign.left,
        style: GoogleFonts.poppins(
          fontSize: isMobile ? 16 : 20,
          color: AppColors.textSecondary,
          height: 1.6,
        ),
      ),
      const SizedBox(height: 48),
      Align(
        alignment: isMobile ? Alignment.center : Alignment.centerLeft,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.highlight,
            foregroundColor: AppColors.white,
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
            color: AppColors.highlight.withOpacity(0.25),
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
              color: AppColors.shimmerBase,
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
              color: AppColors.highlight,
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
              color: AppColors.textPrimary,
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
                  fontSize: 18, color: AppColors.textSecondary, height: 1.6),
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
        color: AppColors.white,
        borderRadius: BorderRadius.circular(32),
        // Subtle border to give it a "Glass" look on white backgrounds
        border: Border.all(color: AppColors.border, width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.backgroundDark.withOpacity(0.05),
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
                colors: [
                  AppColors.highlight.withOpacity(0.85),
                  AppColors.highlight.withOpacity(0.55),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.highlight.withOpacity(0.25),
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
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: GoogleFonts.poppins(
              fontSize: 15,
              color: AppColors.textSecondary,
              height: 1.7,
            ),
          ),
          const SizedBox(height: 24),
          // Small "Learn More" or indicator arrow
          Icon(Icons.arrow_right_alt, color: AppColors.highlight),
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
      color: AppColors.backgroundDark,
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
              color: AppColors.highlight,
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
              color: AppColors.white,
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
                  colors: [
                    AppColors.highlight.withOpacity(0.5),
                    AppColors.transparent
                  ],
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
                color: AppColors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                  BoxShadow(
                    color: AppColors.highlight.withOpacity(0.1),
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
                    gradient: LinearGradient(
                      colors: [
                        AppColors.highlight,
                        AppColors.highlight.withOpacity(0.8),
                      ],
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
                        color: AppColors.white,
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
                color: AppColors.white,
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
                  color: AppColors.textSecondary,
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
                color: AppColors.highlight.withOpacity(0.3),
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
      color: AppColors.white,
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
              color: AppColors.highlight,
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
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            LandingPageData.pricingSubtitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 18,
              color: AppColors.textSecondary,
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
            color: isBest ? AppColors.highlight : AppColors.border,
            width: isBest ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isBest
                  ? AppColors.highlight.withOpacity(0.1)
                  : AppColors.black.withOpacity(0.05),
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
                  color: isBest
                      ? AppColors.highlight.withOpacity(0.15)
                      : AppColors.shimmerHighlight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  plan['badgeText'],
                  style: GoogleFonts.poppins(
                    color:
                        isBest ? AppColors.highlight : AppColors.textTertiary,
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
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              plan['subtitle'],
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: AppColors.textSecondary,
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
                        color: AppColors.textPrimary,
                        letterSpacing: -1,
                      ),
                    ),
                    Text(
                      " /subject",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: AppColors.textSecondary,
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
                  backgroundColor: isBest
                      ? AppColors.highlight.withOpacity(0.9)
                      : AppColors.textPrimary,
                  foregroundColor: AppColors.white,
                  disabledBackgroundColor: AppColors.border,
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
            const Divider(color: AppColors.divider),
            const SizedBox(height: 32),
            ...((plan['features'] as List).map(
              (feature) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  children: [
                    Icon(Icons.check_circle,
                        color: isComingSoon
                            ? AppColors.textLight
                            : AppColors.success,
                        size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        feature,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: AppColors.textTertiary,
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
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.backgroundDark,
            AppColors.backgroundDark,
          ],
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
              color: AppColors.highlight,
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
              color: AppColors.white,
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
        color: AppColors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: AppColors.white.withOpacity(0.1),
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
              color: AppColors.white.withOpacity(0.1),
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
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            benefit['description']!,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: AppColors.white.withOpacity(0.7),
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
      color: AppColors.white,
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
                  color: AppColors.highlight,
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
                  color: AppColors.textPrimary,
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
                      color: isExpanded
                          ? AppColors.white
                          : AppColors.backgroundLight,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color:
                            isExpanded ? AppColors.highlight : AppColors.border,
                        width: isExpanded ? 2 : 1,
                      ),
                      boxShadow: isExpanded
                          ? [
                              BoxShadow(
                                color: AppColors.highlight.withOpacity(0.05),
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
                            color: AppColors.textPrimary,
                          ),
                        ),
                        trailing: Icon(
                          isExpanded
                              ? Icons.remove_circle_outline
                              : Icons.add_circle_outline,
                          color: isExpanded
                              ? AppColors.highlight
                              : AppColors.textSecondary,
                        ),
                        childrenPadding:
                            const EdgeInsets.fromLTRB(24, 0, 24, 24),
                        children: [
                          Text(
                            faq['answer']!,
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: AppColors.textSecondary,
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
        color: AppColors.footerBackground,
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
              color: AppColors.textLight,
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
          const Divider(color: AppColors.white10, thickness: 1),
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
                      color: AppColors.textLight,
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
                        "Pitch Deck Presentation",
                        style: GoogleFonts.poppins(
                          color: AppColors.highlight.withOpacity(0.9),
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
              color: AppColors.textTertiary,
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {},
            child: Text(
              'skillfactorial',
              style: GoogleFonts.poppins(
                color: AppColors.highlight,
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
        color: AppColors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.white10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.white, size: 24),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "COMING SOON",
                style: TextStyle(
                  color: AppColors.highlight,
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

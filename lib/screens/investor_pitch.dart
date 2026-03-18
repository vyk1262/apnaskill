import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:skill_factorial/constants/colors.dart';
import 'investor_pitch_data.dart';

class InvestorPitch extends StatefulWidget {
  @override
  _InvestorPitchState createState() => _InvestorPitchState();
}

class _InvestorPitchState extends State<InvestorPitch> {
  final PageController _pageController = PageController();
  int currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextSlide() {
    if (currentIndex < InvestorPitchData.slides.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _prevSlide() {
    if (currentIndex > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Stack(
        children: [
          // PageView for slides
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) => setState(() => currentIndex = index),
            itemCount: InvestorPitchData.slides.length,
            itemBuilder: (context, index) {
              final slide = InvestorPitchData.slides[index];
              return SlideWidget(slide: slide);
            },
          ),

          // Navigation controls
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Column(
              children: [
                // Progress dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    InvestorPitchData.slides.length,
                    (i) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      width: currentIndex == i ? 24 : 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: currentIndex == i
                            ? AppColors.white
                            : AppColors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Navigation buttons + PDF
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (currentIndex > 0)
                      IconButton(
                        icon:
                            Icon(Icons.arrow_back_ios, color: AppColors.white),
                        onPressed: _prevSlide,
                        iconSize: 32,
                      ),
                    const Text("-"),
                    if (currentIndex < InvestorPitchData.slides.length - 1)
                      IconButton(
                        icon: Icon(Icons.arrow_forward_ios,
                            color: AppColors.white),
                        onPressed: _nextSlide,
                        iconSize: 32,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SlideWidget extends StatelessWidget {
  final SlideData slide;

  const SlideWidget({Key? key, required this.slide}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Title
          Text(
            slide.title,
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w900, // Heavier for better impact
              color: Colors.white,
              height: 1.1,
              letterSpacing: -1,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24),

          // Subtitle
          Text(
            slide.subtitle,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: AppColors.highlight.withOpacity(0.9), // Highlighted color
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 50),

          // Key points - WRAPPED TO CENTER
          ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth: 600), // Limits width to keep it centered
            child: Column(
              crossAxisAlignment: CrossAxisAlignment
                  .start, // Left align text relative to the bullet
              children: slide.keyPoints
                  .map((point) => Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              margin: EdgeInsets.only(top: 10, right: 18),
                              decoration: BoxDecoration(
                                color: AppColors.highlight,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.highlight.withOpacity(0.5),
                                    blurRadius: 8,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Text(
                                point,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: AppColors.white.withOpacity(0.9),
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

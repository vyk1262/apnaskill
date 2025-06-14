import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skill_factorial/constants/colors.dart';
import 'package:skill_factorial/widgets/cached_network_image_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Profile.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar();

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(60);
}

class _CustomAppBarState extends State<CustomAppBar>
    with SingleTickerProviderStateMixin {
  // Animation controller for the drawer
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300), // Quick animation
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0), // Starts off-screen to the left
      end: Offset.zero, // Slides into view
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    bool isMobile = MediaQuery.of(context).size.width < 850;
    return AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => context.go('/'),
                    // child: const CachedNetworkImageWidget(
                    //   imageUrl: 'https://i.ibb.co/xtLkhZLb/logo.png',
                    //   width: 30,
                    //   height: 30,
                    //   fit: BoxFit.cover,
                    //   errorWidget: Icon(Icons.broken_image),
                    // ),
                    child: Image.asset(
                      'assets/student_home/logo.png',
                      width: 30,
                      height: 30,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image),
                    ),
                  ),
                ),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Skill',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: ' ',
                      ),
                      TextSpan(
                        text: 'Factorial',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                if (user != null) ...[
                  isMobile
                      ? const SizedBox.shrink()
                      : IconButton(
                          onPressed: () {
                            context.go('/profile');
                          },
                          icon: const Icon(
                            Icons.account_box,
                            color: Colors.white,
                          ),
                        ),
                ],
                isMobile
                    ? const SizedBox.shrink()
                    : Row(
                        children: [
                          _buildNavButton(context,
                              label: 'Home', screenName: '/'),
                          // _buildNavButton(context,
                          //     label: 'Mentors', screenName: 'mentors'),
                          _buildNavButton(context,
                              label: 'Quizzes', screenName: 'quizzes'),
                          // _buildNavButton(context,
                          //     label: 'Explore', screenName: 'explore'),
                          _buildNavButton(context,
                              label: 'Blogs', screenName: 'blogs'),
                          if (user == null)
                            ElevatedButton.icon(
                              icon:
                                  const Icon(Icons.login, color: Colors.black),
                              label: const Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () {
                                context.go('/login');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                              ),
                            ),
                          if (user != null)
                            ElevatedButton.icon(
                              icon:
                                  const Icon(Icons.logout, color: Colors.black),
                              label: const Text("Logout",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  )),
                              onPressed: () async {
                                await FirebaseAuth.instance.signOut();
                                context.go('/');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                              ),
                            ),
                        ],
                      ),
                isMobile
                    ? IconButton(
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () {
                          _openCustomDrawer(context);
                        },
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _openCustomDrawer(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    _animationController.forward(); // Start the animation

    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (_, animation, secondaryAnimation) {
          // Use the internal animation object of PageRouteBuilder for a cohesive transition
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-1.0, 0.0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic, // A slightly more dynamic curve
              )),
              child: Scaffold(
                backgroundColor: Colors.transparent, // Important for overlay
                body: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    color:
                        Colors.black.withOpacity(0.85), // Slightly less opaque
                    width: MediaQuery.of(context).size.width *
                        0.7, // Take up 70% of screen width
                    height: double.infinity,
                    alignment: Alignment.topLeft, // Align content to top-left
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start, // Align text to left
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(
                                Icons.close, // Use a more standard close icon
                                size: 30,
                                color: Colors.white70, // Slightly desaturated
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0), // Padding for content
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (user != null) ...[
                                  _buildDrawerProfileButton(context, user),
                                  const SizedBox(height: 20),
                                ],
                                _buildDrawerButton(context,
                                    label: 'Home', screenName: '/'),
                                const SizedBox(height: 15),
                                _buildDrawerButton(context,
                                    label: 'Quizzes', screenName: 'quizzes'),
                                const SizedBox(height: 15),
                                _buildDrawerButton(context,
                                    label: "Blogs", screenName: 'blogs'),
                                const SizedBox(height: 15),
                                // _buildDrawerButton(context,
                                //     label: "Explore", screenName: 'explore'),
                                // const SizedBox(height: 15),
                                if (user == null)
                                  _buildDrawerAuthButton(context,
                                      label: 'Login',
                                      screenName: 'login',
                                      isLogin: true),
                                if (user != null)
                                  _buildDrawerAuthButton(context,
                                      label: 'Logout',
                                      screenName: '/',
                                      isLogin: false),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  Widget _buildNavButton(BuildContext context,
      {required String label, required String screenName}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextButton(
        onPressed: () => context.go('/$screenName'),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.normal,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerButton(BuildContext context,
      {required String label, required String screenName}) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context); // Close the drawer
        context.go('/$screenName');
      },
      style: TextButton.styleFrom(
        foregroundColor: Colors.white, // Text color when pressed
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        alignment: Alignment.centerLeft, // Align text to left within button
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 22, // Slightly smaller font size
          fontWeight: FontWeight.w600, // Semi-bold for better readability
        ),
      ),
    );
  }

  Widget _buildDrawerProfileButton(BuildContext context, User user) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context);
        context.go('/profile');
      },
      child: Column(
        children: [
          const Icon(
            Icons.account_circle,
            color: Colors.white,
            size: 50, // Make the icon much bigger
          ),
          const SizedBox(height: 8),
          Text(
            user.email ?? "", // Show email if available, else ""
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      style: TextButton.styleFrom(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      ),
    );
  }

  Widget _buildDrawerAuthButton(BuildContext context,
      {required String label,
      required String screenName,
      required bool isLogin}) {
    return ElevatedButton.icon(
      icon: Icon(isLogin ? Icons.login : Icons.logout, color: Colors.black),
      label: Text(
        label,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18, // Slightly larger font for auth buttons
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () async {
        Navigator.pop(context); // Close the drawer
        if (!isLogin) {
          await FirebaseAuth.instance.signOut();
        }
        context.go('/$screenName');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Slightly rounded corners
        ),
      ),
    );
  }
}

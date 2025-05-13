import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skill_factorial/constants/colors.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Profile.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar();

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(60);
}

class _CustomAppBarState extends State<CustomAppBar> {
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
                    : SizedBox.shrink(),
                isMobile ? SizedBox.shrink() : SizedBox(width: 80),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => context.go('/'),
                    child: Image.network(
                      'https://i.ibb.co/xtLkhZLb/logo.png',
                      width: 50,
                      height: 50,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Skill',
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: ' ',
                      ),
                      TextSpan(
                        text: 'Factorial',
                        style: TextStyle(
                            color: AppColors.secondaryColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                if (user != null) ...[
                  isMobile ? SizedBox.shrink() : Spacer(),
                  isMobile
                      ? SizedBox.shrink()
                      : IconButton(
                          onPressed: () {
                            context.go(
                                '/profile'); // Navigate to profile screen route
                          },
                          icon: Icon(Icons.account_box, color: Colors.white)),
                ],
                Spacer(),
                isMobile
                    ? SizedBox.shrink()
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
                            _buildNavButton(context,
                                label: 'Login →', screenName: 'login'),
                          if (user != null)
                            ElevatedButton.icon(
                              icon: Icon(Icons.logout),
                              label: Text("Logout"),
                              onPressed: () async {
                                await FirebaseAuth.instance.signOut();
                                context.go('/');
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                              ),
                            ),
                        ],
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _openCustomDrawer(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (_, __, ___) => Scaffold(
          backgroundColor: Colors.transparent,
          body: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              color: Colors.black87,
              child: Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.cancel,
                          size: 34,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      if (user != null) ...[
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context); // Close drawer first
                              context.go(
                                  '/profile'); // Navigate to profile screen route
                            },
                            icon: Icon(Icons.account_box, color: Colors.white)),
                      ],
                      SizedBox(height: 10),
                      _buildDrawerButton(context,
                          label: 'Home', screenName: '/'),
                      SizedBox(height: 10),
                      // _buildDrawerButton(context,
                      //     label: 'Mentors', screenName: 'mentors'),
                      // SizedBox(height: 10),
                      _buildDrawerButton(context,
                          label: 'Quizzes', screenName: 'quizzes'),
                      SizedBox(height: 10),
                      _buildDrawerButton(context,
                          label: "Explore", screenName: 'explore'),
                      SizedBox(height: 10),
                      if (user == null)
                        _buildDrawerButton(context,
                            label: 'Login →', screenName: 'login'),
                      if (user != null)
                        ElevatedButton.icon(
                          icon: Icon(Icons.logout),
                          label: Text("Logout"),
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut();
                            context.go('/');
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                          ),
                        ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
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
          style: TextStyle(
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
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

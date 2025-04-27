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
  Map<String, dynamic>? userData;
  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      setState(() {
        userData = snapshot.data() as Map<String, dynamic>?;
      });
    }
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
                SizedBox(width: 80),
                isMobile
                    ? SizedBox.shrink()
                    : MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () => context.go('/'),
                          child: Image.asset(
                            'assets/student_home/sf45.png',
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
                if (user != null)
                  if (userData != null) ...[
                    isMobile ? SizedBox.shrink() : Spacer(),
                    isMobile
                        ? SizedBox.shrink()
                        : Text(
                            "Welcome: ${userData!['name']}",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                    isMobile
                        ? SizedBox.shrink()
                        : IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Profile(
                                      userData: userData), // Pass userData here
                                ),
                              );
                            },
                            icon: Icon(Icons.account_box)),
                  ] else
                    CircularProgressIndicator(),
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
                          _buildNavButton(context,
                              label: 'Explore', screenName: 'explore'),
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
                        ),
                      ),
                      if (user != null)
                        if (userData != null) ...[
                          Text(
                            "Welcome: ${userData!['name']}",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Profile(
                                        userData:
                                            userData), // Pass userData here
                                  ),
                                );
                              },
                              icon: Icon(Icons.account_box)),
                        ] else
                          CircularProgressIndicator(),
                      _buildDrawerButton(context,
                          label: 'Home', screenName: '/'),
                      SizedBox(height: 10),
                      // _buildDrawerButton(context,
                      //     label: 'Mentors', screenName: 'mentors'),
                      SizedBox(height: 10),
                      _buildDrawerButton(context,
                          label: 'Quizzes', screenName: 'quizzes'),
                      _buildDrawerButton(context,
                          label: "Explore", screenName: 'explore'),
                      SizedBox(height: 10),
                      TextButton(
                        onPressed: () async {
                          final Uri url =
                              Uri.parse('https://blog.skillfactorial.com');
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url,
                                mode: LaunchMode.externalApplication);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        child: Text(
                          "Blogs",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      _buildDrawerButton(context,
                          label: 'Login →', screenName: 'login'),
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

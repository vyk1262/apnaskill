import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skill_factorial/constants/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar();

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(70);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 700;
    return AppBar(
      backgroundColor: Colors.black,
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
                Image.asset(
                  'assets/sf33.png',
                  width: 40,
                  height: 40,
                  fit: BoxFit.contain,
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
                Spacer(),
                isMobile
                    ? SizedBox.shrink()
                    : Row(
                        children: [
                          _buildNavButton(context,
                              label: 'Home', screenName: '/'),
                          _buildNavButton(context,
                              label: 'Courses', screenName: 'courses'),
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
                                fontWeight: FontWeight.normal,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          _buildNavButton(context,
                              label: 'Login →', screenName: 'login'),
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
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (_, __, ___) => Scaffold(
          backgroundColor: Colors.transparent,
          body: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              color: Colors.black.withOpacity(0.95),
              child: Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildDrawerButton(context,
                          label: 'Home', screenName: '/'),
                      SizedBox(width: 20),
                      _buildDrawerButton(context,
                          label: 'Courses', screenName: 'courses'),
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
                        child: Text("Blogs"),
                      ),
                      _buildDrawerButton(context,
                          label: 'Blogs', screenName: 'blog'),
                      SizedBox(width: 20),
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

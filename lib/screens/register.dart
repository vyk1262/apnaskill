import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skill_factorial/screens/courses_home.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../constants/colors.dart';
import 'package:skill_factorial/api_service.dart';
import 'common_widgets/custom_app_bar.dart';
import '../model/user_model.dart';
import 'common_widgets/cta_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isSignIn = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();

  bool _isLoading = false;
  bool _showPassword = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _mobileNumberController.dispose();
    super.dispose();
  }

  void _toggleForm() {
    setState(() => _isSignIn = !_isSignIn);
  }

  Future<void> _showErrorDialog(String message) async {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title:
            const Text('Oops!', style: TextStyle(fontWeight: FontWeight.bold)),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }

  Future<void> _signIn() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showErrorDialog('Please enter your email and password');
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const QuizListHome()),
        );
      }
    } on FirebaseAuthException catch (e) {
      _showErrorDialog('Sign in failed: ${e.message}');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _signUp() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final mobileNumber = _mobileNumberController.text.trim();

    if ([email, password, mobileNumber].any((field) => field.isEmpty)) {
      _showErrorDialog('Please fill all required fields');
      return;
    }

    if (!RegExp(r'^[0-9]{10}$').hasMatch(mobileNumber)) {
      _showErrorDialog('Enter a valid 10-digit mobile number');
      return;
    }

    setState(() => _isLoading = true);

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        await ApiService.updateUserData(user.uid, {
          'email': email,
          'mobileNumber': mobileNumber,
          'createdAt': Timestamp.now(),
        });

        Provider.of<UserModel>(context, listen: false).setUserId(user.email);
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const QuizListHome()),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      _showErrorDialog('Sign up failed: ${e.message}');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      setState(() => _isLoading = true);

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        setState(() => _isLoading = false);
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null) {
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (!userDoc.exists) {
          await ApiService.updateUserData(user.uid, {
            'email': user.email,
            'createdAt': Timestamp.now(),
          });
        }
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const QuizListHome()),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      _showErrorDialog('Google Sign-In failed: ${e.message}');
    } catch (e) {
      _showErrorDialog('An unexpected error occurred');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.brandBlue,
              AppColors.brandGreen,
              AppColors.brandPurple,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(isMobile ? 24.0 : 40.0),
            child: Center(
              child: SingleChildScrollView(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!isMobile)
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 40.0),
                          child: StaticInfoWithImage(),
                        ),
                      ),
                    Expanded(
                      flex: isMobile ? 1 : 1,
                      child: Column(
                        children: [
                          Text(
                            "Welcome Back",
                            style: GoogleFonts.poppins(
                              fontSize: 28,
                              fontWeight: FontWeight.w600,
                              color: AppColors.white,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            _isSignIn
                                ? "Sign in to continue"
                                : "Create your account",
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              color: AppColors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 32),
                          GoogleSignInButton(onPressed: _signInWithGoogle),
                          const SizedBox(height: 24),
                          _AuthCard(
                            isSignIn: _isSignIn,
                            emailController: _emailController,
                            passwordController: _passwordController,
                            mobileController: _mobileNumberController,
                            showPassword: _showPassword,
                            onTogglePassword: () =>
                                setState(() => _showPassword = !_showPassword),
                            onSignIn: _signIn,
                            onSignUp: _signUp,
                          ),
                          const SizedBox(height: 24),
                          TextButton(
                            onPressed: _toggleForm,
                            child: Text(
                              _isSignIn
                                  ? "Don't have an account? Create one"
                                  : "Already have an account? Sign in",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: AppColors.white.withOpacity(0.9),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          if (isMobile) StaticInfoWithImage(),
                          if (_isLoading)
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              padding: const EdgeInsets.all(20),
                              child: const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.white),
                                strokeWidth: 3,
                              ),
                            ),
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
  }
}

class StaticInfoWithImage extends StatelessWidget {
  const StaticInfoWithImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Unlock Your\nLearning Potential",
          style: GoogleFonts.poppins(
            fontSize: 36,
            fontWeight: FontWeight.w700,
            color: AppColors.white,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          "Join 50K+ learners mastering\nskills that matter most",
          style: GoogleFonts.poppins(
            fontSize: 18,
            color: AppColors.white,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 40),
        Container(
          width: double.infinity,
          height: 300,
          decoration: BoxDecoration(
            color: AppColors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.white.withOpacity(0.2)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'assets/student_home/reg.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: AppColors.white.withOpacity(0.1),
                child: Icon(
                  Icons.school_outlined,
                  size: 100,
                  color: AppColors.white.withOpacity(0.8),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _AuthCard extends StatefulWidget {
  final bool isSignIn;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController mobileController;
  final bool showPassword;
  final VoidCallback onTogglePassword;
  final VoidCallback onSignIn;
  final VoidCallback onSignUp;

  const _AuthCard({
    required this.isSignIn,
    required this.emailController,
    required this.passwordController,
    required this.mobileController,
    required this.showPassword,
    required this.onTogglePassword,
    required this.onSignIn,
    required this.onSignUp,
  });

  @override
  __AuthCardState createState() => __AuthCardState();
}

class __AuthCardState extends State<_AuthCard> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 420),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.12),
            blurRadius: 30,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _CustomTextField(
              controller: widget.emailController,
              label: "Email",
              icon: Icons.email_outlined,
              keyboard: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            _CustomTextField(
              controller: widget.passwordController,
              label: "Password",
              icon: Icons.lock_outlined,
              obscure: true,
              showPassword: widget.showPassword,
              onTogglePassword: widget.onTogglePassword,
            ),
            if (!widget.isSignIn) ...[
              const SizedBox(height: 20),
              _CustomTextField(
                controller: widget.mobileController,
                label: "Mobile Number",
                icon: Icons.phone_outlined,
                keyboard: TextInputType.phone,
              ),
            ],
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.brandBlue,
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                onPressed: widget.isSignIn
                    ? () {
                        if (_formKey.currentState!.validate())
                          widget.onSignIn();
                      }
                    : () {
                        if (_formKey.currentState!.validate())
                          widget.onSignUp();
                      },
                child: Text(
                  widget.isSignIn ? "Sign In" : "Get Started",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final TextInputType? keyboard;
  final bool obscure;
  final bool showPassword;
  final VoidCallback? onTogglePassword;

  const _CustomTextField({
    required this.controller,
    required this.label,
    required this.icon,
    this.keyboard,
    this.obscure = false,
    this.showPassword = false,
    this.onTogglePassword,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboard,
      obscureText: obscure && !showPassword,
      validator: (value) {
        if (value == null || value.isEmpty) return 'This field is required';
        if (keyboard == TextInputType.emailAddress && !value.contains('@'))
          return 'Enter valid email';
        if (keyboard == TextInputType.phone && value.length != 10)
          return 'Enter 10-digit number';
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppColors.brandBlue),
        suffixIcon: onTogglePassword != null
            ? IconButton(
                icon: Icon(
                    showPassword ? Icons.visibility : Icons.visibility_off,
                    color: AppColors.brandBlue),
                onPressed: onTogglePassword,
              )
            : null,
        filled: true,
        fillColor: AppColors.backgroundLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.brandBlue, width: 2),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        labelStyle: TextStyle(color: AppColors.textLight),
      ),
      style: GoogleFonts.poppins(color: AppColors.textPrimary),
    );
  }
}

class GoogleSignInButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GoogleSignInButton({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: FaIcon(FontAwesomeIcons.google,
                      size: 20, color: Colors.red.shade600),
                ),
                const SizedBox(width: 16),
                Text(
                  'Continue with Google',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

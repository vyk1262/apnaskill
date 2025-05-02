import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
// import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../constants/colors.dart';
import '../custom_app_bar.dart';
import '../model/user_model.dart';
import '../widgets/home_page_widgets/cta_button.dart';
import '../widgets/sign_in_screen_widgets/auth_screen_ui_widget.dart';
import 'courses_home.dart';

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
  final TextEditingController _upiTraIdController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _mobileNumberController.dispose();
    _upiTraIdController.dispose();
    super.dispose();
  }

  void _toggleForm() {
    setState(() {
      _isSignIn = !_isSignIn;
    });
  }

  Future<void> _showErrorDialog(String message) async {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _signIn() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showErrorDialog('Please enter valid credentials');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      context.go('/quizzes');
    } on FirebaseAuthException catch (e) {
      _showErrorDialog('Sign-in failed: ${e.message}');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _signUp() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final mobileNumber = _mobileNumberController.text.trim();
    final upiTraId = _upiTraIdController.text.trim();

    // Simple validation
    if ([email, password, mobileNumber, upiTraId]
        .any((field) => field.isEmpty)) {
      _showErrorDialog('Please fill all fields');
      return;
    }

    // Format validation for mobile number and date of birth
    final mobileRegExp = RegExp(r'^[0-9]{10}$');
    if (!mobileRegExp.hasMatch(mobileNumber)) {
      _showErrorDialog('Please enter a valid 10-digit mobile number');
      return;
    }

    try {
      setState(() {
        _isLoading = true;
      });

      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'email': email,
          'mobileNumber': mobileNumber,
          'createdAt': Timestamp.now(),
        });

        Provider.of<UserModel>(context, listen: false).setUserId(user.email);
        context.go('/quizzes');
      }
    } on FirebaseAuthException catch (e) {
      _showErrorDialog('Sign-up failed: ${e.message}');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            constraints: BoxConstraints(maxWidth: 400),
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Auth Card
                Card(
                  elevation: 15,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: _isSignIn
                        ? SignInForm(
                            emailController: _emailController,
                            passwordController: _passwordController,
                            onSignIn: _signIn,
                            onGoogleSignIn: _signInWithGoogle,
                          )
                        : SignUpForm(
                            emailController: _emailController,
                            passwordController: _passwordController,
                            mobileNumberController: _mobileNumberController,
                            onSignUp: _signUp,
                          ),
                  ),
                ),
                SizedBox(height: 30),

                // Toggle Button
                buildCtaButton(
                  text: _isSignIn
                      ? 'Create New Account'
                      : 'Already Have an Account?',
                  onPressed: _toggleForm,
                ),

                if (_isLoading)
                  Container(
                    color: Colors.black.withOpacity(0.5),
                    child: Center(
                      child: CircularProgressIndicator.adaptive(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signInWithGoogle() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        // The user canceled the sign-in
        setState(() {
          _isLoading = false;
        });
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with Google
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null) {
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (!userDoc.exists) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set({
            'email': user.email,
            'createdAt': Timestamp.now(),
          });
        }
      }

      context.go('/quizzes');
    } on FirebaseAuthException catch (e) {
      _showErrorDialog('Google Sign-In failed: ${e.message}');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}

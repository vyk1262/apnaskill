import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// removed go_router usage - will use Navigator
import 'package:skill_factorial/screens/courses_home.dart';
// import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../constants/colors.dart';
import 'package:skill_factorial/api_service.dart';
import 'common_widgets/custom_app_bar.dart';
import '../model/user_model.dart';
import 'common_widgets/cta_button.dart';
import 'package:skill_factorial/screens/common_widgets/cta_button.dart';
import '../../constants/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const QuizListHome()),
      );
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
    if ([email, password, mobileNumber].any((field) => field.isEmpty)) {
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
        await ApiService.updateUserData(user.uid, {
          'email': email,
          'mobileNumber': mobileNumber,
          'createdAt': Timestamp.now(),
        });

        Provider.of<UserModel>(context, listen: false).setUserId(user.email);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const QuizListHome()),
        );
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
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 768; // Adjust threshold as needed
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Row(
            children: [
              isMobile
                  ? Container()
                  : Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Master Every Skill with Skill Factorial",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              "Target the skills that matter most to you. and unlock your full potential.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 50),
                            // Image with a subtle shadow/float effect
                            Hero(
                              tag: 'auth_img',
                              child: Image.asset(
                                'assets/student_home/sfcmp.png',
                                height: 350,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GoogleSignInButton(
                      onPressed: _signInWithGoogle,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'OR',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Toggle Button
                    buildCtaButton(
                      text: _isSignIn
                          ? 'Create New Account'
                          : 'Already Have an Account?',
                      onPressed: _toggleForm,
                    ),
                    const SizedBox(height: 20),
                    // Auth Card
                    Card(
                      elevation: 15,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          color: Colors.purple.shade100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: _isSignIn
                            ? SignInForm(
                                emailController: _emailController,
                                passwordController: _passwordController,
                                onSignIn: _signIn,
                              )
                            : SignUpForm(
                                emailController: _emailController,
                                passwordController: _passwordController,
                                mobileNumberController: _mobileNumberController,
                                onSignUp: _signUp,
                              ),
                      ),
                    ),
                    SizedBox(height: 10),
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
            ],
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
        setState(() {
          _isLoading = false;
        });
        return;
      }

      debugPrint(
          'Google Sign-In successful. Google user ID: ${googleUser.id}, email: ${googleUser.email}');

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
          debugPrint('User document does not exist. Creating new document...');
          await ApiService.updateUserData(user.uid, {
            'email': user.email,
            'createdAt': Timestamp.now(),
          });
        } else {
          debugPrint('User document already exists in Firestore.');
        }
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const QuizListHome()),
        );
      } else {
        debugPrint('Firebase User object is null after Google Sign-In.');
      }
    } on FirebaseAuthException catch (e) {
      debugPrint('FirebaseAuthException during Google Sign-In: ${e.message}');
      _showErrorDialog('Google Sign-In failed');
    } catch (e) {
      debugPrint('An unexpected error occurred during Google Sign-In: $e');
      _showErrorDialog('An unexpected error occurred during Sign-In.');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}

class SignInForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onSignIn;

  const SignInForm({
    Key? key,
    required this.emailController,
    required this.passwordController,
    required this.onSignIn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(color: Colors.black),
          decoration: const InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.email),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: passwordController,
          obscureText: true,
          style: const TextStyle(color: Colors.black),
          decoration: const InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.lock),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          ),
          onPressed: onSignIn,
          child: const Text('Sign In', style: TextStyle(fontSize: 16)),
        ),
      ],
    );
  }
}

class SignUpForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController mobileNumberController;
  final VoidCallback onSignUp;

  const SignUpForm({
    Key? key,
    required this.emailController,
    required this.passwordController,
    required this.mobileNumberController,
    required this.onSignUp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.email),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: passwordController,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.lock),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: mobileNumberController,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
            labelText: 'Mobile Number',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.phone),
          ),
        ),
        const SizedBox(height: 16),
        buildCtaButton(text: "Sign Up", onPressed: onSignUp),
      ],
    );
  }
}

class GoogleSignInButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GoogleSignInButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(
                  FontAwesomeIcons.google,
                  size: 20,
                  color: Colors.red.shade600,
                ),
                const SizedBox(width: 12),
                const Text(
                  'Continue with Google',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
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

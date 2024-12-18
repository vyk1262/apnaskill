import 'package:apnaskill/constants/colors.dart';
import 'package:apnaskill/model/user_model.dart';
import 'package:apnaskill/screens/courses_home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _upiTraIdController = TextEditingController();

  bool _isLoading = false;

  final List<String> internshipsList = [
    'Python Programming',
    'Web Development',
    'Internship C'
  ];
  String? _selectedInternship;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _dateOfBirthController.dispose();
    _genderController.dispose();
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
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => CoursesHomeScreen()));
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
    final name = _nameController.text.trim();
    final dateOfBirth = _dateOfBirthController.text.trim();
    final gender = _genderController.text.trim();
    final mobileNumber = _mobileNumberController.text.trim();
    final upiTraId = _upiTraIdController.text.trim();

    // Simple validation
    if ([email, password, name, dateOfBirth, gender, mobileNumber, upiTraId]
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
          'name': name,
          'dateOfBirth': dateOfBirth,
          'gender': gender,
          'mobileNumber': mobileNumber,
          'internshipsList': [
            {
              'internshipName': _selectedInternship,
              'upiTraId': upiTraId,
            }
          ],
          'createdAt': Timestamp.now(),
        });

        Provider.of<UserModel>(context, listen: false).setUserId(user.email);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => CoursesHomeScreen()));
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
      // backgroundColor: AppColors.primaryColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Internships',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor),
              ),
              const SizedBox(height: 0),
              const Text(
                'by ApnsSkill',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _isSignIn ? _buildSignInForm() : _buildSignUpForm(),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: _toggleForm,
                child: Text(
                  _isSignIn
                      ? 'Don\'t have an account? Sign Up'
                      : 'Already have an account? Sign In',
                  style: const TextStyle(color: AppColors.primaryColor),
                ),
              ),
              if (_isLoading) const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignInForm() {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          onPressed: _signInWithGoogle,
          child: const Text(
            'Continue with Google',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'OR',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            // color: AppColors.primaryColor,
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.email),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _passwordController,
          obscureText: true,
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
          onPressed: _signIn,
          child: const Text('Sign In', style: TextStyle(fontSize: 16)),
        ),
      ],
    );
  }

  Widget _buildSignUpForm() {
    return Column(
      children: [
        TextField(
          controller: _nameController,
          decoration: const InputDecoration(
            labelText: 'Full Name',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.person),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.email),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.lock),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _dateOfBirthController,
          keyboardType: TextInputType.datetime,
          decoration: const InputDecoration(
            labelText: 'Date of Birth (DD/MM/YYYY)',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.calendar_today),
          ),
          onTap: () async {
            FocusScope.of(context).requestFocus(FocusNode());
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (pickedDate != null) {
              _dateOfBirthController.text =
                  DateFormat('dd/MM/yyyy').format(pickedDate);
            }
          },
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _genderController,
          decoration: const InputDecoration(
            labelText: 'Gender',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.person_outline),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _mobileNumberController,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
            labelText: 'Mobile Number',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.phone),
          ),
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          value: _selectedInternship,
          hint: const Text('Select Subject'),
          onChanged: (String? newValue) {
            setState(() {
              _selectedInternship = newValue;
            });
          },
          items: internshipsList.map((String internship) {
            return DropdownMenuItem<String>(
              value: internship,
              child: Text(internship),
            );
          }).toList(),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
          ),
        ),
        const SizedBox(height: 16),
        Column(
          children: [
            const Text(
              'Scan the QR code below to pay',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Image.asset(
              'assets/ai.jpg',
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
          ],
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _upiTraIdController,
          decoration: const InputDecoration(
            labelText: 'UPI Transaction ID',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.payment),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          ),
          onPressed: _signUp,
          child: const Text('Sign Up', style: TextStyle(fontSize: 16)),
        ),
      ],
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

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CoursesHomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      _showErrorDialog('Google Sign-In failed: ${e.message}');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}

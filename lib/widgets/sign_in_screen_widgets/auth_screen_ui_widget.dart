import 'package:flutter/material.dart';
import 'package:skill_factorial/widgets/home_page_widgets/cta_button.dart';
import '../../constants/colors.dart';
import 'google_sign_in_button.dart';

class SignInForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onSignIn;
  final VoidCallback onGoogleSignIn;

  const SignInForm({
    Key? key,
    required this.emailController,
    required this.passwordController,
    required this.onSignIn,
    required this.onGoogleSignIn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GoogleSignInButton(
          onPressed: onGoogleSignIn,
        ),
        // const SizedBox(height: 20),
        // const Text(
        //   'OR',
        //   style: TextStyle(
        //     fontSize: 28,
        //     fontWeight: FontWeight.bold,
        //     color: Colors.white,
        //   ),
        // ),
        // const SizedBox(height: 20),
        // TextField(
        //   controller: emailController,
        //   keyboardType: TextInputType.emailAddress,
        //   style: const TextStyle(color: Colors.white),
        //   decoration: const InputDecoration(
        //     labelText: 'Email',
        //     border: OutlineInputBorder(),
        //     prefixIcon: Icon(Icons.email),
        //   ),
        // ),
        // const SizedBox(height: 16),
        // TextField(
        //   controller: passwordController,
        //   obscureText: true,
        //   style: const TextStyle(color: Colors.white),
        //   decoration: const InputDecoration(
        //     labelText: 'Password',
        //     border: OutlineInputBorder(),
        //     prefixIcon: Icon(Icons.lock),
        //   ),
        // ),
        // const SizedBox(height: 16),
        // ElevatedButton(
        //   style: ElevatedButton.styleFrom(
        //     backgroundColor: AppColors.primaryColor,
        //     padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        //   ),
        //   onPressed: onSignIn,
        //   child: const Text('Sign In', style: TextStyle(fontSize: 16)),
        // ),
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

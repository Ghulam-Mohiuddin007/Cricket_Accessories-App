import 'dart:async';
import 'package:cricket_accessories/customer/view/splash/welcome.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  Future<void> _navigateToLogin() async {
    await Future.delayed(const Duration(seconds: 5));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginChoiceScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App logo
            CircleAvatar(
              radius: 200,
              backgroundColor: Colors.transparent,
              child: Image.asset('assests/images/logo.png'),
            ),
            const SizedBox(height: 20),

            // App Name
            const Text(
              'Cricket Accessories',
              style: TextStyle(
                color: Colors.green,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 30),

            // Loading indicator
            const CircularProgressIndicator(
              color: Colors.green,
              strokeWidth: 3,
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cricket_accessories/login.dart';

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
        MaterialPageRoute(builder: (context) => const Login()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
                color: Colors.yellow,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 30),

            // Loading indicator
            const CircularProgressIndicator(
              color: Colors.yellow,
              strokeWidth: 3,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:cricket_accessories/customer/view/home/home.dart';
import 'package:flutter/material.dart';

class ThankYouScreen extends StatelessWidget {
  final Map<String, String> userData;
  final List<Map<String, dynamic>> item;
  ThankYouScreen({super.key, required this.userData, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Success Icon
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.greenAccent.withOpacity(0.1),
                ),
                padding: const EdgeInsets.all(20),
                child: const Icon(
                  Icons.check_circle,
                  color: Colors.greenAccent,
                  size: 100,
                ),
              ),
              const SizedBox(height: 30),

              // Thank You Text
              const Text(
                "Thank You!",
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),
              const Text(
                "Your order has been placed successfully.",
                style: TextStyle(fontSize: 16, color: Colors.black),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),

              // Back to Home Button
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(
                        name: userData['name'] ?? '',
                        email: userData['email'] ?? '',

                        initialOrder: userData,
                        itemdetail: item, // Add order to history
                      ),
                    ),
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.home, color: Colors.white),
                label: const Text(
                  "Back to Home",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

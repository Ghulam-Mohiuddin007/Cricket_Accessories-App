import 'package:cricket_accessories/customer/view/auth/login.dart';
import 'package:cricket_accessories/seller/auth/login.dart';

import 'package:flutter/material.dart';

class LoginChoiceScreen extends StatelessWidget {
  const LoginChoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.green.shade800,
              Colors.green.shade400,
              Colors.white,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              double screenWidth = constraints.maxWidth;
              double screenHeight = constraints.maxHeight;

              double cardHeight = screenHeight * 0.18;
              double cardWidth = screenWidth * 0.85;
              double fontSize = screenWidth * 0.05;

              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: screenHeight * 0.07),

                    // App Icon
                    CircleAvatar(
                      radius: screenWidth * 0.15,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.sports_cricket,
                        size: screenWidth * 0.18,
                        color: Colors.green.shade700,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),

                    // Title
                    Text(
                      "Welcome to Cricket Store",
                      style: TextStyle(
                        fontSize: screenWidth * 0.07,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            offset: const Offset(2, 2),
                            blurRadius: 4,
                            color: Colors.black26,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: screenHeight * 0.08),

                    // Customer Card
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: ((context) => Login())),
                        );
                      },
                      child: _buildOptionCard(
                        width: cardWidth,
                        height: cardHeight,
                        icon: Icons.person,
                        title: "Login as Customer",
                        color: Colors.green.shade600,
                        fontSize: fontSize,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),

                    // Seller Card
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => Login_seller()),
                          ),
                        );
                      },
                      child: _buildOptionCard(
                        width: cardWidth,
                        height: cardHeight,
                        icon: Icons.storefront,
                        title: "Login as Seller",
                        color: Colors.white,
                        fontSize: fontSize,
                        border: true,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.05),

                    // Footer
                    Text(
                      "Choose your role to continue",
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        color: Colors.white70,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // Custom Card Widget
  Widget _buildOptionCard({
    required double width,
    required double height,
    required IconData icon,
    required String title,
    required Color color,
    required double fontSize,
    bool border = false,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: border ? Colors.white : color,
        borderRadius: BorderRadius.circular(20),
        border: border
            ? Border.all(color: Colors.green.shade600, width: 2)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: const Offset(2, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: fontSize * 1.4,
            color: border ? Colors.green.shade700 : Colors.white,
          ),
          const SizedBox(width: 15),
          Text(
            title,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              color: border ? Colors.green.shade700 : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

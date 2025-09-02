import 'package:cricket_accessories/customer/view/auth/login.dart';
import 'package:cricket_accessories/seller/auth/login.dart';
import 'package:flutter/material.dart';

class LoginChoiceScreen extends StatelessWidget {
  const LoginChoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.green.shade900,
              Colors.green.shade600,
              Colors.green.shade300,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.06,
                vertical: screenHeight * 0.04,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight * 0.02),

                  // Logo
                  CircleAvatar(
                    radius: screenWidth * 0.17,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.sports_cricket,
                      size: screenWidth * 0.2,
                      color: Colors.green.shade700,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),

                  // Title
                  FittedBox(
                    child: Text(
                      "Cricket Accessories Store",
                      style: TextStyle(
                        fontSize: screenWidth * 0.065,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                        shadows: [
                          Shadow(
                            offset: const Offset(2, 2),
                            blurRadius: 6,
                            color: Colors.black38,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),

                  // Customer Card
                  _buildResponsiveCard(
                    context: context,
                    icon: Icons.person_outline,
                    title: "Continue as Customer",
                    color: Colors.green.shade700,
                    border: false,
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                  ),
                  SizedBox(height: screenHeight * 0.03),

                  // Seller Card
                  _buildResponsiveCard(
                    context: context,
                    icon: Icons.storefront_outlined,
                    title: "Continue as Seller",
                    color: Colors.white,
                    border: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login_seller()),
                      );
                    },
                  ),
                  SizedBox(height: screenHeight * 0.05),

                  // Footer
                  FittedBox(
                    child: Text(
                      "Select your role to login",
                      style: TextStyle(
                        fontSize: screenWidth * 0.042,
                        color: Colors.white70,
                        fontStyle: FontStyle.italic,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // More responsive card
  Widget _buildResponsiveCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required Color color,
    required bool border,
    required VoidCallback onTap,
  }) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      splashColor: Colors.green.withOpacity(0.2),
      child: Container(
        width: screenWidth * 0.85,
        height: screenHeight * 0.16,
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.06,
          vertical: screenHeight * 0.02,
        ),
        decoration: BoxDecoration(
          gradient: border
              ? null
              : LinearGradient(
                  colors: [color.withOpacity(0.9), color.withOpacity(0.7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          color: border ? Colors.white : null,
          borderRadius: BorderRadius.circular(20),
          border: border
              ? Border.all(color: Colors.green.shade700, width: 2)
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: const Offset(2, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: screenWidth * 0.1,
              color: border ? Colors.green.shade700 : Colors.white,
            ),
            SizedBox(width: screenWidth * 0.04),
            Flexible(
              child: FittedBox(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.w600,
                    color: border ? Colors.green.shade700 : Colors.white,
                    letterSpacing: 0.8,
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

import 'dart:io';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String shopName;
  final String address;
  final String phone;
  final String email;
  final File? imageFile;

  const ProfileScreen({
    super.key,
    required this.shopName,
    required this.address,
    required this.phone,
    required this.email,
    this.imageFile,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Shop Profile"),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade700, Colors.green.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 100),
          child: Center(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              elevation: 12,
              shadowColor: Colors.black45,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.green.shade100,
                      backgroundImage: imageFile != null
                          ? FileImage(imageFile!)
                          : null,
                      child: imageFile == null
                          ? Icon(
                              Icons.store,
                              size: 50,
                              color: Colors.green.shade700,
                            )
                          : null,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      shopName,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    _buildInfoTile(Icons.location_on, "Address", address),
                    _buildInfoTile(Icons.phone, "Phone", phone),
                    _buildInfoTile(Icons.email, "Email", email),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.green.shade50,
            child: Icon(icon, color: Colors.green.shade700),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

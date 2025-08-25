import 'dart:io';
import 'package:cricket_accessories/seller/auth/seller_home.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ShopFormScreen extends StatefulWidget {
  final String sellerName;
  const ShopFormScreen({super.key, required this.sellerName});

  @override
  State<ShopFormScreen> createState() => _ShopFormScreenState();
}

class _ShopFormScreenState extends State<ShopFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _shopNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  File? _imageFile;

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _imageFile = File(picked.path);
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => SellerHomeScreen(
            shopName: _shopNameController.text,
            address: _addressController.text,
            phone: _phoneController.text,
            email: _emailController.text,
            imageFile: _imageFile,
            sellerName: widget.sellerName,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Shop Registration")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _imageFile != null
                      ? FileImage(_imageFile!)
                      : null,
                  child: _imageFile == null
                      ? const Icon(Icons.camera_alt, size: 40)
                      : null,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _shopNameController,
                decoration: const InputDecoration(labelText: "Shop Name"),
                validator: (val) => val!.isEmpty ? "Enter shop name" : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: "Address"),
                validator: (val) => val!.isEmpty ? "Enter address" : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: "Phone Number"),
                keyboardType: TextInputType.phone,
                validator: (val) => val!.isEmpty ? "Enter phone number" : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: "Email Address"),
                keyboardType: TextInputType.emailAddress,
                validator: (val) => val!.isEmpty ? "Enter email" : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _submitForm, child: const Text("Next")),
            ],
          ),
        ),
      ),
    );
  }
}

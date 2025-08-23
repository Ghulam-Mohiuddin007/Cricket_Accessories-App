import 'package:flutter/material.dart';
import 'package:cricket_accessories/customer/view/home/home.dart';

class Singup extends StatefulWidget {
  const Singup({super.key});

  @override
  State<Singup> createState() => _SingupState();
}

class _SingupState extends State<Singup> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(flex: 1, child: SizedBox(height: 10)),
              Expanded(
                flex: 4,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF2E7D32), // primary green
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(height: height * 0.06),
                          const Text(
                            'Signup',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 45,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          SizedBox(height: height * 0.03),

                          // Name
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextFormField(
                              controller: name,
                              style: const TextStyle(color: Colors.white),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter name';
                                }
                                return null;
                              },
                              decoration: _inputDecoration('Name'),
                            ),
                          ),
                          SizedBox(height: height * 0.035),

                          // Email
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextFormField(
                              controller: email,
                              style: const TextStyle(color: Colors.white),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter email';
                                } else if (!value.contains('@')) {
                                  return 'Please enter valid email';
                                }
                                return null;
                              },
                              decoration: _inputDecoration('Email'),
                            ),
                          ),
                          SizedBox(height: height * 0.035),

                          // Password
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextFormField(
                              controller: password,
                              style: const TextStyle(color: Colors.white),
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter password';
                                } else if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                              decoration: _inputDecoration('Password'),
                            ),
                          ),
                          SizedBox(height: height * 0.035),

                          // Confirm Password
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextFormField(
                              controller: confirmPassword,
                              style: const TextStyle(color: Colors.white),
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please confirm password';
                                } else if (value != password.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                              decoration: _inputDecoration('Confirm Password'),
                            ),
                          ),
                          SizedBox(height: height * 0.06),

                          // Signup Button
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: SizedBox(
                              height: 50,
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: ((context) => HomeScreen(
                                          name: name.text,
                                          email: email.text,
                                          itemdetail: [],
                                        )),
                                      ),
                                    );
                                  }
                                },
                                child: const Text(
                                  "Signup",
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Logo on Top
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 200,
              child: Image.asset('assests/images/logo.png'),
            ),
          ),
        ],
      ),
    );
  }

  /// Input field decoration with white border
  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      label: Text(label, style: const TextStyle(color: Colors.white)),
      hintText: 'Enter $label',
      hintStyle: const TextStyle(color: Colors.white70),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(30),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(30),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white, width: 2),
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }
}

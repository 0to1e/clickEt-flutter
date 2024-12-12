import 'package:flutter/material.dart';
import 'package:ClickEt/common/button.dart'; // Assuming you have a custom Button widget
import 'package:ClickEt/views/login_screen.dart'; // Import the Login screen

class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  // For password visibility toggle
  bool _isPasswordVisible = false;

  // Controllers for TextFields
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _userNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(35, 60, 35, 20),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Top Icon (Logo)
              Image.asset(
                "lib/assets/Logo.png",
                width: 150,
              ),
              const SizedBox(height: 20),
              // Title and Subtitle
              Text(
                "Create an Account",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 4),
              Text(
                "Please fill in the details to sign up",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 30),
              // Registration Form
              Form(
                child: Column(
                  children: [
                    // Full Name Input

                    TextField(
                      controller: _fullNameController,
                      decoration: InputDecoration(
                        labelText: 'Full name',
                        labelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 14.0, horizontal: 30.0),
                        constraints: const BoxConstraints(
                          minHeight: 50.0,
                          maxHeight: 50.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    TextField(
                      controller: _userNameController,
                      decoration: InputDecoration(
                        labelText: 'User name',
                        labelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        prefixIcon: Icon(
                          Icons.account_circle,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 14.0, horizontal: 30.0),
                        constraints: const BoxConstraints(
                          minHeight: 50.0,
                          maxHeight: 50.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email-address',
                        labelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 14.0, horizontal: 30.0),
                        constraints: const BoxConstraints(
                          minHeight: 50.0,
                          maxHeight: 50.0,
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 18),
                    TextField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        labelText: 'Phone number',
                        labelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        prefixIcon: Icon(
                          Icons.phone,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 14.0, horizontal: 30.0),
                        constraints: const BoxConstraints(
                          minHeight: 50.0,
                          maxHeight: 50.0,
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 18),
                    // Password Input with Visibility Toggle
                    TextField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 14.0, horizontal: 30.0),
                        constraints: const BoxConstraints(
                          minHeight: 50.0,
                          maxHeight: 50.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              // Submit Button
              Button(
                width: 150.0,
                onPressed: () {
                  // Handle registration logic here
                  // Navigate to Dashboard or another screen after registration
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginView(),
                    ),
                  );
                },
                text: "Sign Up",
              ),
              const SizedBox(height: 30),
              // Login Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginView(),
                        ),
                      );
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationColor: Theme.of(context).colorScheme.primary,
                        decorationThickness: 2.0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

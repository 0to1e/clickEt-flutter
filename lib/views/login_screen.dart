import 'package:ClickEt/views/dash_board_screen.dart';
import 'package:flutter/material.dart';
import 'package:ClickEt/common/button.dart';
import 'package:ClickEt/views/registration_screen.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _usernameEmailController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context)
          .scaffoldBackgroundColor, // Use the scaffold background color directly
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(35, 100, 35, 20),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Top Icon
              Image.asset(
                "lib/assets/Logo.png",
                width: 150,
              ),
              const SizedBox(height: 40),
              // Title and Subtitle
              Text(
                "Welcome Back!",
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge, // Use headlineLarge directly from the theme
              ),
              const SizedBox(height: 8),
              Text(
                "Please login to your account",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge, // Use bodyLarge directly from the theme
              ),
              const SizedBox(height: 40),
              // Login Form
              Form(
                child: Column(
                  children: [
                    // Email/Username Input
                    TextField(
                      controller: _usernameEmailController,
                      decoration: InputDecoration(
                        labelText: 'username/E-mail',
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
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 18),
                    // Password Input
                    TextField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 15),
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
              const SizedBox(height: 60),
              Button(
                fontSize: 25,
                width: 150.0,
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DashboardScreen(),
                    ),
                  );
                },
                text: "Sign in",
              ),
              const SizedBox(height: 40),
              // Signup Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? ",
                      style: Theme.of(context).textTheme.bodyLarge),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegistrationView(),
                        ),
                      );
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .primary, // Use primary color for the link
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          decorationColor:
                              Theme.of(context).colorScheme.primary,
                          decorationThickness: 2.0),
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

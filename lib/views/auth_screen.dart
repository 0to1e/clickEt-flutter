import 'package:flutter/material.dart';
import 'package:ClickEt/common/button.dart';
import 'package:ClickEt/views/login_screen.dart';
import 'package:ClickEt/views/registration_screen.dart';

class AuthScreenView extends StatelessWidget {
  const AuthScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                        "lib/assets/illustrations/onboarding/combined.png"),
                    const SizedBox(height: 32.0),
                    Text(
                      'Unlock the Movie Magic',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'Sign in or create an account to start planning your next cinema adventure.',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Button(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginView()),
                      );
                    },
                    text: 'Sign In',
                  ),
                  const SizedBox(height: 16.0),
                  Button(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegistrationView()),
                      );
                    },
                    backgroundColor: Colors.transparent,
                    textColor: Theme.of(context).colorScheme.primary,
                    text: 'Sign Up',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

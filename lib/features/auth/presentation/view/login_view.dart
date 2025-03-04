import 'package:ClickEt/app/di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ClickEt/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:ClickEt/common/button.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LoginBloc>(),
      child: const LoginViewContent(),
    );
  }
}

class LoginViewContent extends StatelessWidget {
  const LoginViewContent({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController userNameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 8),
              Text(
                "Please login to your account",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 40),
              // Login Form
              Form(
                child: Column(
                  children: [
                    // Email/Username Input
                    TextField(
                      controller: userNameController,
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
                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        return TextField(
                          controller: passwordController,
                          obscureText: !state.isPasswordVisible,
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
                                state.isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                context
                                    .read<LoginBloc>()
                                    .add(const TogglePasswordVisibilityEvent());
                              },
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 14.0, horizontal: 30.0),
                            constraints: const BoxConstraints(
                              minHeight: 50.0,
                              maxHeight: 50.0,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),
              // Sign In Button
              Button(
                fontSize: 25,
                width: 150.0,
                onPressed: () {
                  context.read<LoginBloc>().add(
                        LoginSubmittedEvent(
                          context: context,
                          username: userNameController.text,
                          password: passwordController.text,
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
                      context.read<LoginBloc>().navigateToRegister(context);
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
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

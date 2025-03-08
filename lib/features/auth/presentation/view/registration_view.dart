import 'package:ClickEt/app/di/di.dart';
import 'package:ClickEt/common/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ClickEt/features/auth/presentation/view_model/register/register_bloc.dart';

class RegistrationView extends StatelessWidget {
  const RegistrationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<RegisterBloc>(),
      child: const RegistrationViewContent(),
    );
  }
}

class RegistrationViewContent extends StatefulWidget {
  const RegistrationViewContent({super.key});

  @override
  State<RegistrationViewContent> createState() => _RegistrationViewContentState();
}

class _RegistrationViewContentState extends State<RegistrationViewContent> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    fullNameController.dispose();
    userNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
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
              Image.asset(
                "lib/assets/Logo.png",
                width: 150,
              ),
              const SizedBox(height: 20),
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
              Form(
                child: Column(
                  children: [
                    TextField(
                      controller: fullNameController,
                      decoration: InputDecoration(
                        labelText: 'Full name',
                        labelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 15,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 14.0,
                          horizontal: 30.0,
                        ),
                        constraints: const BoxConstraints(
                          minHeight: 50.0,
                          maxHeight: 50.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    TextField(
                      controller: userNameController,
                      decoration: InputDecoration(
                        labelText: 'User name',
                        labelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 15,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        prefixIcon: Icon(
                          Icons.account_circle,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 14.0,
                          horizontal: 30.0,
                        ),
                        constraints: const BoxConstraints(
                          minHeight: 50.0,
                          maxHeight: 50.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email-address',
                        labelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 15,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 14.0,
                          horizontal: 30.0,
                        ),
                        constraints: const BoxConstraints(
                          minHeight: 50.0,
                          maxHeight: 50.0,
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 18),
                    TextField(
                      controller: phoneController,
                      decoration: InputDecoration(
                        labelText: 'Phone number',
                        labelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 15,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        prefixIcon: Icon(
                          Icons.phone,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 14.0,
                          horizontal: 30.0,
                        ),
                        constraints: const BoxConstraints(
                          minHeight: 50.0,
                          maxHeight: 50.0,
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 18),
                    BlocBuilder<RegisterBloc, RegisterState>(
                      builder: (context, state) {
                        return TextField(
                          controller: passwordController,
                          obscureText: !state.isPasswordVisible,
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
                                state.isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                context
                                    .read<RegisterBloc>()
                                    .add(const TogglePasswordVisibilityEvent());
                              },
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 14.0,
                              horizontal: 30.0,
                            ),
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
              const SizedBox(height: 40),
              Button(
                width: 150.0,
                onPressed: () {
                  context.read<RegisterBloc>().add(
                        RegisterUser(
                          context: context,
                          fullName: fullNameController.text,
                          username: userNameController.text,
                          email: emailController.text,
                          phone: phoneController.text,
                          password: passwordController.text,
                        ),
                      );
                },
                text: "Sign Up",
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<RegisterBloc>().navigateToLogin(context);
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
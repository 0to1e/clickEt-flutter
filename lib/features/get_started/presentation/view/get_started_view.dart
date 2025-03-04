import 'package:flutter/material.dart';

import 'package:ClickEt/common/button.dart';
import 'package:ClickEt/features/get_started/presentation/view_model/get_started_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetStartedView extends StatelessWidget {
  const GetStartedView({super.key});

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
                      "lib/assets/illustrations/onboarding/combined.png",
                    ),
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
                      context.read<GetStartedCubit>().navigateToLogin(context);
                    },
                    text: 'Sign In',
                  ),
                  const SizedBox(height: 16.0),
                  Button(
                    onPressed: () {
                      context
                          .read<GetStartedCubit>()
                          .navigateToRegistration(context);
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

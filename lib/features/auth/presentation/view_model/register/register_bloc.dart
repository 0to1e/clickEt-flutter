import 'dart:io';
import 'package:ClickEt/app/di/di.dart';
import 'package:ClickEt/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ClickEt/features/auth/domain/use_case/register_use_case.dart';
import 'package:ClickEt/features/auth/presentation/view/login_view.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase _registerUseCase;

  RegisterBloc({required RegisterUseCase registerUseCase})
      : _registerUseCase = registerUseCase,
        super(RegisterState.initial()) {
    on<RegisterUser>(_onRegisterUser);
    on<TogglePasswordVisibilityEvent>(_onTogglePasswordVisibility);
    on<NavigateToLoginEvent>(_onNavigateToLogin);
  }

  String? _validateRegistrationForm({
    required String fullName,
    required String userName,
    required String email,
    required String phone,
    required String password,
  }) {

    if (fullName.isEmpty ||
        userName.isEmpty ||
        email.isEmpty ||
        phone.isEmpty ||
        password.isEmpty) {
      return "All fields are required";
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      return "Please enter a valid email address";
    }

    final phoneRegex = RegExp(r'^\d{10}$');
    if (!phoneRegex.hasMatch(phone)) {
      return "Please enter a valid 10-digit phone number";
    }

    if (password.length < 8) {
      return "Password must be at least 8 characters long";
    }

    return null; // No validation errors
  }

  void _onTogglePasswordVisibility(
      TogglePasswordVisibilityEvent event, Emitter<RegisterState> emit) {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void _onNavigateToLogin(
      NavigateToLoginEvent event, Emitter<RegisterState> emit) {
    Navigator.pushReplacement(
      event.context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => getIt<LoginBloc>(),
          child: const LoginView(),
        ),
      ),
    );
  }

  void navigateToLogin(BuildContext context) {
    add(NavigateToLoginEvent(context: context));
  }

  void _onRegisterUser(RegisterUser event, Emitter<RegisterState> emit) async {
    final validationError = _validateRegistrationForm(
      fullName: event.fullName,
      userName: event.username,
      email: event.email,
      phone: event.phone,
      password: event.password,
    );

    if (validationError != null) {
      emit(state.copyWith(error: validationError));
      ScaffoldMessenger.of(event.context).showSnackBar(
        SnackBar(content: Text(validationError)),
      );
      return;
    }

    try {
      emit(state.copyWith(isLoading: true, error: null));

      final result = await _registerUseCase.call(
        RegisterUserParams(
          fullName: event.fullName,
          userName: event.username,
          email: event.email,
          phoneNumber: event.phone,
          password: event.password,
        ),
      );

      result.fold(
        (failure) {
          emit(state.copyWith(
            isLoading: false,
            isSuccess: false,
            error: failure.message,
          ));
          ScaffoldMessenger.of(event.context).showSnackBar(
            SnackBar(content: Text(failure.message)),
          );
        },
        (success) {
          emit(state.copyWith(
            isLoading: false,
            isSuccess: true,
            error: null,
          ));
          ScaffoldMessenger.of(event.context).showSnackBar(
            const SnackBar(content: Text("Registration successful")),
          );

          Navigator.pushReplacement(
            event.context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => getIt<LoginBloc>(),
                child: const LoginView(),
              ),
            ),
          );
        },
      );
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        isSuccess: false,
        error: 'An unexpected error occurred',
      ));
      ScaffoldMessenger.of(event.context).showSnackBar(
        const SnackBar(content: Text('An unexpected error occurred')),
      );
    }
  }
}

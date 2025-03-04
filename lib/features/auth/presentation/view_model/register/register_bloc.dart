import 'dart:io';

import 'package:ClickEt/app/constants/api_endpoints.dart';
import 'package:ClickEt/app/di/di.dart';
import 'package:ClickEt/app/shared_prefs/token_shared_prefs.dart';
import 'package:ClickEt/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:dio/dio.dart';
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
    on<UploadImageEvent>(_onUploadImage);
  }

  // Validation logic for registration form
  String? _validateRegistrationForm({
    required String fullName,
    required String userName,
    required String email,
    required String phone,
    required String password,
  }) {
    // Validate empty fields
    if (fullName.isEmpty ||
        userName.isEmpty ||
        email.isEmpty ||
        phone.isEmpty ||
        password.isEmpty) {
      return "All fields are required";
    }

    // Validate email format
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      return "Please enter a valid email address";
    }

    // Validate phone number format (assuming 10 digits)
    final phoneRegex = RegExp(r'^\d{10}$');
    if (!phoneRegex.hasMatch(phone)) {
      return "Please enter a valid 10-digit phone number";
    }

    // Validate password requirements (e.g., minimum 8 characters)
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
    // Validate the registration form
    final validationError = _validateRegistrationForm(
      fullName: event.fullName,
      userName: event.username,
      email: event.email,
      phone: event.phone,
      password: event.password,
    );

    if (validationError != null) {
      // Show validation error using SnackBar
      ScaffoldMessenger.of(event.context).showSnackBar(
        SnackBar(content: Text(validationError)),
      );
      return; // Stop further execution if validation fails
    }

    emit(state.copyWith(isLoading: true));

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
        emit(state.copyWith(isLoading: false, isSuccess: false));
        ScaffoldMessenger.of(event.context).showSnackBar(
          SnackBar(content: Text(failure.message)),
        );
      },
      (success) {
        emit(state.copyWith(isLoading: false, isSuccess: true));

        // Show "Registration successful" SnackBar
        ScaffoldMessenger.of(event.context).showSnackBar(
          const SnackBar(content: Text("Registration successful")),
        );

        // Navigate to the login screen
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
  }

  void _onUploadImage(
      UploadImageEvent event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(isLoading: true));

    final dio = Dio();
    final token = await getIt<TokenSharedPrefs>().getToken();
    token.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, error: failure.message));
      },
      (token) {
        final formData = FormData.fromMap({
          'image': MultipartFile.fromFileSync(event.image.path),
        });

        dio
            .post(
          ApiEndpoints.uploadProfile,
          data: formData,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
        )
            .then((response) {
          if (response.statusCode == 200) {
            emit(state.copyWith(isLoading: false, isSuccess: true));
            ScaffoldMessenger.of(event.context).showSnackBar(
              const SnackBar(
                  content: Text("Profile image uploaded successfully")),
            );
          } else {
            emit(state.copyWith(isLoading: false, error: 'Upload failed'));
          }
        }).catchError((error) {
          emit(state.copyWith(isLoading: false, error: 'Upload failed'));
        });
      },
    );
  }
}

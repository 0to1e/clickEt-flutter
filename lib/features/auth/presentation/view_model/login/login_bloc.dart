import 'package:ClickEt/app/di/di.dart';
import 'package:ClickEt/features/auth/presentation/view_model/register/register_bloc.dart';
import 'package:ClickEt/features/home/presentation/view/home_view.dart';
import 'package:ClickEt/features/movie/presentation/view_model/movie_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ClickEt/features/auth/domain/use_case/login_use_case.dart';
import 'package:ClickEt/features/auth/presentation/view/registration_view.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;
  final MovieBloc movieBloc;

  LoginBloc({required this.loginUseCase, required this.movieBloc})
      : super(LoginState.initial()) {
    on<LoginSubmittedEvent>(_onLoginSubmitted);
    on<TogglePasswordVisibilityEvent>(_onTogglePasswordVisibility);
    on<NavigateToRegisterEvent>(_onNavigateToRegister);
  }

  void _onLoginSubmitted(
      LoginSubmittedEvent event, Emitter<LoginState> emit) async {
    // Validate the login form
    final validationError = _validateLoginForm(
      usernameOrEmail: event.username,
      password: event.password,
    );

    if (validationError != null) {
      // Show validation error using SnackBar
      ScaffoldMessenger.of(event.context).showSnackBar(
        SnackBar(content: Text(validationError)),
      );
      return;
    }

    emit(state.copyWith(isLoading: true));

    final result = await loginUseCase(
      LoginParams(
        username: event.username,
        password: event.password,
      ),
    );

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, isSuccess: false));
        ScaffoldMessenger.of(event.context).showSnackBar(
          const SnackBar(content: Text("Invalid Credentials")),
        );
      },
      (response) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        Navigator.pushReplacement(
          event.context,
          MaterialPageRoute(
              builder: (context) => MultiBlocProvider(
                  providers: [BlocProvider.value(value: movieBloc)],
                  child: const HomeView())),
        );
      },
    );
  }

  // Validation logic for login form
  String? _validateLoginForm({
    required String usernameOrEmail,
    required String password,
  }) {
    // Validate empty fields
    if (usernameOrEmail.isEmpty || password.isEmpty) {
      return "Username/Email and password are required";
    }

    // Validate email format if the input contains '@'
    if (usernameOrEmail.contains('@')) {
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(usernameOrEmail)) {
        return "Please enter a valid email address";
      }
    }

    return null; // No validation errors
  }

  void _onTogglePasswordVisibility(
      TogglePasswordVisibilityEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void _onNavigateToRegister(
      NavigateToRegisterEvent event, Emitter<LoginState> emit) {
    Navigator.pushReplacement(
      event.context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => getIt<RegisterBloc>(),
          child: const RegistrationView(),
        ),
      ),
    );
  }

  void navigateToRegister(BuildContext context) {
    add(NavigateToRegisterEvent(context: context));
  }
}

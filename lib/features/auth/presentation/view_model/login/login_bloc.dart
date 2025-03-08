import 'package:ClickEt/core/sensor/shake_cubit.dart';
import 'package:ClickEt/features/auth/domain/use_case/login_use_case.dart';
import 'package:ClickEt/features/movie/presentation/view_model/movie_bloc.dart';
import 'package:ClickEt/network/hive_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;
  final MovieBloc movieBloc;
  final HiveService hiveService;
  final ShakeCubit shakeCubit;

  LoginBloc({
    required this.loginUseCase,
    required this.movieBloc,
    required this.hiveService,
    required this.shakeCubit,
  }) : super(LoginState.initial()) {
    on<LoginSubmittedEvent>(_onLoginSubmitted);
    on<LogOutEvent>(_onLogout);
    on<TogglePasswordVisibilityEvent>(_onTogglePasswordVisibility);
    on<NavigateToRegisterEvent>(_onNavigateToRegister);
  }

  void _onLoginSubmitted(
      LoginSubmittedEvent event, Emitter<LoginState> emit) async {
    // Validate login form
    final validationError = _validateLoginForm(
      usernameOrEmail: event.username,
      password: event.password,
    );

    if (validationError != null) {
      emit(state.copyWith(errorMessage: validationError));
      return;
    }

    emit(state.copyWith(isLoading: true));

    final result = await loginUseCase(
      LoginParams(username: event.username, password: event.password),
    );

    result.fold(
      (failure) {
        emit(state.copyWith(
          isLoading: false,
          isSuccess: false,
          errorMessage: "Invalid Credentials",
        ));
      },
      (response) {
        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          isLoggedIn: true,
          navigateToMain: true,
          errorMessage: "Login SUccessful"
        ));
        shakeCubit.startListening();
      },
    );
  }

  void _onLogout(LogOutEvent event, Emitter<LoginState> emit) async {
    try {
      await hiveService.deleteCurrentUser();
      shakeCubit.stopListening();
      emit(state.copyWith(isLoggedIn: false));
    } catch (e) {
      emit(state.copyWith(isLoggedIn: true));
    }
  }

  void _onTogglePasswordVisibility(
      TogglePasswordVisibilityEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void _onNavigateToRegister(
      NavigateToRegisterEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(navigateToRegister: true)); // Signal navigation
  }

  void navigateToRegister(BuildContext context) {
    add(NavigateToRegisterEvent(context: context));
  }

  String? _validateLoginForm(
      {required String usernameOrEmail, required String password}) {
    if (usernameOrEmail.isEmpty || password.isEmpty) {
      return "Username/Email and password are required";
    }

    if (usernameOrEmail.contains('@')) {
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(usernameOrEmail)) {
        return "Please enter a valid email address";
      }
    }

    return null;
  }
}

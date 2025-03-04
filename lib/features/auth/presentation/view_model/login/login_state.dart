part of 'login_bloc.dart';

class LoginState extends Equatable {
  final bool isLoggedIn;
  final bool isLoading;
  final bool isSuccess;
  final bool isPasswordVisible;

  const LoginState({
    this.isLoggedIn = false,
    this.isLoading = false,
    this.isSuccess = false,
    this.isPasswordVisible = false,
  });

  factory LoginState.initial() => const LoginState();

  LoginState copyWith({
    bool? isLoggedIn,
    bool? isLoading,
    bool? isSuccess,
    bool? isPasswordVisible,
  }) {
    return LoginState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
    );
  }

  @override
  List<Object> get props => [isLoggedIn, isLoading, isSuccess, isPasswordVisible];
}
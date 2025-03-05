part of 'login_bloc.dart';

class LoginState extends Equatable {
  final bool isLoggedIn;
  final bool isLoading;
  final bool isSuccess;
  final bool isPasswordVisible;
  final String? errorMessage; 
  final bool navigateToMain; 
  final bool navigateToRegister;

  const LoginState({
    this.isLoggedIn = false,
    this.isLoading = false,
    this.isSuccess = false,
    this.isPasswordVisible = false,
    this.errorMessage,
    this.navigateToMain = false,
    this.navigateToRegister = false,
  });

  factory LoginState.initial() => const LoginState();

  LoginState copyWith({
    bool? isLoggedIn,
    bool? isLoading,
    bool? isSuccess,
    bool? isPasswordVisible,
    String? errorMessage,
    bool? navigateToMain,
    bool? navigateToRegister,
  }) {
    return LoginState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      errorMessage: errorMessage,
      navigateToMain: navigateToMain ?? this.navigateToMain,
      navigateToRegister: navigateToRegister ?? this.navigateToRegister,
    );
  }

  @override
  List<Object?> get props => [
        isLoggedIn,
        isLoading,
        isSuccess,
        isPasswordVisible,
        errorMessage,
        navigateToMain,
        navigateToRegister,
      ];
}
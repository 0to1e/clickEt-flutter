part of 'register_bloc.dart';

class RegisterState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final bool isPasswordVisible;

  const RegisterState({
    required this.isLoading,
    required this.isSuccess,
    this.isPasswordVisible = false,
  });

  factory RegisterState.initial() => const RegisterState(
        isLoading: false,
        isSuccess: false,
        isPasswordVisible: false,
      );

  RegisterState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isPasswordVisible,
  }) {
    return RegisterState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
    );
  }

  @override
  List<Object> get props => [isLoading, isSuccess, isPasswordVisible];
}
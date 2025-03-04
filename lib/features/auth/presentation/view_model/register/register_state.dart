// File: lib/features/auth/presentation/view_model/register/register_state.dart
part of 'register_bloc.dart';

class RegisterState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final bool isPasswordVisible;
  final File? image;
  final String? error;

  const RegisterState({
    required this.isLoading,
    required this.isSuccess,
    this.isPasswordVisible = false,
    this.image,
    this.error,
  });

  factory RegisterState.initial() => const RegisterState(
        isLoading: false,
        isSuccess: false,
        isPasswordVisible: false,
        image: null,
        error: null,
      );

  RegisterState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isPasswordVisible,
    File? image,
    String? error,
  }) {
    return RegisterState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      image: image ?? this.image,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, isPasswordVisible, image, error];
}
part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterUser extends RegisterEvent {
  final BuildContext context;
  final String fullName;
  final String username;
  final String email;
  final String phone;
  final String password;

  const RegisterUser({
    required this.context,
    required this.fullName,
    required this.username,
    required this.email,
    required this.phone,
    required this.password,
  });

  @override
  List<Object> get props =>
      [context, fullName, username, email, phone, password];
}

class TogglePasswordVisibilityEvent extends RegisterEvent {
  const TogglePasswordVisibilityEvent();

  @override
  List<Object> get props => [];
}

class NavigateToLoginEvent extends RegisterEvent {
  final BuildContext context;

  const NavigateToLoginEvent({required this.context});

  @override
  List<Object> get props => [context];
}

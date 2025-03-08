part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginSubmittedEvent extends LoginEvent {
  final BuildContext context;
  final String username;
  final String password;

  const LoginSubmittedEvent({
    required this.context,
    required this.username,
    required this.password,
  });

  @override
  List<Object> get props => [context, username, password];
}

class TogglePasswordVisibilityEvent extends LoginEvent {
  const TogglePasswordVisibilityEvent();
}

class NavigateToRegisterEvent extends LoginEvent {
  final BuildContext context;

  const NavigateToRegisterEvent({required this.context});

  @override
  List<Object> get props => [context];
}

class LogOutEvent extends LoginEvent {
  const LogOutEvent();
}


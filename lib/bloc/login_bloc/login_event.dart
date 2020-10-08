part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginButtonEvent extends LoginEvent {
  final String email;
  final String password;

  LoginButtonEvent({@required this.email, @required this.password});
}

class LogoutButtonEvent extends LoginEvent {}

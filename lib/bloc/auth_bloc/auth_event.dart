part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AppStarted extends AuthEvent {}

class LoggedIn extends AuthEvent {}

class Logout extends AuthEvent {}

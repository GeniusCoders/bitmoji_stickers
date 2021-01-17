part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginFailed extends LoginState {
  final String error;

  LoginFailed({@required this.error});
}

class LoginSuccess extends LoginState {
  final String avatarID;

  LoginSuccess({@required this.avatarID});
}

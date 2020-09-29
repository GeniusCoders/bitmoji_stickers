part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AppAuth extends AuthState {}

class AppUnAuth extends AuthState {}

class AppLoading extends AuthState {}

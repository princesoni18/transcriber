part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

final class LoginUserEvent extends LoginEvent{

  final String email;
  final String password;

  LoginUserEvent({required this.email, required this.password});
}

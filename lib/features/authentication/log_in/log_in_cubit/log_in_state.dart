part of 'log_in_cubit.dart';

sealed class LogInState {}

final class LogInInitial extends LogInState {}

final class LogInSuccess extends LogInState {}

final class LogInFailure extends LogInState {
  final String errMessage;

  LogInFailure({required this.errMessage});
}

final class LogInLoading extends LogInState {}

part of 'sign_up_cubit.dart';

@immutable
sealed class SignUpState {}

final class SignUpInitial extends SignUpState {}

final class SignUpSuccess extends SignUpState {
  // final UserModel? userModel;

  // SignUpSuccess({this.userModel});
}

final class SignUpFailure extends SignUpState {
  final String errMessage;

  SignUpFailure({required this.errMessage});
}

final class SignUpLoading extends SignUpState {}

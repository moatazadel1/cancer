import 'package:breast_cancer/generated/l10n.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'log_in_state.dart';

class LogInCubit extends Cubit<LogInState> {
  LogInCubit() : super(LogInInitial());
  Future<void> loginUser({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  }) async {
    if (formKey.currentState != null) {
      final isValid = formKey.currentState!.validate();
      FocusScope.of(context).unfocus();
      if (isValid) {
        formKey.currentState!.save();
        emit(LogInLoading());

        try {
          final auth = FirebaseAuth.instance;
          await auth.signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );

          Fluttertoast.showToast(
            msg: S.of(context).LoginSuccessfully,
            toastLength: Toast.LENGTH_SHORT,
            textColor: Colors.white,
          );
          emit(LogInSuccess());
        } on FirebaseAuthException catch (error) {
          if (error.code == 'user-not-found') {
            emit(LogInFailure(
                errMessage: S.of(context).Nouserfoundforthatemail));
          } else if (error.code == 'wrong-password') {
            emit(LogInFailure(
                errMessage: S.of(context).Wrongpasswordprovidedforthatuser));
          } else {
            emit(LogInFailure(errMessage: error.toString()));
          }
        } catch (error) {
          emit(LogInFailure(errMessage: error.toString()));
        }
      }
    }
  }
}

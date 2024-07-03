import 'package:breast_cancer/features/authentication/sign_up/presentation/views/widgets/sign_up_view_body.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatelessWidget {
  final String userType;

  const SignUpView({super.key, required this.userType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignUpViewBody(
        userType: userType,
      ),
    );
  }
}

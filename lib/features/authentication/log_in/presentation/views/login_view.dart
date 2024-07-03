import 'package:breast_cancer/features/authentication/log_in/presentation/views/widgets/login_view_body.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  final String userType;

  const LoginView({super.key, required this.userType});

  @override
  Widget build(BuildContext context) {
    return LoginViewBody(
      userType: userType,
    );
  }
}

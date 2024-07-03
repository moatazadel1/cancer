import 'package:breast_cancer/features/profile/presentation/views/widgets/profile_view_body.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  final String userType;

  const ProfileView({super.key, required this.userType});

  @override
  Widget build(BuildContext context) {
    return  ProfileViewBody(
      userType: userType,
    );
  }
}

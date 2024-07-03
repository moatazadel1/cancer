import 'package:breast_cancer/features/home/presentation/views/widgets/home_view_body.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  final String userType;

  const HomeView({super.key, required this.userType});

  @override
  Widget build(BuildContext context) {
    return HomeViewBody(
      userType: userType,
    );
  }
}

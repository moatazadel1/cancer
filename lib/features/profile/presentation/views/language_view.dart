import 'package:breast_cancer/features/profile/presentation/views/widgets/language_view_body.dart';
import 'package:flutter/material.dart';

class LanguageView extends StatelessWidget {
  const LanguageView({super.key, required this.userType});
  final String userType;

  @override
  Widget build(BuildContext context) {

    return  LanguageViewBody(userType: userType,);
  }
}

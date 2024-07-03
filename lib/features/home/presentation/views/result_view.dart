import 'package:breast_cancer/features/home/presentation/views/widgets/result_view_body.dart';
import 'package:flutter/material.dart';

class ResultView extends StatelessWidget {
  final String userType;

  final String imageUrl;

  const ResultView({super.key, required this.imageUrl, required this.userType});

  @override
  Widget build(BuildContext context) {
    return ResultViewBody(
      imageUrl: imageUrl,
      userType: userType,
    );
  }
}

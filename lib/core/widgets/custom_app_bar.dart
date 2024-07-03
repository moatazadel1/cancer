import 'package:breast_cancer/core/utils/app_assets.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;

    return Column(
      children: [
        const SizedBox(
          height: 22,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                child: Image.asset(
                  AppAssets.undrawImg,
                  fit: BoxFit.contain,
                  height: height * 0.25,
                ),
              ),
              IconButton(
                padding: const EdgeInsets.all(0),
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  color: Colors.black,
                  Icons.arrow_back_ios,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 26,
        ),
      ],
    );
  }
}

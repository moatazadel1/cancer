import 'package:breast_cancer/core/utils/app_assets.dart';
import 'package:breast_cancer/core/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'widgets/custom_join_as_container.dart';

class JoinAsScreen extends StatelessWidget {
  const JoinAsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 20, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.15,
              ),
              Image.asset(AppAssets.undrawImg),
              const SizedBox(
                height: 22,
              ),
              const Text(
                "Join As",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              GestureDetector(
                onTap: () {
                  GoRouter.of(context)
                      .push(AppRoutes.kLoginView, extra: 'patient');
                },
                child: const CustomJoinAsContainer(
                    image: AppAssets.profileBoldImg, textName: 'Patient'),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .04,
              ),
              GestureDetector(
                onTap: () {
                  GoRouter.of(context)
                      .push(AppRoutes.kLoginView, extra: 'doctor');
                },
                child: const CustomJoinAsContainer(
                    image: AppAssets.doctorImg, textName: 'Doctor'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

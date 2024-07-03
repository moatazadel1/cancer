import 'package:breast_cancer/core/utils/app_assets.dart';
import 'package:breast_cancer/core/utils/app_routes.dart';
import 'package:breast_cancer/core/widgets/custom_button.dart';
import 'package:breast_cancer/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnBoardingViewBody extends StatelessWidget {
  const OnBoardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                AppAssets.splashImg,
                height: height * 0.4,
              ),
              const SizedBox(
                height: 56,
              ),
              Text(
                S.of(context).Lets,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Text(
                S.of(context).enjoy,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF625B5B),
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
              const Expanded(
                child: SizedBox(
                  height: 96,
                ),
              ),
              SizedBox(
                width: 61,
                height: 8,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFCECECE),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFCECECE),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 29,
                      height: 8,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFCECECE),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 42,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17),
                child: CustomButton(
                  title: S.of(context).getStarted,
                  onTap: () {
                    // GoRouter.of(context).push(AppRoutes.kLoginView);
                    GoRouter.of(context).push(AppRoutes.kJoinAsView);
                  },
                ),
              ),
              const SizedBox(
                height: 24,
              )
            ],
          ),
        ),
      ),
    );
  }
}

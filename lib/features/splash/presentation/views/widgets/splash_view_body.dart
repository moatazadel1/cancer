import 'package:breast_cancer/core/utils/app_assets.dart';
import 'package:breast_cancer/core/utils/app_routes.dart';
import 'package:breast_cancer/features/splash/presentation/views/widgets/animate_sliding_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashViewBodyWidget extends StatefulWidget {
  const SplashViewBodyWidget({
    super.key,
  });

  @override
  State<SplashViewBodyWidget> createState() => _SplashViewBodyWidgetState();
}

class _SplashViewBodyWidgetState extends State<SplashViewBodyWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAnimation;

  @override
  void initState() {
    super.initState();
    initSlidingAnimation();
    navigateToHomeView();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppAssets.splashImg,
            height: MediaQuery.sizeOf(context).height * 0.3,
          ),
          AnimateSlidingTextWidget(slidingAnimation: slidingAnimation),
        ],
      ),
    );
  }

  void initSlidingAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    slidingAnimation =
        Tween<Offset>(begin: const Offset(0, 2), end: const Offset(0, 0))
            .animate(animationController);
    animationController.forward();
  }

  void navigateToHomeView() {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        GoRouter.of(context).push(AppRoutes.kOnBoardingView);
      },
    );
  }
}

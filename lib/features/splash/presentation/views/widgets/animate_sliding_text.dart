import 'package:breast_cancer/generated/l10n.dart';
import 'package:flutter/material.dart';

class AnimateSlidingTextWidget extends StatelessWidget {
  const AnimateSlidingTextWidget({
    super.key,
    required this.slidingAnimation,
  });

  final Animation<Offset> slidingAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: slidingAnimation,
        builder: (context, _) {
          return SlideTransition(
            position: slidingAnimation,
            child:
                Text(S.of(context).BreastCancer, textAlign: TextAlign.center),
          );
        });
  }
}

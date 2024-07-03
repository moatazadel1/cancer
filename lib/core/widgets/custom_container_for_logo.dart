import 'package:flutter/material.dart';

class CustomContainerForLogo extends StatelessWidget {
  final void Function()? onTap;
  final Widget? child;
  const CustomContainerForLogo({
    super.key,
    this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 52,
          height: 52,
          decoration: const ShapeDecoration(
            color: Color(0xFFEBE9EB),
            shape: OvalBorder(
              side: BorderSide(width: 0.40, color: Color(0xFFF79AEE)),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

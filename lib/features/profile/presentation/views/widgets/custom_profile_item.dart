import 'package:flutter/material.dart';

class CustomProfileItem extends StatelessWidget {
  final String title;
  final Widget? leading;
  final Widget? trailing;
  final void Function()? onTap;
  const CustomProfileItem({
    super.key,
    required this.title,
    required this.leading,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        contentPadding:
            const EdgeInsets.only(left: 16, top: 6, right: 24, bottom: 10),
        minTileHeight: 13,
        trailing: trailing,
        leading: leading,
        title: SizedBox(
          width: 240,
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              height: 0.10,
              letterSpacing: 0.25,
            ),
          ),
        ),
      ),
    );
  }
}

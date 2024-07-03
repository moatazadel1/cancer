import 'package:breast_cancer/features/profile/presentation/views/widgets/custom_switch.dart';
import 'package:flutter/material.dart';

class CustomNotificationTile extends StatefulWidget {
  final String title;

  const CustomNotificationTile({super.key, required this.title});

  @override
  State<CustomNotificationTile> createState() => _CustomNotificationTileState();
}

class _CustomNotificationTileState extends State<CustomNotificationTile> {
  bool _enable = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
          ),
        ),
        CustomSwitch(
          value: _enable,
          onChanged: (bool val) {
            setState(() {
              _enable = val;
            });
          },
        ),
      ],
    );
  }
}

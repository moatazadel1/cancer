import 'package:flutter/material.dart';

class CustomJoinAsContainer extends StatelessWidget {
  final Text textName;

  const CustomJoinAsContainer(
      {super.key, required this.textName});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      width: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Container(

        decoration: ShapeDecoration(

          gradient: const LinearGradient(
            begin: Alignment(0.00, -1.00),
            end: Alignment(0, 1),
            colors: [Color(0xFFFFD3CA), Color(0xFFF36563)],
          ),
          shape: RoundedRectangleBorder(

            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Align(
          alignment: Alignment.center,
          child:textName
        ),
      ),
    );
  }
}

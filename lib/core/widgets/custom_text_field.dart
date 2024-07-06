import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final bool? obscureText;
  final void Function(String)? onFieldSubmitted;
  final String? labelText;
  // final String? hintText;
  final EdgeInsetsGeometry? contentPadding;
  final Color? fillColor;
 final int? maxLines;

  const CustomTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.prefixIcon,
    this.validator,
    this.textInputAction,
    this.obscureText,
    this.suffixIcon,
    this.onFieldSubmitted,
    this.labelText,
    this.contentPadding,
    this.fillColor = Colors.white12, this.maxLines =1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      controller: controller,
      focusNode: focusNode,
      obscureText: obscureText ?? false,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        contentPadding: contentPadding,
        fillColor: fillColor,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF887E7E))),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF887E7E))),

        labelText: labelText,
        labelStyle: const TextStyle(color: Color(0xFF625B5B), fontSize: 17),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,

        // prefixIcon: Icon(
        //   prefixIcon,
        // ),
        suffixIcon: suffixIcon,
      ),
      validator: validator,
      onFieldSubmitted: (value) {
        onFieldSubmitted;
      },
    );
  }
}

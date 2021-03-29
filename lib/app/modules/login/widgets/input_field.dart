import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/constraints/app_colors.dart';

class InputField extends StatelessWidget {
  final double height;
  final double? width;
  final TextEditingController controller;
  final Function(String)? onSubmited;
  final Function(String)? onChanged;
  final bool obscureText;
  final double borderRadius;
  final String hintText;
  final FocusNode? focusNode;
  final Widget? prefixIcon;
  final TextAlignVertical contentAlign;
  final int? minLine;
  final bool expands;
  final int? maxLine;
  InputField(
      {this.height = 50,
      this.width,
      required this.hintText,
      this.borderRadius = 15,
      this.focusNode,
      this.prefixIcon,
      required this.onChanged,
      required this.controller,
      this.onSubmited,
      this.obscureText = false,
      this.contentAlign = TextAlignVertical.center,
      this.minLine,
      this.maxLine,
      this.expands = true
      });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width == null
          ? context.isPhone
              ? (Get.width - 130)
              : Get.width / 2
          : width,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        focusNode: focusNode,
        maxLines: maxLine,
        minLines: minLine,
        expands: expands,
        textAlignVertical: TextAlignVertical.top,
        onSubmitted: (value) => onSubmited!(value),
        onChanged: (value) => onChanged!(value),
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: prefixIcon,
          contentPadding: EdgeInsets.fromLTRB(10, 15, 10, 0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: Colors.transparent)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: Colors.transparent)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: Colors.transparent)),
          filled: true,
          fillColor: AppColors.darkGrey.withOpacity(0.2),
        ),
      ),
    );
  }
}

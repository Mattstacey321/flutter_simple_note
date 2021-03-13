import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/constraints/app_colors.dart';

class InputField extends StatelessWidget {
  final double height;
  final double width;
  final TextEditingController controller;
  final Function(String) onSubmited;
  final bool obscureText;
  InputField(
      {this.height = 50,
      this.width,
      @required this.controller,
      @required this.onSubmited,
      this.obscureText = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width:context.isPhone ? (Get.width -100) : Get.width / 2,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.transparent)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.transparent)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.transparent)),
          filled: true,
          fillColor: AppColors.darkGrey.withOpacity(0.5),
        ),
      ),
    );
  }
}

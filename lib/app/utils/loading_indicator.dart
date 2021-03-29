import 'package:flutter/material.dart';

class LoadingIndicators {
  Widget defaultLoading({double? size = 25}) {
    return SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        strokeWidth: 2,
      ),
    );
  }
}

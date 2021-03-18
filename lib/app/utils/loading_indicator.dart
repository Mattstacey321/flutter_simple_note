import 'package:flutter/material.dart';

class LoadingIndicators {
  Widget defaultLoading() {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      strokeWidth: 2,
    );
  }
}

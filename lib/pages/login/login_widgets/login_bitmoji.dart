import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginBitmoji extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200.w,
        height: 200.w,
        child: Image.asset('assets/bitmoji_sticker.png'));
  }
}

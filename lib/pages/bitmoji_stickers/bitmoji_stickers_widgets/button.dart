import 'package:BitmojiStickers/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Button extends StatelessWidget {
  final Function()? onPress;
  final bool isInstall;
  const Button({required this.onPress, required this.isInstall});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 40.h,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: isInstall ? Color(0xFFcccccc) : primaryColor,
            borderRadius: BorderRadius.circular(10.w)),
        child: Text(
          isInstall ? 'Installed' : 'Add To WhatsApp',
          style: TextStyle(color: white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

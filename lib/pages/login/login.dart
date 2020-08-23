import 'package:BitmojiStickers/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'login_widgets/login_bitmoji.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LoginBitmoji(),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black87, width: .6),
                borderRadius: BorderRadius.circular(10.w)),
            child: Column(
              children: [
                SizedBox(
                  height: 4.h,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      hintText: 'Email',
                      border: InputBorder.none),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Divider(
                  color: Colors.black87,
                ),
                SizedBox(
                  height: 4.h,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      hintText: 'Password',
                      border: InputBorder.none),
                ),
                SizedBox(
                  height: 6.h,
                ),
                Container(
                  padding: EdgeInsets.all(16.w),
                  alignment: Alignment.center,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(10.w))),
                  child: Text(
                    "Log In",
                    style: TextStyle(
                        fontSize: 18.sp,
                        color: white,
                        fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

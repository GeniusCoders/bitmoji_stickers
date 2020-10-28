import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? CircularProgressIndicator()
        : CupertinoActivityIndicator(
            radius: 16.sp,
          );
  }
}

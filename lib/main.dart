import 'package:BitmojiStickers/pages/Dashboard/dashboard_page.dart';
import 'package:BitmojiStickers/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

import 'pages/bitmoji_stickers/bitmoji_stickers_page.dart';
import 'pages/login/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: MaterialColor(0xFF39ca8e, getSwatch(primaryColor)),
          fontFamily: 'SF UI Display',
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Builder(builder: (context) {
          ScreenUtil.init(context,
              width: 360.0, height: 780.0, allowFontScaling: false);

          return BitmojiStickerPage();
        }));
  }
}

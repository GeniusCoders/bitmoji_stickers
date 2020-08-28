import 'package:BitmojiStickers/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'button.dart';

class BitmojiStickerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
      color: white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
              'https://render.bitstrips.com/v2/cpanel/10219680-12430618-b508-4d2e-b2c8-17eaf61217b2-v1.png?transparent=1&palette=1&width=100'),
          SizedBox(
            width: 4.w,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bitmoji Stickers HI',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                      letterSpacing: .6),
                ),
                SizedBox(
                  height: 6.h,
                ),
                Text('bitmoji sticker'),
                SizedBox(
                  height: 16.h,
                ),
                Button(
                  isInstall: false,
                  onPress: () {},
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

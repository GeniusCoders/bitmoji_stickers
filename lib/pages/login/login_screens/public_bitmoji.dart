import 'package:BitmojiStickers/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PublicBitmoji extends StatelessWidget {
  final String _sticker =
      "https://sdk.bitmoji.com/render/panel/10219680-%s-v1.webp?transparent=1&width=512";

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
        ),
        itemCount: _bitmojiAvatarId.length,
        itemBuilder: (context, index) {
          var stickerImg = _sticker.replaceAll('%s', _bitmojiAvatarId[index]);
          return Container(
            decoration: BoxDecoration(
                color: white, borderRadius: BorderRadius.circular(10.w)),
            margin: EdgeInsets.all(10.w),
            child: Padding(
              padding: EdgeInsets.all(4.0.w),
              child: Image.network(
                stickerImg,
                width: 100.w,
                height: 100.w,
              ),
            ),
          );
        });
  }
}

List<String> _bitmojiAvatarId = [
  "12430618-b508-4d2e-b2c8-17eaf61217b2",
  "12430618-b508-4d2e-b2c8-17eaf61217b2",
  "12430618-b508-4d2e-b2c8-17eaf61217b2",
  "12430618-b508-4d2e-b2c8-17eaf61217b2",
  "12430618-b508-4d2e-b2c8-17eaf61217b2",
  "12430618-b508-4d2e-b2c8-17eaf61217b2",
  "12430618-b508-4d2e-b2c8-17eaf61217b2",
  "12430618-b508-4d2e-b2c8-17eaf61217b2",
];

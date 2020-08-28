import 'package:BitmojiStickers/pages/models/stickers_model.dart';
import 'package:BitmojiStickers/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BitmojiStickersPack extends StatelessWidget {
  final List<StickerData> data;
  final String avatar = "12430618-b508-4d2e-b2c8-17eaf61217b2";
  const BitmojiStickersPack({@required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
      ),
      margin: EdgeInsets.only(top: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10.0.w),
            child: Text(
              'Pack Stickers',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w800),
            ),
          ),
          Expanded(
            child: GridView.builder(
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                ),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  var stickerImg = data[index].src.replaceAll('%s', avatar);
                  return Container(
                    decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(10.w)),
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
                }),
          ),
        ],
      ),
    );
  }
}

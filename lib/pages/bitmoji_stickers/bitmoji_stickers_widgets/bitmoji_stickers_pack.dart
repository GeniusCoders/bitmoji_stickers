import 'package:BitmojiStickers/models/dynamic_data/bitmoji_id.dart';
import 'package:BitmojiStickers/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../injection.dart';

class BitmojiStickersPack extends StatefulWidget {
  final List<dynamic> data;

  const BitmojiStickersPack({@required this.data});

  @override
  _BitmojiStickersPackState createState() => _BitmojiStickersPackState();
}

class _BitmojiStickersPackState extends State<BitmojiStickersPack> {
  String avatar;

  @override
  void initState() {
    super.initState();
    avatar = getIt<BitmojiIdData>().bitmojiIdValue;
    print("__________");
    print(widget.data.length);
    print("__________");
  }

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
                itemCount: widget.data.length,
                itemBuilder: (context, index) {
                  var stickerImg = widget.data[index].replaceAll('%s', avatar);
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

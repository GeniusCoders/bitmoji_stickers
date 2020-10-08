import 'package:BitmojiStickers/models/dynamic_data/bitmoji_id.dart';
import 'package:BitmojiStickers/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../injection.dart';
import 'button.dart';

class BitmojiStickerHeader extends StatefulWidget {
  final onPress;
  final String stickerId;
  final String stickerName;
  const BitmojiStickerHeader({
    @required this.onPress,
    @required this.stickerId,
    @required this.stickerName,
  });

  @override
  _BitmojiStickerHeaderState createState() => _BitmojiStickerHeaderState();
}

class _BitmojiStickerHeaderState extends State<BitmojiStickerHeader> {
  String avatar = '12430618-b508-4d2e-b2c8-17eaf61217b2';

  @override
  void initState() {
    super.initState();
    avatar = getIt<BitmojiIdData>().bitmojiIdValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
      color: white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
              'https://render.bitstrips.com/v2/cpanel/${widget.stickerId}-$avatar-v1.png?transparent=1&palette=1&width=100'),
          SizedBox(
            width: 4.w,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bitmoji Stickers ${widget.stickerName}',
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
                Button(isInstall: false, onPress: widget.onPress)
              ],
            ),
          )
        ],
      ),
    );
  }
}

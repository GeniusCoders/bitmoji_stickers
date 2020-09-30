import 'package:BitmojiStickers/bloc/sticker_bloc/sticker_bloc_bloc.dart';
import 'package:BitmojiStickers/models/dynamic_data/bitmoji_id.dart';
import 'package:BitmojiStickers/pages/loading/loading.dart';
import 'package:BitmojiStickers/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../injection.dart';

class BitmojiCatCard extends StatelessWidget {
  final String urlid;
  final String title;
  final Color backgroundColor;
  const BitmojiCatCard(
      {this.urlid, this.title, @required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: 140.w,
        height: 140.w,
        margin: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(10.w),
            boxShadow: [
              BoxShadow(
                  blurRadius: 4,
                  offset: Offset(0, 0),
                  color: Color.fromRGBO(0, 0, 0, 0.1),
                  spreadRadius: 0)
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StreamBuilder<String>(
                stream: getIt<BitmojiIdData>().bitmojiId$,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    String _id = snapshot.data;
                    return Image.network(
                        'https://render.bitstrips.com/v2/cpanel/$urlid-$_id-v1.png?transparent=1&palette=1&width=100');
                  }
                  return Container(
                    height: 100.h,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }),
            Container(
              width: 140.w,
              alignment: Alignment.center,
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(10.w))),
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 16.sp,
                    color: white,
                    fontWeight: FontWeight.w600,
                    letterSpacing: .4),
              ),
            )
          ],
        ),
      ),
    );
  }
}

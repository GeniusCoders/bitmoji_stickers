import 'package:BitmojiStickers/bloc/sticker_bloc/sticker_bloc_bloc.dart';
import 'package:BitmojiStickers/pages/bitmoji_stickers/bitmoji_stickers.dart';
import 'package:BitmojiStickers/services/api/stickers_api.dart';
import 'package:BitmojiStickers/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BitmojiStickerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hi',
          style: TextStyle(color: white),
        ),
        backgroundColor: blue,
      ),
      body: BlocProvider<StickerBloc>(
        create: (context) => StickerBloc(stickersRepo: StickersApi()),
        child: BitmojiStickers(),
      ),
    );
  }
}

import 'package:BitmojiStickers/bloc/sticker_bloc/sticker_bloc_bloc.dart';
import 'package:BitmojiStickers/pages/models/stickers_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bitmoji_stickers_widgets/bitmoji_sticker_header.dart';
import 'bitmoji_stickers_widgets/bitmoji_stickers_pack.dart';

class BitmojiStickers extends StatefulWidget {
  @override
  _BitmojiStickersState createState() => _BitmojiStickersState();
}

class _BitmojiStickersState extends State<BitmojiStickers> {
  List<StickerData> _stickerData;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<StickerBloc>(context).add(GetStickers());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StickerBloc, StickerBlocState>(
      listener: (context, state) {
        if (state is StickersState) {
          _stickerData = state.stickerResponse.data;
        }
      },
      builder: (context, state) {
        return Container(
          child: Column(
            children: [
              BitmojiStickerHeader(),
              _stickerData == null
                  ? Container(
                      child: CircularProgressIndicator(),
                    )
                  : Expanded(
                      child: BitmojiStickersPack(
                      data: _stickerData,
                    ))
            ],
          ),
        );
      },
    );
  }
}

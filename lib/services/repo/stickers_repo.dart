import 'package:BitmojiStickers/models/stickers_model/stickers_model.dart';
import 'package:flutter/material.dart';

abstract class StickersRepo {
  Future<StickerResponse> loadSticker({String stickerPathName});
  Future<String> getBitmojiId();
  Future<bool> dowloadStickers(
      {@required StickerResponse stickerData,
      @required String identfier,
      @required String avatar});
}

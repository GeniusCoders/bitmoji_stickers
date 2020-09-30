import 'package:BitmojiStickers/models/stickers_model/stickers_model.dart';

abstract class StickersRepo {
  Future<StickerResponse> loadGoodNightSticker();
  Future<String> getBitmojiId();
}

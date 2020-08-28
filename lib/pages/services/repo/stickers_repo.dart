import 'package:BitmojiStickers/pages/models/stickers_model.dart';

abstract class StickersRepo {
  Future<StickerResponse> loadGoodNightSticker();
}

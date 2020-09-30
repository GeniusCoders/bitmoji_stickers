import 'package:BitmojiStickers/models/stickers_model/stickers_model.dart';

abstract class StickersRepo {
  Future<StickerResponse> loadSticker({String stickerPathName});
  Future<String> getBitmojiId();
}

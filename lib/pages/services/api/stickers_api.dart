import 'dart:convert';

import 'package:BitmojiStickers/pages/models/stickers_model.dart';
import 'package:BitmojiStickers/pages/services/repo/stickers_repo.dart';
import 'package:flutter/services.dart';

class StickersApi {
  // @override
  Future<StickerResponse> loadGoodNightSticker() async {
    final file =
        await rootBundle.loadString('data/good_night_stickers_data.json');
    final jsonResponse = json.decode(file);

    return StickerResponse.fromJson(jsonResponse);
  }
}

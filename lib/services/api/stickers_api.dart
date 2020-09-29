import 'dart:convert';

import 'package:BitmojiStickers/models/stickers_model.dart';
import 'package:BitmojiStickers/services/repo/stickers_repo.dart';
import 'package:BitmojiStickers/services/repo/user_repo.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
@RegisterAs(StickersRepo)
class StickersApi extends StickersRepo {
  @override
  Future<StickerResponse> loadGoodNightSticker() async {
    final file =
        await rootBundle.loadString('data/good_night_stickers_data.json');
    final jsonResponse = json.decode(file);

    return StickerResponse.fromJson(jsonResponse);
  }
}

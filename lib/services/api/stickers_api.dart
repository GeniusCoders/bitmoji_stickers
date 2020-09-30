import 'dart:convert';

import 'package:BitmojiStickers/models/stickers_model/stickers_model.dart';
import 'package:BitmojiStickers/services/repo/stickers_repo.dart';
import 'package:BitmojiStickers/services/repo/user_repo.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
@RegisterAs(StickersRepo)
class StickersApi extends StickersRepo {
  final Future<SharedPreferences> _prefs;

  StickersApi(this._prefs);
  @override
  Future<StickerResponse> loadSticker({String stickerPathName}) async {
    final file = await rootBundle.loadString('data/$stickerPathName.json');
    final jsonResponse = json.decode(file);

    return StickerResponse.fromJson(jsonResponse);
  }

  @override
  Future<String> getBitmojiId() async {
    SharedPreferences prefs = await _prefs;
    final data = prefs.getString('data');
    return jsonDecode(data);
  }
}

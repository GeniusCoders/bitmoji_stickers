import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:BitmojiStickers/services/repo/stickers_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:BitmojiStickers/models/stickers_model/stickers_model.dart';
import 'package:BitmojiStickers/services/repo/user_repo.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
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
    String data = prefs.getString('data');
    print(data);
    return jsonDecode(data);
  }

  @override
  Future<bool> dowloadStickers(
      {@required StickerResponse stickerData,
      @required String identfier,
      @required String avatar}) async {
    final _applicationDirectory = await getApplicationDocumentsDirectory();
    final _stickerPacksDirectory =
        Directory("${_applicationDirectory.path}/sticker_packs");
    final _stickerPacksConfigFile =
        File("${_stickerPacksDirectory.path}/sticker_packs.json");
    final _stickerPacksConfig =
        jsonDecode((await _stickerPacksConfigFile.readAsString()));
    List<dynamic> _storedStickerPacks = _stickerPacksConfig['sticker_packs'];

    Directory packageDirectory =
        Directory("${_stickerPacksDirectory.path}/$identfier")
          ..create(recursive: true);
    print(stickerData.data);
    var decodeimg;
    var _input;

    for (int i = 0; i < 1; i++) {
      var stickerImg = stickerData.data[i].replaceAll('%s', avatar);
      final response = await get(stickerImg);

      final result = File("${packageDirectory.path}/${identfier}_$i.webp")
        ..createSync(recursive: true)
        ..writeAsBytesSync(response.bodyBytes);

      var webdecoder = img.WebPDecoder();
      final redBytes = result.readAsBytesSync();
      print("________");
      print(redBytes);
      print("________");
      final anim = webdecoder.decodeAnimation(redBytes);
      final encodeAnimation = img.Animation();
      for (var i = 0; i < anim.numFrames; ++i) {
        var image = anim.frames[i];
        encodeAnimation.addFrame(image);
      }
      File("${packageDirectory.path}/${identfier}_${i + 6}.webp")
        ..createSync(recursive: true)
        ..writeAsBytesSync(img.WebPEncoder().encodeAnimation(encodeAnimation));
      print("________");
    }

    File packageContentsFile = File("${packageDirectory.path}/config.json");

    String configFileContent = jsonEncode(stickerData.config) + "\n";
    packageContentsFile.writeAsStringSync(configFileContent, flush: true);

    Map<String, dynamic> packageContentsMap =
        jsonDecode(await packageContentsFile.readAsString());

    _storedStickerPacks.removeWhere(
        (item) => item['identifier'] == packageContentsMap['identifier']);
    _storedStickerPacks.add(packageContentsMap);

    _stickerPacksConfig['sticker_packs'] = _storedStickerPacks;

    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String contentsOfFile = encoder.convert(_stickerPacksConfig) + "\n";
    _stickerPacksConfigFile.deleteSync();
    _stickerPacksConfigFile.createSync(recursive: true);
    _stickerPacksConfigFile.writeAsStringSync(contentsOfFile, flush: true);

    return true;
  }
}

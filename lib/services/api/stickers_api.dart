import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:BitmojiStickers/models/stickers_model/stickers_model.dart';
import 'package:BitmojiStickers/services/repo/stickers_repo.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart';
import 'package:image/image.dart' as img;
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable(as: StickersRepo)
class StickersApi extends StickersRepo {
  final Future<SharedPreferences> _prefs;

  StickersApi(this._prefs);
  @override
  Future<StickerResponse> loadSticker({required String stickerPathName}) async {
    final file = await rootBundle.loadString('data/$stickerPathName.json');
    final jsonResponse = json.decode(file);
    return StickerResponse.fromJson(jsonResponse);
  }

  @override
  Future<String> getBitmojiId() async {
    final SharedPreferences prefs = await _prefs;
    prefs.reload();
    final data = prefs.getString('data');

    return Future(() => data ?? "");
  }

  @override
  Future<bool> dowloadStickers(
      {required StickerResponse stickerData,
      required String identfier,
      required String avatar}) async {
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

    File _trayIconFile = File("${packageDirectory.path}/tray-icon.png");

    if (!await _trayIconFile.exists()) {
      final stickerImg = stickerData.trayImg!.replaceAll('%s', avatar);
      final response = await get(Uri.parse(stickerImg));

      _trayIconFile
        ..createSync(recursive: true)
        ..writeAsBytesSync(response.bodyBytes);
    }

    for (int i = 0; i < stickerData.data!.length; i++) {
      File _stickerFile = File("${packageDirectory.path}/${identfier}_$i.webp");

      var stickerImg = stickerData.data![i].replaceAll('%s', avatar);
      final response = await get(stickerImg);

      final codec = await instantiateImageCodec(response.bodyBytes);
      final frame = await codec.getNextFrame();
      final uiImage = frame.image;
      _stickerFile
        ..createSync(recursive: true)
        ..writeAsBytesSync(response.bodyBytes);

      if (uiImage.width > 512 ||
          uiImage.height > 512 ||
          uiImage.width < 512 ||
          uiImage.height < 512) {
        final img.Image imageTemp = img.decodeWebPFile(response.bodyBytes);
        final img.Image resizeImg =
            img.copyResize(imageTemp, width: 512, height: 512);

        File("${packageDirectory.path}/${identfier}_$i.png")
          ..createSync(recursive: true)
          ..writeAsBytesSync(img.encodePng(resizeImg));

        FlutterImageCompress.compressAndGetFile(
            "${packageDirectory.path}/${identfier}_$i.png",
            "${packageDirectory.path}/${identfier}_$i.webp",
            format: CompressFormat.webp,
            minWidth: 512,
            minHeight: 512,
            quality: 90);
      }
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

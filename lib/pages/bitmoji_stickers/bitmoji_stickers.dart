import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:BitmojiStickers/bloc/sticker_bloc/sticker_bloc_bloc.dart';
import 'package:BitmojiStickers/pages/models/stickers_model.dart';
import 'package:BitmojiStickers/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_whatsapp_stickers/flutter_whatsapp_stickers.dart';
import 'package:http/http.dart' show get;
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;
import 'bitmoji_stickers_widgets/bitmoji_sticker_header.dart';
import 'bitmoji_stickers_widgets/bitmoji_stickers_pack.dart';

class BitmojiStickers extends StatefulWidget {
  @override
  _BitmojiStickersState createState() => _BitmojiStickersState();
}

class _BitmojiStickersState extends State<BitmojiStickers> {
  StickerResponse _stickerData;
  final WhatsAppStickers _waStickers = WhatsAppStickers();
  final String avatar = "12430618-b508-4d2e-b2c8-17eaf61217b2";

  Directory _applicationDirectory;
  Directory _stickerPacksDirectory;
  File _stickerPacksConfigFile;
  Map<String, dynamic> _stickerPacksConfig;
  List<dynamic> _storedStickerPacks;

  final String _stickerPackIdentifier = "goodnight";

  @override
  void initState() {
    super.initState();
    BlocProvider.of<StickerBloc>(context).add(GetStickers());
    prepareFolderStructure();
  }

  void prepareFolderStructure() async {
    _applicationDirectory = await getApplicationDocumentsDirectory();
    _stickerPacksDirectory =
        Directory("${_applicationDirectory.path}/sticker_packs");
    _stickerPacksConfigFile =
        File("${_stickerPacksDirectory.path}/sticker_packs.json");
    if (!await _stickerPacksConfigFile.exists()) {
      _stickerPacksConfigFile.createSync(recursive: true);
      _stickerPacksConfig = {
        "android_play_store_link": "",
        "ios_app_store_link": "",
        "sticker_packs": [],
      };
      String contentsOfFile = jsonEncode(_stickerPacksConfig) + "\n";
      _stickerPacksConfigFile.writeAsStringSync(contentsOfFile, flush: true);
    }

    _stickerPacksConfig =
        jsonDecode((await _stickerPacksConfigFile.readAsString()));
    _storedStickerPacks = _stickerPacksConfig['sticker_packs'];
  }

  void downloadAndStore(String identifier) async {
    print("I am Start______");
    Directory packageDirectory =
        Directory("${_stickerPacksDirectory.path}/$identifier")
          ..create(recursive: true);
    print("packageDirectory______$packageDirectory");

    for (int i = 0; i < _stickerData.data.length; i++) {
      var stickerImg = _stickerData.data[i].src.replaceAll('%s', avatar);
      final response = await get(stickerImg);

      print("_____$i = ${response.body} ____");
      if (i == 0) {
        File("${packageDirectory.path}/tray-icon.png")
          ..createSync(recursive: true)
          ..writeAsBytesSync(response.bodyBytes);
        print("i am here__________PNG");
        print("${packageDirectory.path}");
      } else {
        final codec = await instantiateImageCodec(response.bodyBytes);
        final frame = await codec.getNextFrame();
        final uiImage = frame.image;
        final result = File("${packageDirectory.path}/goodnight_${i - 1}.png")
          ..createSync(recursive: true)
          ..writeAsBytesSync(response.bodyBytes);
        if (uiImage.width > 512 || uiImage.height > 512) {
          img.Image image_temp = img.decodeImage(result.readAsBytesSync());
          img.Image resize_img =
              img.copyResize(image_temp, width: 512, height: 512);

          File("${packageDirectory.path}/goodnight_${i - 1}.png")
            ..createSync(recursive: true)
            ..writeAsBytesSync(img.encodePng(resize_img));
          print("_____________");
        }
        await FlutterImageCompress.compressAndGetFile(
            "${packageDirectory.path}/goodnight_${i - 1}.png",
            "${packageDirectory.path}/goodnight_${i - 1}.webp",
            format: CompressFormat.webp,
            minWidth: 512,
            minHeight: 512,
            quality: 90);
      }
    }

    File packageContentsFile = File("${packageDirectory.path}/config.json");

    String configFileContent = jsonEncode(_stickerData.config) + "\n";
    packageContentsFile.writeAsStringSync(configFileContent, flush: true);

    print("packageContentsFile : _____$packageContentsFile");
    Map<String, dynamic> packageContentsMap =
        jsonDecode(await packageContentsFile.readAsString());
    print("packageContentsMap : _____$packageContentsMap");

    /// Add to global config
    _storedStickerPacks.removeWhere(
        (item) => item['identifier'] == packageContentsMap['identifier']);
    _storedStickerPacks.add(packageContentsMap);

    /// Update config file
    _stickerPacksConfig['sticker_packs'] = _storedStickerPacks;
    print("_storedStickerPacks : _____$_storedStickerPacks");

    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String contentsOfFile = encoder.convert(_stickerPacksConfig) + "\n";
    _stickerPacksConfigFile.deleteSync();
    _stickerPacksConfigFile.createSync(recursive: true);
    _stickerPacksConfigFile.writeAsStringSync(contentsOfFile, flush: true);

    _waStickers.updatedStickerPacks(identifier);
    print("_____________________IA MA HERRR");
    _waStickers.addStickerPack(
      packageName: WhatsAppPackage.Consumer,
      stickerPackIdentifier: identifier,
      stickerPackName: 'GoodNight',
      listener: (action, result, {error}) => processResponse(
        action: action,
        result: result,
        error: error,
        successCallback: () {
          print("HELLO______________________");
        },
        context: context,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StickerBloc, StickerBlocState>(
      listener: (context, state) {
        if (state is StickersState) {
          _stickerData = state.stickerResponse;
        }
      },
      builder: (context, state) {
        return Container(
          child: Column(
            children: [
              BitmojiStickerHeader(
                onPress: () => downloadAndStore(_stickerPackIdentifier),
              ),
              _stickerData == null
                  ? Container(
                      child: CircularProgressIndicator(),
                    )
                  : Expanded(
                      child: BitmojiStickersPack(
                      data: _stickerData.data,
                    ))
            ],
          ),
        );
      },
    );
  }
}

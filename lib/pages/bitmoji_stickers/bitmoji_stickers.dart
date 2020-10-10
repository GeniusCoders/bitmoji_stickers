import 'dart:convert';
import 'dart:io';
import 'package:BitmojiStickers/bloc/sticker_bloc/sticker_bloc_bloc.dart';
import 'package:BitmojiStickers/models/dynamic_data/bitmoji_id.dart';
import 'package:BitmojiStickers/models/stickers_model/stickers_model.dart';
import 'package:BitmojiStickers/pages/loading/loading.dart';
import 'package:BitmojiStickers/util/ads/ads_data/ads_data.dart';
import 'package:BitmojiStickers/util/ads/baner_adview.dart';
import 'package:BitmojiStickers/util/utils.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_whatsapp_stickers/flutter_whatsapp_stickers.dart';
import 'package:path_provider/path_provider.dart';
import 'bitmoji_stickers_widgets/bitmoji_sticker_header.dart';
import 'bitmoji_stickers_widgets/bitmoji_stickers_pack.dart';
import '../../injection.dart';

class BitmojiStickers extends StatefulWidget {
  final String stickerPathName;
  final String stickerId;
  final String stickerName;
  const BitmojiStickers(
      {@required this.stickerPathName,
      @required this.stickerId,
      @required this.stickerName});

  @override
  _BitmojiStickersState createState() => _BitmojiStickersState();
}

class _BitmojiStickersState extends State<BitmojiStickers> {
  StickerResponse _stickerData;
  final WhatsAppStickers _waStickers = WhatsAppStickers();

  Directory _applicationDirectory;
  Directory _stickerPacksDirectory;
  File _stickerPacksConfigFile;
  Map<String, dynamic> _stickerPacksConfig;
  BannerAd _bannerAd;
  String _stickerPackIdentifier;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<StickerBloc>(context)
        .add(GetStickers(strickerPath: widget.stickerPathName));
    FirebaseAdMob.instance.initialize(appId: BannerAdView.adUnitId);
    _bannerAd = BannerAdView.createBannerAd(getIt<AdsData>().bannerAd3)
      ..load()
      ..show();
    prepareFolderStructure();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _bannerAd.dispose();
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
  }

  void downloadAndStore(String identifier) async {
    BlocProvider.of<StickerBloc>(context).add(DownloadAndStore(
        stickerData: _stickerData,
        identifier: _stickerPackIdentifier,
        avatar: getIt<BitmojiIdData>().bitmojiIdValue));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StickerBloc, StickerState>(
      listener: (context, state) {
        if (state is StickersState) {
          _stickerData = state.stickerResponse;
          _stickerPackIdentifier = state.stickerResponse.identifier;
        }
        if (state is DownloadSucces) {
          // _waStickers.updatedStickerPacks(_stickerPackIdentifier);
          // print("_____________________IA MA HERRR");
          // _waStickers.addStickerPack(
          //   packageName: WhatsAppPackage.Consumer,
          //   stickerPackIdentifier: _stickerPackIdentifier,
          //   stickerPackName: 'Bitmoji $_stickerPackIdentifier',
          //   listener: (action, result, {error}) => processResponse(
          //     action: action,
          //     result: result,
          //     error: error,
          //     successCallback: () {
          //       print("HELLO______________________");
          //     },
          //     context: context,
          //   ),
          // );
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Container(
              child: Column(
                children: [
                  BitmojiStickerHeader(
                    onPress: () => downloadAndStore(_stickerPackIdentifier),
                    stickerId: widget.stickerId,
                    stickerName: widget.stickerName,
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
            ),
            Container(
              child: state is LoadingState ? Loading() : Container(),
            )
          ],
        );
      },
    );
  }
}

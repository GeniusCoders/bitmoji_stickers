import 'dart:async';

import 'package:BitmojiStickers/models/stickers_model/stickers_model.dart';
import 'package:BitmojiStickers/services/repo/stickers_repo.dart';
import 'package:BitmojiStickers/util/utils.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_whatsapp_stickers/flutter_whatsapp_stickers.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'sticker_bloc_event.dart';
part 'sticker_bloc_state.dart';

@injectable
class StickerBloc extends Bloc<StickerBlocEvent, StickerState> {
  final StickersRepo stickersRepo;

  StickerBloc({@required this.stickersRepo}) : super(StickerBlocInitial());

  @override
  Stream<StickerState> mapEventToState(
    StickerBlocEvent event,
  ) async* {
    if (event is GetStickers) {
      yield LoadingState();
      try {
        final data =
            await stickersRepo.loadSticker(stickerPathName: event.strickerPath);
        yield StickersState(stickerResponse: data);
      } catch (e) {
        print(e);
        print("_____________");
        yield FailedState(error: e.toString());
      }
    }
    if (event is DownloadAndStore) {
      yield LoadingState();
      final data = await stickersRepo.dowloadStickers();
      if (data) {
        yield DownloadSucces();
      }
    }

    if (event is GetBitmojiId) {
      yield LoadingState();
      final id = await stickersRepo.getBitmojiId();
      yield BitmojiId(id: id);
    }
  }
}

import 'dart:async';

import 'package:BitmojiStickers/models/stickers_model.dart';
import 'package:BitmojiStickers/services/api/stickers_api.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'sticker_bloc_event.dart';
part 'sticker_bloc_state.dart';

@injectable
class StickerBloc extends Bloc<StickerBlocEvent, StickerBlocState> {
  final StickersApi stickersRepo;

  StickerBloc({@required this.stickersRepo}) : super(StickerBlocInitial());

  @override
  Stream<StickerBlocState> mapEventToState(
    StickerBlocEvent event,
  ) async* {
    if (event is GetStickers) {
      yield LoadingState();
      try {
        final data = await stickersRepo.loadGoodNightSticker();
        yield StickersState(stickerResponse: data);
      } catch (e) {
        print("______________");
        print(e.toString());
        print("______________");
        yield FailedState(error: e.toString());
      }
    }
    if (event is DownloadAndStore) {
      yield LoadingState();

      try {} catch (e) {}
    }
  }
}

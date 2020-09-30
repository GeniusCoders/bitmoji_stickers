part of 'sticker_bloc_bloc.dart';

@immutable
abstract class StickerBlocEvent {}

class GetStickers extends StickerBlocEvent {
  final String strickerPath;

  GetStickers({this.strickerPath});
}

class DownloadAndStore extends StickerBlocEvent {
  final String identifier;
  final StickerResponse stickerData;
  final String avatar;

  DownloadAndStore(
      {@required this.identifier,
      @required this.stickerData,
      @required this.avatar});
}

class GetBitmojiId extends StickerBlocEvent {}

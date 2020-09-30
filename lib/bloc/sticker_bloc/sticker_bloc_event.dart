part of 'sticker_bloc_bloc.dart';

@immutable
abstract class StickerBlocEvent {}

class GetStickers extends StickerBlocEvent {
  final String strickerPath;

  GetStickers({this.strickerPath});
}

class GetBitmojiId extends StickerBlocEvent {}

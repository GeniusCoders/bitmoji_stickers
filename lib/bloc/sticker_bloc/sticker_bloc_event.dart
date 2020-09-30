part of 'sticker_bloc_bloc.dart';

@immutable
abstract class StickerBlocEvent {}

class GetStickers extends StickerBlocEvent {}

class GetBitmojiId extends StickerBlocEvent {}

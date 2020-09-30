part of 'sticker_bloc_bloc.dart';

@immutable
abstract class StickerState {}

class StickerBlocInitial extends StickerState {}

class LoadingState extends StickerState {}

class FailedState extends StickerState {
  final String error;

  FailedState({@required this.error});
}

class StickersState extends StickerState {
  final StickerResponse stickerResponse;

  StickersState({@required this.stickerResponse});
}

class DownloadAndStore extends StickerState {}

class BitmojiId extends StickerState {
  final String id;

  BitmojiId({@required this.id});
}

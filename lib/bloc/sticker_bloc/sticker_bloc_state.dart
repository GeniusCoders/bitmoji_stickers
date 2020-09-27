part of 'sticker_bloc_bloc.dart';

@immutable
abstract class StickerBlocState {}

class StickerBlocInitial extends StickerBlocState {}

class LoadingState extends StickerBlocState {}

class FailedState extends StickerBlocState {
  final String error;

  FailedState({@required this.error});
}

class StickersState extends StickerBlocState {
  final StickerResponse stickerResponse;

  StickersState({@required this.stickerResponse});
}

class DownloadAndStore extends StickerBlocState {}

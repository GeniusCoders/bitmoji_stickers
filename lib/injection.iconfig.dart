// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:shared_preferences/shared_preferences.dart';
import 'package:BitmojiStickers/services/core/register_module.dart';
import 'package:BitmojiStickers/bloc/sticker_bloc/sticker_bloc_bloc.dart';
import 'package:BitmojiStickers/services/api/stickers_api.dart';
import 'package:BitmojiStickers/services/repo/stickers_repo.dart';
import 'package:BitmojiStickers/services/api/user_api.dart';
import 'package:BitmojiStickers/services/repo/user_repo.dart';
import 'package:BitmojiStickers/bloc/auth_bloc/auth_bloc.dart';
import 'package:BitmojiStickers/bloc/login_bloc/login_bloc.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  final registerModule = _$RegisterModule();
  g.registerLazySingletonAsync<SharedPreferences>(() => registerModule.prefs);
  g.registerFactory<StickerBloc>(
      () => StickerBloc(stickersRepo: g<StickersApi>()));
  g.registerLazySingleton<StickersRepo>(() => StickersApi());
  g.registerLazySingleton<UserRepo>(
      () => UserApi(g.getAsync<SharedPreferences>()));
  g.registerFactory<AuthBloc>(() => AuthBloc(userRepo: g<UserRepo>()));
  g.registerFactory<LoginBloc>(() => LoginBloc(userRepo: g<UserRepo>()));
}

class _$RegisterModule extends RegisterModule {}

import 'package:BitmojiStickers/models/dynamic_data/bitmoji_id.dart';
import 'package:BitmojiStickers/util/ads/ads_data/ads_data.dart';
import 'package:dio/dio.dart';
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

void $initGetIt(GetIt g, {String? environment}) {
  final registerModule = _$RegisterModule();
  g.registerLazySingleton<BitmojiIdData>(() => BitmojiIdData());
  g.registerLazySingleton<AdsData>(() => AdsData());
  g.registerLazySingletonAsync<SharedPreferences>(() => registerModule.prefs);
  g.registerLazySingleton<Dio>(() => registerModule.dio);
  g.registerFactory<StickerBloc>(
      () => StickerBloc(stickersRepo: g<StickersRepo>()));
  g.registerLazySingleton<StickersRepo>(
      () => StickersApi(g.getAsync<SharedPreferences>()));
  g.registerLazySingleton<UserRepo>(
      () => UserApi(g.getAsync<SharedPreferences>(), g<Dio>()));
  g.registerFactory<AuthBloc>(() => AuthBloc(userRepo: g<UserRepo>()));
  g.registerFactory<LoginBloc>(() => LoginBloc(userRepo: g<UserRepo>()));
}

class _$RegisterModule extends RegisterModule {}

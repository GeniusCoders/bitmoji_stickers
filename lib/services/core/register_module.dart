import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@registerModule
abstract class RegisterModule {
  @lazySingleton
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}

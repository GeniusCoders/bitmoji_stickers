import 'dart:convert';

import 'package:BitmojiStickers/services/repo/user_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
@RegisterAs(UserRepo)
class UserApi extends UserRepo {
  final Future<SharedPreferences> _prefs;

  UserApi(this._prefs);

  @override
  Future<bool> isSignin() async {
    final SharedPreferences prefs = await _prefs;
    bool exist = prefs.containsKey('data');
    return exist;
  }

  @override
  void signOut() async {
    final SharedPreferences prefs = await _prefs;
    prefs.clear();
  }

  @override
  void signIn(String email, String password) async {
    SharedPreferences prefs = await _prefs;
    prefs.setString('data', jsonEncode('12430618-b508-4d2e-b2c8-17eaf61217b2'));
  }

  @override
  Future<String> getId() async {
    SharedPreferences prefs = await _prefs;
    final data = prefs.getString('data');
    return jsonDecode(data);
  }
}

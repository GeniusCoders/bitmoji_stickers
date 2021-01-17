import 'package:BitmojiStickers/services/core/base_model.dart';
import 'package:BitmojiStickers/services/repo/user_repo.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
@RegisterAs(UserRepo)
class UserApi extends UserRepo {
  final Future<SharedPreferences> _prefs;
  final Dio dio;
  UserApi(this._prefs, this.dio);

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
  Future<BaseModel<String>> signIn(String email, String password) async {
    var avatarJson;
    try {
      final loginUrl = "https://api.bitmoji.com/user/login";
      final avatartUrl = "https://api.bitmoji.com/user/avatar";
      final logoutUrl = "https://api.bitmoji.com/user/logout";

      final _userData = {
        "client_id": "imoji",
        "username": email,
        "password": password,
        "grant_type": "password",
        "client_secret": "secret"
      };
      var parts = [];
      _userData.forEach((key, value) {
        parts.add('${Uri.encodeQueryComponent(key)}='
            '${Uri.encodeQueryComponent(value)}');
      });

      var formData = parts.join('&');

      final headers = {
        "Accept": "application/json",
        "Accept-Encoding": "gzip, deflate, br",
        "Accept-Language": "en-US,en;q=0.9",
        "Connection": "keep-alive",
        "Content-Type": "application/x-www-form-urlencoded",
        "Host": "api.bitmoji.com",
        "Origin": "https://www.bitmoji.com",
        "Referer": "https://www.bitmoji.com/account_v2/"
      };

      Response loginRes = await dio.post(loginUrl,
          data: formData, options: Options(headers: headers));
      final loginJson = loginRes.data;
      String _acesstoken = loginJson['access_token'];

      if (loginRes.statusCode == 200) {
        final avatarHeaders = {
          "Accept-Encoding": "gzip, deflate, br",
          "Accept-Language": "en-US,en;q=0.9",
          "bitmoji-token": _acesstoken,
          "Connection": "keep-alive",
          "Content-Type": "application/x-www-form-urlencoded",
          "Host": "api.bitmoji.com",
          "Origin": "https://www.bitmoji.com",
          "Referer": "https://www.bitmoji.com/account_v2/"
        };

        Response avatarRes = await dio.get(avatartUrl,
            options: Options(
              headers: avatarHeaders,
            ));

        avatarJson = avatarRes.data;

        final SharedPreferences prefs = await _prefs;
        prefs.setString('data', avatarJson['avatar_version_uuid']);

        await dio.post(logoutUrl,
            options: Options(
              headers: avatarHeaders,
            ));
      }
    } catch (e) {
      return BaseModel()..setException(ServerError.withError(error: e));
    }
    return BaseModel()..data = avatarJson['avatar_version_uuid'];
  }
}

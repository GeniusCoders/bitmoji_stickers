import 'dart:convert';
import 'package:BitmojiStickers/services/repo/user_repo.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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

    Response loginRes = await http.Client().post(
      loginUrl,
      body: formData,
      headers: headers,
    );
    final loginJson = jsonDecode(loginRes.body);
    String _acesstoken = loginJson['access_token'];
    print(_acesstoken);
    print(loginJson);
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

    Response avatarRes = await http.Client().get(
      avatartUrl,
      headers: avatarHeaders,
    );

    final avatarJson = jsonDecode(avatarRes.body);

    print(avatarJson);

    SharedPreferences prefs = await _prefs;
    prefs.setString('data', jsonEncode(avatarJson['avatar_version_uuid']));

    Response logoutRes = await http.Client().post(
      logoutUrl,
      headers: avatarHeaders,
    );

    final logoutJson = jsonDecode(logoutRes.body);
    print(logoutJson);
    print("__________");
  }
}

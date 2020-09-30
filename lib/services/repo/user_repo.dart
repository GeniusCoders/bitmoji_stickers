import 'package:BitmojiStickers/models/stickers_model/stickers_model.dart';

abstract class UserRepo {
  Future<bool> isSignin();
  void signOut();
  void signIn(String email, String password);
}

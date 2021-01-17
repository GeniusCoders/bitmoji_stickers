import 'package:BitmojiStickers/services/core/base_model.dart';

abstract class UserRepo {
  Future<bool> isSignin();
  void signOut();
  Future<BaseModel<String>> signIn(String email, String password);
}

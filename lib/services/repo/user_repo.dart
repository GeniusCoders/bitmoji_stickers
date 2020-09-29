abstract class UserRepo {
  Future<bool> isSignin();
  void signOut();
  void signIn(String email, String password);
  Future<String> getId();
}

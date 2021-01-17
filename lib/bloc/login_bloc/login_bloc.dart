import 'dart:async';

import 'package:BitmojiStickers/services/core/base_model.dart';
import 'package:BitmojiStickers/services/repo/user_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepo userRepo;
  LoginBloc({@required this.userRepo}) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginButtonEvent) {
      yield LoginLoading();
      BaseModel response = await userRepo.signIn(event.email, event.password);
      ServerError error = response.getException;
      if (error != null) {
        yield LoginFailed(error: error.getErrorMessage());
      } else {
        yield LoginSuccess(avatarID: response.data);
      }
    }
  }
}

import 'dart:async';

import 'package:BitmojiStickers/services/repo/user_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepo userRepo;
  AuthBloc({@required this.userRepo}) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AppStarted) {
      final hasToken = await userRepo.isSignin();

      try {
        if (hasToken) {
          yield AppLoading();
          yield AppAuth();
        } else {
          yield AppUnAuth();
        }
      } catch (_) {
        yield AppUnAuth();
      }
    }

    if (event is LoggedIn) {
      yield AppAuth();
    }

    if (event is Logout) {
      yield AppUnAuth();
      userRepo.signOut();
    }
  }
}

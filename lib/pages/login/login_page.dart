import 'package:BitmojiStickers/bloc/login_bloc/login_bloc.dart';
import 'package:BitmojiStickers/injection.dart';
import 'package:BitmojiStickers/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "LOGIN",
          style: TextStyle(color: white, letterSpacing: .6),
        ),
      ),
      body: BlocProvider(
        create: (context) => getIt<LoginBloc>(),
        child: Login(),
      ),
    );
  }
}

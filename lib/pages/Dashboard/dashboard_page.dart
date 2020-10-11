import 'package:BitmojiStickers/bloc/auth_bloc/auth_bloc.dart';
import 'package:BitmojiStickers/bloc/login_bloc/login_bloc.dart';
import 'package:BitmojiStickers/bloc/sticker_bloc/sticker_bloc_bloc.dart';
import 'package:BitmojiStickers/pages/Dashboard/dashboard.dart';
import 'package:BitmojiStickers/services/repo/stickers_repo.dart';
import 'package:BitmojiStickers/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../injection.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  _onLogout() {
    BlocProvider.of<AuthBloc>(context).add(Logout());
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dashboard",
          style: TextStyle(color: white),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: white,
              ),
              onPressed: _onLogout)
        ],
      ),
      body: MultiBlocProvider(providers: [
        BlocProvider<StickerBloc>(create: (context) => getIt<StickerBloc>()),
        BlocProvider<AuthBloc>(create: (context) => getIt<AuthBloc>()),
      ], child: Dashboard()),
    );
  }
}

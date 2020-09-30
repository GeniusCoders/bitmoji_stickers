import 'package:BitmojiStickers/bloc/sticker_bloc/sticker_bloc_bloc.dart';
import 'package:BitmojiStickers/pages/Dashboard/dashboard.dart';
import 'package:BitmojiStickers/services/repo/stickers_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../injection.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      body: BlocProvider(
        create: (context) => getIt<StickerBloc>(),
        child: Dashboard(),
      ),
    );
  }
}

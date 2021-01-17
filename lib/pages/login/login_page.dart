import 'package:BitmojiStickers/bloc/login_bloc/login_bloc.dart';
import 'package:BitmojiStickers/injection.dart';
import 'package:BitmojiStickers/styles/colors.dart';
import 'package:BitmojiStickers/widgets/admob_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../util/ads/ads_data/ads_data.dart';
import 'login.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bitmoji Login",
          style: TextStyle(color: white, letterSpacing: .6),
        ),
      ),
      bottomNavigationBar: AdmobWidget(
        admobUnit: getIt<AdsData>().bannerAd1,
      ),
      body: BlocProvider(
        create: (context) => getIt<LoginBloc>(),
        child: Login(),
      ),
    );
  }
}

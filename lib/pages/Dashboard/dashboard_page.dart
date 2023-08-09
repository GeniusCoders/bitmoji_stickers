import 'package:BitmojiStickers/bloc/auth_bloc/auth_bloc.dart';
import 'package:BitmojiStickers/bloc/sticker_bloc/sticker_bloc_bloc.dart';
import 'package:BitmojiStickers/models/dynamic_data/bitmoji_id.dart';
import 'package:BitmojiStickers/pages/Dashboard/dashboard.dart';
import 'package:BitmojiStickers/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../../injection.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // final FirebaseAnalytics _firebaseAnalytics = FirebaseAnalytics();

  _onLogout() {
    BlocProvider.of<AuthBloc>(context).add(Logout());
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }

  _onShare() async {
    final _bitmojiID = getIt<BitmojiIdData>().bitmojiIdValue;
    final bytes = await http.get(
      Uri.parse(
          'https://sdk.bitmoji.com/render/panel/10219680-$_bitmojiID-v1.webp?transparent=1&width='),
    );
    var pngBytes = bytes.bodyBytes;
    // await Share.file(
    //     'Bitmoji Sticker', 'bitmojiSticker.png', pngBytes, 'image/png',
    //     text: "Download Bitmoji Sticker App");
    // await _firebaseAnalytics.logShare(
    //     contentType: 'Image', itemId: _bitmojiID, method: '');
  }

  _onDonate() {
    launch('https://www.buymeacoffee.com/geniuscoders');
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
                Icons.share,
                color: white,
              ),
              onPressed: _onShare),
          IconButton(
              icon: FaIcon(
                FontAwesomeIcons.donate,
                color: Colors.white,
                size: 20,
              ),
              onPressed: _onDonate),
          IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: white,
              ),
              onPressed: _onLogout),
        ],
      ),
      body: MultiBlocProvider(providers: [
        BlocProvider<StickerBloc>(create: (context) => getIt<StickerBloc>()),
        BlocProvider<AuthBloc>(create: (context) => getIt<AuthBloc>()),
      ], child: Dashboard()),
    );
  }
}

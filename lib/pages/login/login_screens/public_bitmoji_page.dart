import 'package:BitmojiStickers/pages/login/login_screens/public_bitmoji.dart';
import 'package:flutter/material.dart';

class PublicBitmpjiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Bitmoji'),
      ),
      body: PublicBitmoji(),
    );
  }
}

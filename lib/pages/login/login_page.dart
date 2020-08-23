import 'package:BitmojiStickers/styles/colors.dart';
import 'package:flutter/material.dart';

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
      body: Login(),
    );
  }
}

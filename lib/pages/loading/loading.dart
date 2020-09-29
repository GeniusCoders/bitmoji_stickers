import 'package:BitmojiStickers/styles/colors.dart';
import 'package:BitmojiStickers/widgets/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints.expand(height: MediaQuery.of(context).size.height),
      color: black.withOpacity(.3),
      child: Center(child: Loader()),
    );
  }
}

class LoadingFull extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints:
            BoxConstraints.expand(height: MediaQuery.of(context).size.height),
        child: Center(child: Loader()),
      ),
    );
  }
}

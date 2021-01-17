import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';

class AdmobWidget extends StatefulWidget {
  final String admobUnit;

  const AdmobWidget({@required this.admobUnit});

  @override
  _AdmobWidgetState createState() => _AdmobWidgetState();
}

class _AdmobWidgetState extends State<AdmobWidget> {
  bool showAd = true;

  @override
  Widget build(BuildContext context) {
    return AdmobBanner(
        adUnitId: widget.admobUnit,
        listener: (AdmobAdEvent event, map) {
          if (event == AdmobAdEvent.failedToLoad) {
            setState(() {
              showAd = false;
            });
          }
        },
        adSize: AdmobBannerSize.FULL_BANNER);
  }
}

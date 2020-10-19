import 'package:injectable/injectable.dart';

@lazySingleton
class AdsData {
  final String bannerId1 = 'ca-app-pub-3940256099942544/6300978111';
  final String bannerId2 = 'ca-app-pub-3940256099942544/6300978111';
  final String bannerId3 = 'ca-app-pub-3940256099942544/6300978111';
  final String interstitialId1 = "ca-app-pub-3940256099942544/1033173712";
  final String interstitialId2 = "ca-app-pub-3940256099942544/1033173712";
  final String interstitialId3 = "ca-app-pub-3940256099942544/1033173712";

  String get bannerAd1 => bannerId1;
  String get bannerAd2 => bannerId2;
  String get bannerAd3 => bannerId3;

  String get interstitialAd1 => interstitialId1;
  String get interstitialAd2 => interstitialId2;
  String get interstitialAd3 => interstitialId3;
}

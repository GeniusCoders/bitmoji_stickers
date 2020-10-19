import 'package:injectable/injectable.dart';

@lazySingleton
class AdsData {
  final String bannerId1 = 'ca-app-pub-3808851724738740/4616897707';
  final String bannerId2 = 'ca-app-pub-3808851724738740/5771209037';
  final String bannerId3 = 'ca-app-pub-3808851724738740/8205800683';
  final String interstitialId1 = "ca-app-pub-3808851724738740/8205800683";

  String get bannerAd1 => bannerId1;
  String get bannerAd2 => bannerId2;
  String get bannerAd3 => bannerId3;

  String get interstitialAd1 => interstitialId1;
}

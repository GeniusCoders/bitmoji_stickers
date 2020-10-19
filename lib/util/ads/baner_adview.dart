import 'package:firebase_admob/firebase_admob.dart';

class BannerAdView {
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>[
      'Games',
      'valorant',
      'csgo',
      'pc games',
      'fps games',
      'pubg',
      'mobile games'
    ],
    childDirected: true, // or MobileAdGender.female, MobileAdGender.unknown
    testDevices: <String>[], // Android emulators are considered test devices
  );

  static String adUnitId = "ca-app-pub-3808851724738740~4287345787";

  static BannerAd createBannerAd(String adUnitId) {
    return BannerAd(
        adUnitId: adUnitId,
        size: AdSize.banner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {});
  }

  static InterstitialAd createInterstitialAd(String adUnitId) {
    return InterstitialAd(
      adUnitId: adUnitId,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {},
    );
  }
}

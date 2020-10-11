class StickerResponse {
  List<dynamic> data;
  Map<String, dynamic> config;
  String identifier;
  StickerResponse({this.data});
  String trayImg;

  StickerResponse.fromJson(dynamic json) {
    identifier = json['identifier'];
    trayImg = json['tray_icon'];
    data = json['data'];
    config = json['config'];
  }
}

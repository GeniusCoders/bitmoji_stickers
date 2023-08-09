class StickerResponse {
  List<dynamic>? data;
  Map<String, dynamic>? config;
  String? identifier;
  String? trayImg;
  StickerResponse(this.config, this.identifier, this.trayImg, this.data);

  StickerResponse.fromJson(dynamic json) {
    identifier = json['identifier'];
    trayImg = json['tray_icon'];
    data = json['data'];
    config = json['config'];
  }
}

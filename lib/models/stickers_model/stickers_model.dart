class StickerResponse {
  List<StickerData> data;
  Map<String, dynamic> config;
  String identifier;
  StickerResponse({this.data});

  StickerResponse.fromJson(dynamic json) {
    identifier = json['identifier'];
    if (json['data'] != null) {
      data = List<StickerData>();
      json['data'].forEach((v) {
        data.add(StickerData.fromJson(v));
      });
    }
    config = json['config'];
  }
}

class StickerData {
  String templateId;
  String comicId;
  String src;
  List<dynamic> supertags;
  List<dynamic> tags;
  List<dynamic> categories;
  String schedulableId;

  StickerData(
      {this.templateId,
      this.comicId,
      this.src,
      this.supertags,
      this.tags,
      this.categories,
      this.schedulableId});

  StickerData.fromJson(dynamic json) {
    templateId = '6666';
    comicId = json['comic_id'];
    src = json['src'];
    supertags = json['supertags'];
    tags = json['tags'];
    categories = json['categories'];
    schedulableId = json['schedulable_id'];
  }
}

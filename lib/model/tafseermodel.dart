class TafsirModel {
  int? id;
  int? suraId;
  int? tafsirId;
  String? url;
  String? name;

  TafsirModel({this.id, this.suraId, this.tafsirId, this.url, this.name});

  TafsirModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    suraId = json['sura_id'];
    tafsirId = json['tafsir_id'];
    url = json['url'];
    name = json['name'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['sura_id'] = this.suraId;
  //   data['tafsir_id'] = this.tafsirId;
  //   data['url'] = this.url;
  //   data['name'] = this.name;
  //   return data;
  // }
}

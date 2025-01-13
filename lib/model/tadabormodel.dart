class TadaborSubDataModel {
  int? id;
  String? videoUrl;
  String? imageUrl;
  String? text;
  String? soraName;
  String? rewayaName;
  String? reciterName;
  String? title;
  String? shareDescription;
  String? shareTitle;
  String? shareUrl;

  TadaborSubDataModel(
      {id,
      videoUrl,
      imageUrl,
      text,
      soraName,
      rewayaName,
      reciterName,
      title,
      shareDescription,
      shareTitle,
      shareUrl});

  TadaborSubDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    videoUrl = json['video_url'];
    imageUrl = json['image_url'];
    text = json['text'];
    soraName = json['sora_name'];
    rewayaName = json['rewaya_name'];
    reciterName = json['reciter_name'];
    title = json['title'];
    shareDescription = json['share_description'];
    shareTitle = json['share_title'];
    shareUrl = json['share_url'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data =  <String, dynamic>{};
  //   data['id'] = id;
  //   data['video_url'] = videoUrl;
  //   data['image_url'] = imageUrl;
  //   data['text'] = text;
  //   data['sora_name'] = soraName;
  //   data['rewaya_name'] = rewayaName;
  //   data['reciter_name'] = reciterName;
  //   data['title'] = title;
  //   data['share_description'] = shareDescription;
  //   data['share_title'] = shareTitle;
  //   data['share_url'] = shareUrl;
  //   return data;
  // }
}

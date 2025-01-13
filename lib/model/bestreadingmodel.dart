class BestReadingModel {
  int? id;
  String? reciterName;
  List<BestReadingModelVideos>? videos;

  BestReadingModel({id, reciterName, videos});

  BestReadingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reciterName = json['reciter_name'];
    if (json['videos'] != null) {
      videos = <BestReadingModelVideos>[];
      json['videos'].forEach((v) {
        videos!.add( BestReadingModelVideos.fromJson(v));
      });
    }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data =  <String, dynamic>{};
  //   data['id'] = id;
  //   data['reciter_name'] = reciterName;
  //   if (videos != null) {
  //     data['videos'] = videos!.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}

class BestReadingModelVideos {
  int? id;
  int? videoType;
  String? videoUrl;
  String? videoThumbUrl;

  BestReadingModelVideos({id, videoType, videoUrl, videoThumbUrl});

  BestReadingModelVideos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    videoType = json['video_type'];
    videoUrl = json['video_url'];
    videoThumbUrl = json['video_thumb_url'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data =  <String, dynamic>{};
  //   data['id'] = id;
  //   data['video_type'] = videoType;
  //   data['video_url'] = videoUrl;
  //   data['video_thumb_url'] = videoThumbUrl;
  //   return data;
  // }
}
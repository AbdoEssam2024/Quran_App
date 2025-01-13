class VariousReadingModel {
  List<Reads>? reads;

  VariousReadingModel({this.reads});

  VariousReadingModel.fromJson(Map<String, dynamic> json) {
    if (json['reads'] != null) {
      reads = <Reads>[];
      json['reads'].forEach((v) {
        reads!.add(new Reads.fromJson(v));
      });
    }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   if (this.reads != null) {
  //     data['reads'] = this.reads!.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}

class Reads {
  int? id;
  String? name;
  String? letter;
  String? recentDate;
  List<Moshaf>? moshaf;

  Reads({this.id, this.name, this.letter, this.recentDate, this.moshaf});

  Reads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    letter = json['letter'];
    recentDate = json['recent_date'];
    if (json['moshaf'] != null) {
      moshaf = <Moshaf>[];
      json['moshaf'].forEach((v) {
        moshaf!.add(new Moshaf.fromJson(v));
      });
    }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['name'] = this.name;
  //   data['letter'] = this.letter;
  //   data['recent_date'] = this.recentDate;
  //   if (this.moshaf != null) {
  //     data['moshaf'] = this.moshaf!.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}

class Moshaf {
  int? id;
  String? name;
  String? server;
  int? surahTotal;
  int? moshafType;
  String? surahList;

  Moshaf(
      {this.id,
      this.name,
      this.server,
      this.surahTotal,
      this.moshafType,
      this.surahList});

  Moshaf.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    server = json['server'];
    surahTotal = json['surah_total'];
    moshafType = json['moshaf_type'];
    surahList = json['surah_list'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['name'] = this.name;
  //   data['server'] = this.server;
  //   data['surah_total'] = this.surahTotal;
  //   data['moshaf_type'] = this.moshafType;
  //   data['surah_list'] = this.surahList;
  //   return data;
  // }
}

class QareaSuwar {
  int? id;
  String? name;
  int? start;
  int? end;
  int? makkia;

  QareaSuwar({this.id, this.name, this.start, this.end, this.makkia});

  QareaSuwar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    start = json['start'];
    end = json['end'];
    makkia = json['makkia'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['name'] = this.name;
  //   data['start'] = this.start;
  //   data['end'] = this.end;
  //   data['makkia'] = this.makkia;
  //   return data;
  // }
}

class SuwarNameModel {
  int? id;
  String? name;
  int? startPage;
  int? endPage;
  int? makkia;
  int? type;

  SuwarNameModel(
      {this.id,
      this.name,
      this.startPage,
      this.endPage,
      this.makkia,
      this.type});

  SuwarNameModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    startPage = json['start_page'];
    endPage = json['end_page'];
    makkia = json['makkia'];
    type = json['type'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['name'] = this.name;
  //   data['start_page'] = this.startPage;
  //   data['end_page'] = this.endPage;
  //   data['makkia'] = this.makkia;
  //   data['type'] = this.type;
  //   return data;
  // }
}

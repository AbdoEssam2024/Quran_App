class MawaqeetSalah {
  String? fajr;
  String? sunrise;
  String? dhuhr;
  String? asr;
  String? sunset;
  String? maghrib;
  String? isha;
  String? imsak;
  String? midnight;
  String? firstthird;
  String? lastthird;

  MawaqeetSalah(
      {fajr,
      sunrise,
      dhuhr,
      asr,
      sunset,
      maghrib,
      isha,
      imsak,
      midnight,
      firstthird,
      lastthird});

  MawaqeetSalah.fromJson(Map<String, dynamic> json) {
    fajr = json['Fajr'];
    sunrise = json['Sunrise'];
    dhuhr = json['Dhuhr'];
    asr = json['Asr'];
    sunset = json['Sunset'];
    maghrib = json['Maghrib'];
    isha = json['Isha'];
    imsak = json['Imsak'];
    midnight = json['Midnight'];
    firstthird = json['Firstthird'];
    lastthird = json['Lastthird'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data =  <String, dynamic>{};
  //   data['Fajr'] = fajr;
  //   data['Sunrise'] = sunrise;
  //   data['Dhuhr'] = dhuhr;
  //   data['Asr'] = asr;
  //   data['Sunset'] = sunset;
  //   data['Maghrib'] = maghrib;
  //   data['Isha'] = isha;
  //   data['Imsak'] = imsak;
  //   data['Midnight'] = midnight;
  //   data['Firstthird'] = firstthird;
  //   data['Lastthird'] = lastthird;
  //   return data;
  // }
}

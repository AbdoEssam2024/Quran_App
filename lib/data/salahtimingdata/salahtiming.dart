import 'package:quran/core/constant/apilinks/apilinks.dart';
import 'package:quran/data/crud.dart';

class SalahTiming {
  Crud crud;

  SalahTiming(this.crud);

  getData() async {
    var response = await crud.postData(AppApiLinks.salahTiming, {});
    return response.fold((l) => l, (r) => r);
  }
}

import 'package:quran/core/constant/apilinks/apilinks.dart';
import 'package:quran/data/crud.dart';

class SuwarName {
  Crud crud;

  SuwarName(this.crud);

  getData() async {
    var response = await crud.postData(AppApiLinks.surahNameAndPageNumber, {});
    return response.fold((l) => l, (r) => r);
  }
}

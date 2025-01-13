import 'package:quran/core/constant/apilinks/apilinks.dart';
import 'package:quran/data/crud.dart';

class Tafsir {
  Crud crud;

  Tafsir(this.crud);

  getData() async {
    var response = await crud.postData(AppApiLinks.eltabryExplainAudio, {});
    return response.fold((l) => l, (r) => r);
  }
}

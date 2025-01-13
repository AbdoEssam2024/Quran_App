import 'package:quran/core/constant/apilinks/apilinks.dart';
import 'package:quran/data/crud.dart';

class Tadabor {
  Crud crud;

  Tadabor(this.crud);

  getData() async {
    var response = await crud.postData(AppApiLinks.ponderingTheQuranVideo, {});
    return response.fold((l) => l, (r) => r);
  }
}

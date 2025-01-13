import 'package:quran/core/constant/apilinks/apilinks.dart';
import 'package:quran/data/crud.dart';

class BestReadingData {
  Crud crud;

  BestReadingData(this.crud);

  getData() async {
    var response = await crud.postData(AppApiLinks.theBestReadingVideo, {});
    return response.fold((l) => l, (r) => r);
  }
}

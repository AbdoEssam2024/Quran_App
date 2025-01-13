import 'package:quran/core/constant/apilinks/apilinks.dart';
import 'package:quran/data/crud.dart';

class TestData {
  Crud crud;

  TestData(this.crud);

  getData() async {
    var response = await crud.postData(AppApiLinks.moshafFullAudio, {});
    return response.fold((l) => l, (r) => r);
  }
}

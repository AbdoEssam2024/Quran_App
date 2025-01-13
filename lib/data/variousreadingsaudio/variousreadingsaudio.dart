import 'package:quran/core/constant/apilinks/apilinks.dart';
import 'package:quran/data/crud.dart';

class VariousReading {
  Crud crud;

  VariousReading(this.crud);

  getData() async {
    var response = await crud.postData(AppApiLinks.variousReadingsAudio, {});
    return response.fold((l) => l, (r) => r);
  }
}

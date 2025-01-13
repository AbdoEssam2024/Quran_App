import 'package:get/get.dart';
import 'package:quran/data/crud.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(Crud());
  }
}

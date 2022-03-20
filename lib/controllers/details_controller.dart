import 'package:get/get.dart';
import 'package:movie_app/models/cast.dart';
import 'package:movie_app/network/api.dart';


class DetailsController extends GetxController {
  RxList<Cast> castList = <Cast>[].obs;

  loadCast(int movieID) {
    API().getCast(movieID).then((value) {
      castList.value = value;
    });
  }
}

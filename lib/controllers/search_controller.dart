import 'package:get/get.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/network/api.dart';

class SearchController extends GetxController {
  RxList<Movie> searchResult = <Movie>[].obs;

  searchMovie(String name) {
    API().getSearch(name).then((value) {
      searchResult.value = value;
    });
  }
}

import 'package:get/get.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/network/api.dart';

class HomeController extends GetxController {
  RxList<Movie> popularMovies = <Movie>[].obs;
  RxList<Movie> nowPlayingMovies = <Movie>[].obs;
  RxList<Movie> searchResult = <Movie>[].obs;

  loadPopular() {
    API().getPopular().then((value) {
      popularMovies.value = value;
    });
  }

  loadNowPlaying() {
    API().getNowPlaying().then((value) {
      nowPlayingMovies.value = value;
    });
  }

  searchMovie(String name) {
    API().getSearch(name).then((value) {
      searchResult.value = value;
    });
  }
}

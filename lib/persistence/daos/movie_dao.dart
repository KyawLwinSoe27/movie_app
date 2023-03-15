import 'package:hive/hive.dart';
import 'package:movie_app/persistence/hive_constants.dart';

import '../../data/vos/movie_vo.dart';

class MovieDao {

  static final MovieDao _singleton = MovieDao._internal();

  factory MovieDao() {
    return _singleton;
  }

  MovieDao._internal();

  void saveAllMovies(List<MovieVO> movieList) async {
    Map<int,MovieVO> movieMap = Map.fromIterable(movieList, key: (movie) => movie.id, value: (movie) => movie);
    return await getMovieBox().putAll(movieMap);
  }

  void saveSingleMovie(MovieVO movie) async {
    return await getMovieBox().put(movie.id, movie);
  }

  List<MovieVO> getAllMovies() {
    return getMovieBox().values.toList();
  }

  MovieVO? getMovieById(int movieId) {
    return getMovieBox().get(movieId);
  }

  Box<MovieVO> getMovieBox() {
    return Hive.box<MovieVO>(BOX_NAME_MOVIE_VO);
  }
}
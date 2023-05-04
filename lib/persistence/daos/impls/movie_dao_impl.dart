import 'package:hive/hive.dart';
import 'package:movie_app/persistence/daos/movie_dao.dart';
import 'package:movie_app/persistence/hive_constants.dart';

import '../../../data/vos/movie_vo.dart';


class MovieDaoImpl extends MovieDao{

  static final MovieDaoImpl _singleton = MovieDaoImpl._internal();

  factory MovieDaoImpl() {
    return _singleton;
  }

  MovieDaoImpl._internal();

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

  /// Reactive Programming
  Stream<void> getAllMoviesEventStream() { //Data Change Event
    return getMovieBox().watch(); //function changes invoke လုပ်ရင် သူ့ကို listen လုပ်နေတယ့် callback ထဲကိုရောက်
  }

  Stream<List<MovieVO>> getNowPlayingMoviesStream() {
    return Stream.value(getAllMovies()
        .where((element) => element.isNowPlaying ?? false).toList()
    );
  }

  Stream<List<MovieVO>> getTopRatedMoviesStream() {
    return Stream.value(getAllMovies()
        .where((element) => element.isTopRated ?? false).toList()
    );
  }

  Stream<List<MovieVO>> getPopularMoviesStream() {
    return Stream.value(getAllMovies()
        .where((element) => element.isPopular ?? false).toList()
    );
  }

  List<MovieVO> getNowPlayingMovies() {
    if((getAllMovies().isNotEmpty)){
      return getAllMovies()
          .where((element) => element.isNowPlaying ?? false)
          .toList();
    }else {
      return [];
    }
  }

  List<MovieVO> getPopularMovies() {
    if(getAllMovies() != null && (getAllMovies().isNotEmpty ?? false)){
      return getAllMovies()
          .where((element) => element.isPopular ?? false)
          .toList();
    }else{
      return [];
    }
  }

  List<MovieVO> getTopRatedMovies() {
    if(getAllMovies() != null && (getAllMovies().isNotEmpty ?? false)){
      return getAllMovies()
          .where((element) => element.isTopRated ?? false)
          .toList();
    }else {
      return [];
    }
  }

  Box<MovieVO> getMovieBox() {
    return Hive.box<MovieVO>(BOX_NAME_MOVIE_VO);
  }
}
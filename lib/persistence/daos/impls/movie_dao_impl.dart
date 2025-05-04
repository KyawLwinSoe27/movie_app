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

  @override
  void saveAllMovies(List<MovieVO> movieList) async {
    Map<int,MovieVO> movieMap = { for (var movie in movieList) movie.id ?? 0 : movie };
    return await getMovieBox().putAll(movieMap);
  }

  @override
  void saveSingleMovie(MovieVO movie) async {
    return await getMovieBox().put(movie.id, movie);
  }

  @override
  List<MovieVO> getAllMovies() {
    return getMovieBox().values.toList();
  }

  @override
  MovieVO? getMovieById(int movieId) {
    return getMovieBox().get(movieId);
  }

  /// Reactive Programming
  @override
  Stream<void> getAllMoviesEventStream() { //Data Change Event
    return getMovieBox().watch(); //function changes invoke လုပ်ရင် သူ့ကို listen လုပ်နေတယ့် callback ထဲကိုရောက်
  }

  @override
  Stream<List<MovieVO>> getNowPlayingMoviesStream() {
    return Stream.value(getAllMovies()
        .where((element) => element.isNowPlaying ?? false).toList()
    );
  }

  @override
  Stream<List<MovieVO>> getTopRatedMoviesStream() {
    return Stream.value(getAllMovies()
        .where((element) => element.isTopRated ?? false).toList()
    );
  }

  @override
  Stream<List<MovieVO>> getPopularMoviesStream() {
    return Stream.value(getAllMovies()
        .where((element) => element.isPopular ?? false).toList()
    );
  }

  @override
  List<MovieVO> getNowPlayingMovies() {
    if((getAllMovies().isNotEmpty)){
      return getAllMovies()
          .where((element) => element.isNowPlaying ?? false)
          .toList();
    }else {
      return [];
    }
  }

  @override
  List<MovieVO> getPopularMovies() {
    if((getAllMovies().isNotEmpty ?? false)){
      return getAllMovies()
          .where((element) => element.isPopular ?? false)
          .toList();
    }else{
      return [];
    }
  }

  @override
  List<MovieVO> getTopRatedMovies() {
    if((getAllMovies().isNotEmpty ?? false)){
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
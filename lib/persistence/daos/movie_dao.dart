import '../../data/vos/movie_vo.dart';

abstract class MovieDao {
  void saveAllMovies(List<MovieVO> movieList);
  void saveSingleMovie(MovieVO movie);
  List<MovieVO> getAllMovies();
  MovieVO? getMovieById(int movieId);
  Stream<void> getAllMoviesEventStream();
  Stream<List<MovieVO>> getNowPlayingMoviesStream();
  Stream<List<MovieVO>> getTopRatedMoviesStream();
  Stream<List<MovieVO>> getPopularMoviesStream();
  List<MovieVO> getNowPlayingMovies();
  List<MovieVO> getPopularMovies();
  List<MovieVO> getTopRatedMovies();

}
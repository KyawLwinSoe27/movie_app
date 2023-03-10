import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';

import '../../network/dataagents/movie_data_agent.dart';
import '../../network/dataagents/retrofit_movie_data_agent_impl.dart';

class MovieModelImpl extends MovieModel {


  static final MovieModelImpl _singleton = MovieModelImpl._internal();

  factory MovieModelImpl() {
    return _singleton;
  }

  MovieModelImpl._internal(); //ရေးစရာဘာမှမရှိ

  final MovieDataAgent _dataAgent = RetrofitMovieDataAgentImpl();

  @override
  Future<List<MovieVO>?> getNowPlayingMovies() {
    return _dataAgent.getNowPlayingMovies(1);
  }

  @override
  Future<List<ActorVO>?> getActors(int page) {
    // TODO: implement getActors
    return _dataAgent.getActors(1);
  }

  @override
  Future<List<GenreVO>?> getGenres() {
    // TODO: implement getGenres
    return _dataAgent.getGenres();
  }

  @override
  Future<List<MovieVO>?> getMoviesByGenre(int genreId) {
    // TODO: implement getMoviesByGenre
    return _dataAgent.getMoviesByGenre(genreId);
  }

  @override
  Future<List<MovieVO>?> getPopularMovies() {
    // TODO: implement getPopularMovies
    return _dataAgent.getPopularMovies(1);
  }

  @override
  Future<List<MovieVO>?> getTopRatedMovies() {
    // TODO: implement getTopRatedMovies
    return _dataAgent.getTopRatedMovies(1);
  }

}
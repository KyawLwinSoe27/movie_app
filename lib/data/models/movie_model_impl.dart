import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/persistence/daos/actor_dao.dart';
import 'package:movie_app/persistence/daos/genre_dao.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../network/dataagents/movie_data_agent.dart';
import '../../network/dataagents/retrofit_movie_data_agent_impl.dart';
import '../../persistence/daos/impls/actor_dao_impl.dart';
import '../../persistence/daos/impls/genre_dao_impl.dart';
import '../../persistence/daos/impls/movie_dao_impl.dart';
import '../../persistence/daos/movie_dao.dart';

class MovieModelImpl extends MovieModel {


  static final MovieModelImpl _singleton = MovieModelImpl._internal();

  factory MovieModelImpl() {
    return _singleton;
  }

  MovieModelImpl._internal(); //ရေးစရာဘာမှမရှိ

  MovieDataAgent _dataAgent = RetrofitMovieDataAgentImpl(); //data agent ကို setup လုပ်ေပးရတယ်။

  /// Daos
   MovieDao _mMovieDao = MovieDaoImpl(); // dependecy variable
   GenreDao _mGenreDao = GenreDaoImpl();
   ActorDao _mActorDao = ActorDaoImpl();

  /// For Testing Purpose
  void setDaosAndDataAgent(MovieDao movieDao, GenreDao genreDao, ActorDao actorDao, MovieDataAgent dataAgent) {
    _mMovieDao = movieDao;
    _mGenreDao = genreDao;
    _mActorDao = actorDao;
    _dataAgent = dataAgent;
  }
  

  // Network
  @override
  void getNowPlayingMovies(int page) {
     _dataAgent.getNowPlayingMovies(page).then((movies) async { //Network ကနေ Movies List ရလာမယ်
      List<MovieVO> nowPlayingMovies = movies?.map((movie) {
        movie.isNowPlaying = true;
        movie.isPopular = false;
        movie.isTopRated = false;
        return movie;
      }).toList() ?? [];
      _mMovieDao.saveAllMovies(nowPlayingMovies);
    });
  }

  @override
  Future<List<ActorVO>?> getActors(int page) {
    return _dataAgent.getActors(page).then((actors) async{
      if(actors != null){
        _mActorDao.saveAllActors(actors);
      }
      return Future.value(actors);
    });
  }

  @override
  Future<List<GenreVO>?> getGenres() {
    return _dataAgent.getGenres().then((genres) async{
      if( genres != null){
        _mGenreDao.saveAllGenre(genres);
      }
      return Future.value(genres);
    });
  }

  @override
  Future<List<MovieVO>?> getMoviesByGenre(int genreId) {
    return _dataAgent.getMoviesByGenre(genreId);
  }

  @override
  void getPopularMovies(int page) {
    _dataAgent.getPopularMovies(page).then((movies) async{
      List<MovieVO> popularMovies = movies?.map((movie) {
        movie.isNowPlaying = false;
        movie.isPopular = true;
        movie.isTopRated = false;
        return movie;
      }).toList() ?? [];
      _mMovieDao.saveAllMovies(popularMovies);
    });
  }

  @override
  void getTopRatedMovies(int page) {
    _dataAgent.getTopRatedMovies(page).then((movies) async {
      List<MovieVO> topRatedMovies = movies?.map((movie) {
        movie.isNowPlaying = false;
        movie.isPopular = false;
        movie.isTopRated = true;
        return movie;
      }).toList() ?? [];
      _mMovieDao.saveAllMovies(topRatedMovies);
    });
  }

  @override
  Future<List<List<ActorVO>?>> getCreditsByMovie(int movieId) {
    return _dataAgent.getCreditsByMovie(movieId);
  }

  @override
  Future<MovieVO?> getMovieDetails(int movieId) {
    return _dataAgent.getMovieDetails(movieId).then((movie) async {
      if( movie != null){
        _mMovieDao.saveSingleMovie(movie);
      }
      return Future.value(movie);
    });
  }

  // Database
  @override
  Future<List<ActorVO>?> getAllActorsFromDatabase() {
    return Future.value(
      _mActorDao.getAllActors()
    );
  }

  @override
  Future<List<GenreVO>?> getGenresFromDatabase() {
    return Future.value(
      _mGenreDao.getAllGenres()
    );
    // return Future<List<GenreVO>?>.value(_mGenreDao.getAllGenres());
  }


  @override
  Stream<List<MovieVO>> getNowPlayingMoviesFromDatabase() {
    this.getNowPlayingMovies(1);
    return _mMovieDao.getAllMoviesEventStream()
      .startWith(_mMovieDao.getNowPlayingMoviesStream())
        .map((event) => _mMovieDao.getNowPlayingMovies());
  }

  @override
  Stream<List<MovieVO>> getPopularMoviesFromDatabase() {
    this.getPopularMovies(1);
    return _mMovieDao.getAllMoviesEventStream()
      .startWith(_mMovieDao.getPopularMoviesStream())
      .map((event) => _mMovieDao.getPopularMovies());
  }

  @override
  Stream<List<MovieVO>> getTopRatedMoviesFromDatabase() {
    this.getTopRatedMovies(1);
    return _mMovieDao.getAllMoviesEventStream()
        .startWith(_mMovieDao.getTopRatedMoviesStream())
        .map((event) => _mMovieDao.getTopRatedMovies());
  }

  @override
  Future<MovieVO?> getMovieDetailsFromDatabase(movieId) {
    return Future.value(
      _mMovieDao.getMovieById(movieId)
    );
  }
}
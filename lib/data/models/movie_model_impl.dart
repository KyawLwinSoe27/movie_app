import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/persistence/daos/actor_dao.dart';
import 'package:movie_app/persistence/daos/genre_dao.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../network/dataagents/movie_data_agent.dart';
import '../../network/dataagents/retrofit_movie_data_agent_impl.dart';
import '../../persistence/daos/movie_dao.dart';

class MovieModelImpl extends MovieModel {


  static final MovieModelImpl _singleton = MovieModelImpl._internal();

  factory MovieModelImpl() {
    return _singleton;
  }

  MovieModelImpl._internal(){
    getNowPlayingMoviesFromDatabase();
    getTopRatedMoviesFromDatabase();
    getPopularMoviesFromDatabase();
    getAllActorsFromDatabase();
    getActors(1);
    getGenres();
    getGenresFromDatabase();
  }

  final MovieDataAgent _dataAgent = RetrofitMovieDataAgentImpl(); //data agent ကို setup လုပ်ေပးရတယ်။

  /// Daos
  final MovieDao _mMovieDao = MovieDao();
  final GenreDao _mGenreDao = GenreDao();
  final ActorDao _mActorDao = ActorDao();


  /// Home Page State Variables
  List<MovieVO>? nowPlayingMovies;
  List<MovieVO>? popularMovies;
  List<MovieVO>? topRatedMovies;
  List<MovieVO>? moviesByGenre;
  List<GenreVO>? genres;
  List<ActorVO>? actors;

  /// Movie Details State Varaibales
  MovieVO? movieDetails;
  List<ActorVO>? cast;
  List<ActorVO>? crew;
  

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
      nowPlayingMovies = nowPlayingMovies;
      notifyListeners();
    });
  }

  @override
  void getActors(int page) {
     _dataAgent.getActors(page).then((actors) async{
      if(actors != null){
        _mActorDao.saveAllActors(actors);
        actors = actors;
        notifyListeners();
      }
      return Future.value(actors);
    });
  }

  @override
  void getGenres() {
     _dataAgent.getGenres().then((genres) async{
      if( genres != null){
        _mGenreDao.saveAllGenre(genres);
        genres = genres;
        getMoviesByGenre(genres.first.id ?? 0);
        notifyListeners();
      }
      return Future.value(genres);
    });
  }

  @override
  void getMoviesByGenre(int genreId) {
     _dataAgent.getMoviesByGenre(genreId).then((movieList) {
       moviesByGenre = movieList;
       notifyListeners();
     });
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
      print(popularMovies);
      this.popularMovies = popularMovies;
      notifyListeners();
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
      topRatedMovies = topRatedMovies;
      notifyListeners();
    });
  }

  @override
  void getCreditsByMovie(int movieId) {
     _dataAgent.getCreditsByMovie(movieId)
         .then((creditsList) {
       this.cast = creditsList.first;
       this.crew = creditsList[1];
       notifyListeners();
     });
  }

  @override
  void getMovieDetails(int movieId) {
     _dataAgent.getMovieDetails(movieId).then((movie) async {
      if( movie != null){
        _mMovieDao.saveSingleMovie(movie);
        movieDetails = movie;
        notifyListeners();
      }

      return Future.value(movie);
    });
  }

  // Database
  @override
  void getAllActorsFromDatabase() {
    actors = _mActorDao.getAllActors();
    notifyListeners();
  }

  @override
  void getGenresFromDatabase() {
    genres = _mGenreDao.getAllGenres();
    notifyListeners();
  }


  @override
  void getNowPlayingMoviesFromDatabase() {
    this.getNowPlayingMovies(1);
    _mMovieDao.getAllMoviesEventStream()
      .startWith(_mMovieDao.getNowPlayingMoviesStream())
      .combineLatest(_mMovieDao.getNowPlayingMoviesStream(),
            (event, movieList) => movieList as List<MovieVO>)
      .first
      .then((nowPlayingMovies) {
        this.nowPlayingMovies = nowPlayingMovies;
        notifyListeners();
    });
  }

  @override
  void getPopularMoviesFromDatabase() {
    this.getPopularMovies(1);
     _mMovieDao.getAllMoviesEventStream()
      .startWith(_mMovieDao.getPopularMoviesStream())
        .combineLatest(_mMovieDao.getPopularMoviesStream(),
             (event, movieList) => movieList as List<MovieVO>)
        .first
        .then((popularMovies) {
          this.popularMovies = popularMovies;
          notifyListeners();
     });

  }

  @override
  void getTopRatedMoviesFromDatabase() {
    this.getTopRatedMovies(1);
    _mMovieDao.getAllMoviesEventStream()
        .startWith(_mMovieDao.getTopRatedMoviesStream())
        // .map((event) => _mMovieDao.getTopRatedMovies())
        .combineLatest(_mMovieDao.getTopRatedMoviesStream(),
            (event, movieList) => movieList as List<MovieVO>)
        .first
        .then((topRatedMovies) {
       this.topRatedMovies = topRatedMovies;
       notifyListeners();
    });

  }

  @override
  void getMovieDetailsFromDatabase(movieId) {

     movieDetails = _mMovieDao.getMovieById(movieId);
    notifyListeners();
  }
}
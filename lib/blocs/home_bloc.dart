
import 'package:flutter/foundation.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/models/movie_model_impl.dart';

import '../data/vos/actor_vo.dart';
import '../data/vos/genre_vo.dart';
import '../data/vos/movie_vo.dart';

class HomeBloc extends ChangeNotifier
{
  /// State
  List<MovieVO>? nowPlayingMovies;
  List<MovieVO>? popularMovies;
  List<MovieVO>? topRatedMovies;
  List<MovieVO>? moviesByGenre;
  List<GenreVO>? genres;
  List<ActorVO>? actors;

  /// Page Number State
  int pageForNowPlayingMovies = 1;

  /// Model
  MovieModel mMovieModel = MovieModelImpl();

  HomeBloc() {
    /// Now Playing Movie Database
    mMovieModel.getNowPlayingMoviesFromDatabase().listen((movieList) {
      nowPlayingMovies = movieList;
      notifyListeners();
    }).onError((handleError) {

    });

    /// Popular Movie Database
    mMovieModel.getPopularMoviesFromDatabase().listen((movieList) {
      popularMovies = movieList;
      notifyListeners();
    }).onError((handleError) {

    });


    /// Top Rated Movie Database
    mMovieModel.getTopRatedMoviesFromDatabase().listen((movieList) {
      topRatedMovies = movieList;
      notifyListeners();
    }).onError((handleError) {

    });

    /// Genres
    mMovieModel.getGenres().then((genres) {
      this.genres = genres;
      _getMovieByGenreAndRefresh(genres?.first.id ?? 0);
      notifyListeners();
    });

    /// Genres From Database
    mMovieModel.getGenresFromDatabase().then((genres) {
      this.genres = genres;
      _getMovieByGenreAndRefresh(genres?.first.id ?? 0);
      notifyListeners();
    });

    /// Actors
    mMovieModel.getActors(1).then((actors) {
      this.actors = actors;
      notifyListeners();
    }).catchError((onError) {

    });

    /// Actors From Database
    mMovieModel.getAllActorsFromDatabase().then((actors) {
      this.actors = actors;
      notifyListeners();
    }).catchError((onError) {

    });
  }

  void onTapGenre(int genreId) {
    _getMovieByGenreAndRefresh(genreId);
  }

  void _getMovieByGenreAndRefresh(int genreId) {
    mMovieModel.getMoviesByGenre(genreId).then((movieList) {
      moviesByGenre = movieList;
      notifyListeners();
    });
  }


  void onNowPlayingMovieListEndReached() {
  pageForNowPlayingMovies += 1;
  mMovieModel.getNowPlayingMovies(pageForNowPlayingMovies);
  }

}
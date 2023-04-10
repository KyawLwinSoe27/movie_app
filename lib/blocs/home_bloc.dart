

import 'dart:async';

import 'package:movie_app/data/models/movie_model_impl.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';

import '../data/models/movie_model.dart';
import '../data/vos/movie_vo.dart';

class HomeBloc
{
  /// Reactive Streams
  StreamController<List<MovieVO>>? mNowPlayingStreamController = StreamController();
  StreamController<List<MovieVO>>? mPopularMoviesListStreamController = StreamController();
  StreamController<List<MovieVO>>? mTopRatedMoviesListStreamController = StreamController();
  StreamController<List<MovieVO>>? mMovieByGenreListStreamController = StreamController();
  StreamController<List<GenreVO>>? mGenreListStreamController = StreamController();
  StreamController<List<ActorVO>>? mActorsStreamController = StreamController();

  ///Models
  MovieModel mMovieModel = MovieModelImpl();

  HomeBloc() {
    /// Now Playing Movies Database
    mMovieModel.getNowPlayingMoviesFromDatabase().listen((movieList) {
      mNowPlayingStreamController?.sink.add(movieList);
    }).onError((error) { });

    /// Popular Movies Database
    mMovieModel.getPopularMoviesFromDatabase().listen((movieList) {
      mPopularMoviesListStreamController?.sink.add(movieList);
    }).onError((error) { });

    /// Genres
    mMovieModel.getGenres().then((genreList) {
      mGenreListStreamController?.sink.add(genreList ?? []);

      /// Movie By Genre
      _getMoviesByGenreAndRefresh(genreList?.first.id ?? 0);
    }).catchError((onError) {});

    /// Genres From Database
    mMovieModel.getGenresFromDatabase().then((genreList) {
      mGenreListStreamController?.sink.add(genreList ?? []);

      /// Movie By Genre
      _getMoviesByGenreAndRefresh(genreList?.first.id ?? 0);
    }).catchError((onError) {});

    /// Showcase Database Top Rated Movie
    mMovieModel.getTopRatedMoviesFromDatabase().listen((movieList) {
      mTopRatedMoviesListStreamController?.sink.add(movieList);
    }).onError((error) { });

    /// Actors From Database
    mMovieModel.getAllActorsFromDatabase().then((actorList) {
      mActorsStreamController?.sink.add(actorList ?? []);
    }).catchError((onError) {});

    /// Actors
    mMovieModel.getActors(1).then((actorList) {
      mActorsStreamController?.sink.add(actorList ?? []);
    }).catchError((onError) {});
  }

  void onTapGenre(int genreId) {
    _getMoviesByGenreAndRefresh(genreId);
  }

  void _getMoviesByGenreAndRefresh(int genreId) {
    mMovieModel.getMoviesByGenre(genreId).then((movieByGenre) {
      mMovieByGenreListStreamController?.sink.add(movieByGenre ?? []);
    }).catchError((onError) {});
  }

  void dispose() {
    mNowPlayingStreamController?.close();
    mPopularMoviesListStreamController?.close();
    mTopRatedMoviesListStreamController?.close();
    mMovieByGenreListStreamController?.close();
    mGenreListStreamController?.close();
    mActorsStreamController?.close();
  }


}


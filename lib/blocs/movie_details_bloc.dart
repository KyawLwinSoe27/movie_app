import 'package:flutter/foundation.dart';
import 'package:movie_app/data/models/movie_model_impl.dart';

import '../data/models/movie_model.dart';
import '../data/vos/actor_vo.dart';
import '../data/vos/movie_vo.dart';

class MovieDetailsBloc extends ChangeNotifier
{
  /// State Variable
  MovieVO? movieDetails;
  List<ActorVO>? cast;
  List<ActorVO>? crew;
  List<MovieVO>? relatedMovies;
  
  /// Model
  MovieModel mMovieModel = MovieModelImpl();

  MovieDetailsBloc(int movieId) {
    /// Movie Details Bloc
    mMovieModel.getMovieDetails(movieId).then((movie) {
      movieDetails = movie;
      this.getRelatedMovieList(movie?.genres?.first.id ?? 0);
      notifyListeners();
    });

    /// Movie Details From Database
    mMovieModel.getMovieDetailsFromDatabase(movieId).then((movie) {
      movieDetails = movie;
      notifyListeners();
    });

    /// Credit Details
    mMovieModel.getCreditsByMovie(movieId).then((creditList) {
     cast = creditList.first;
     crew = creditList[1];
     notifyListeners();
    });
  }

  /// Related Movie List
  void getRelatedMovieList(int genreId) {
    mMovieModel.getMoviesByGenre(genreId).then((relatedMovies){
      this.relatedMovies = relatedMovies;
      notifyListeners();
    });
  }
  
}
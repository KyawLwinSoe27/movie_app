import 'dart:async';

import 'package:movie_app/data/models/movie_model_impl.dart';

import '../data/models/movie_model.dart';
import '../data/vos/actor_vo.dart';
import '../data/vos/movie_vo.dart';

class MovieDetailsBloc
{

  /// Reactive Stream
  StreamController<MovieVO>? movieDetailsStreamController = StreamController();
  StreamController<List<ActorVO>>? castStreamController = StreamController();
  StreamController<List<ActorVO>>? crewStreamController = StreamController();


  /// Models
  MovieModel mMovieModel = MovieModelImpl();

  MovieDetailsBloc(int movieId) {
    /// Movie Details
    mMovieModel.getMovieDetails(movieId).then((movie) {
      movieDetailsStreamController?.sink.add(movie!);
    });

    /// Movie Details From Database
    mMovieModel.getMovieDetailsFromDatabase(movieId).then((movie) {
      movieDetailsStreamController?.sink.add(movie!);
    });

    mMovieModel.getCreditsByMovie(movieId).then((creditList) {
      castStreamController?.sink.add(creditList.first ?? []);
      crewStreamController?.sink.add(creditList[1] ?? []);
    });
  }

  void dispose() {
    movieDetailsStreamController?.close();
    castStreamController?.close();
    crewStreamController?.close();
  }
}
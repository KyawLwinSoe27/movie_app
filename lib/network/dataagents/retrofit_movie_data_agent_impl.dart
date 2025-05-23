import 'package:dio/dio.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/network/api_constants.dart';
import 'package:movie_app/network/the_movie_api.dart';

import 'movie_data_agent.dart';

class RetrofitMovieDataAgentImpl extends MovieDataAgent
{

  late TheMovieApi mApi;

  static final RetrofitMovieDataAgentImpl _singleton = RetrofitMovieDataAgentImpl._internal();
  
  factory RetrofitMovieDataAgentImpl(){
    return _singleton;
  }

  RetrofitMovieDataAgentImpl._internal(){
    final dio = Dio();
    mApi = TheMovieApi(dio);
  }

  @override
  Future<List<MovieVO>?> getNowPlayingMovies(int page) {
    // TODO: implement getNowPlayingMovies
    return mApi
        .getNowPlayingMovies(API_KEY, LANGUAGE_EN_US, page.toString())
        .asStream()
        .map((response) => response.results)
        .first;
  }

  @override
  Future<List<ActorVO>?> getActors(int page) {
    // TODO: implement getActors
    return mApi
        .getActor(API_KEY, LANGUAGE_EN_US, page.toString())
        .asStream()
        .map((response) => response.results)
        .first;
  }

  @override
  Future<List<GenreVO>?> getGenres() {
    // TODO: implement getGenres
    return mApi
        .getGenres(API_KEY, LANGUAGE_EN_US)
        .asStream()
        .map((response) => response.genres)
        .first;
  }

  @override
  Future<List<MovieVO>?> getMoviesByGenre(int genreId) {
    // TODO: implement getMoviesByGenre
    return mApi
        .getMoviesByGenre(genreId.toString(),API_KEY,LANGUAGE_EN_US)
        .asStream()
        .map((response) => response.results)
        .first;
  }

  @override
  Future<List<MovieVO>?> getPopularMovies(int page) {
    // TODO: implement getPopularMovies
    return mApi
        .getPopularMovies(API_KEY, LANGUAGE_EN_US, page.toString())
        .asStream()
        .map((response) => response.results)
        .first;
  }

  @override
  Future<List<MovieVO>?> getTopRatedMovies(int page) {
    // TODO: implement getTopRatedMovies
    return mApi
        .getTopRatedMovies(API_KEY, LANGUAGE_EN_US, page.toString())
        .asStream()
        .map((response) => response.results)
        .first;
  }

  @override
  Future<List<List<ActorVO>?>> getCreditsByMovie(int movieId) {
    return mApi
        .getCreditsByMovie(movieId.toString(), API_KEY)
        .asStream()
        .map((getCreditsByMovieResponse) => [getCreditsByMovieResponse.cast,getCreditsByMovieResponse.crew])
        .first;
  }

  @override
  Future<MovieVO?> getMovieDetails(int movieId) {
    return mApi.getMovieDetails(movieId.toString(), API_KEY);
  }

}
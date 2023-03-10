import 'package:dio/dio.dart';
import 'package:movie_app/network/api_constants.dart';
import 'package:movie_app/network/responses/get_actor_response.dart';
import 'package:movie_app/network/responses/get_genres_response.dart';
import 'package:movie_app/network/responses/get_now_playing_response.dart';
import 'package:retrofit/http.dart';

import '../data/vos/movie_vo.dart';

part 'the_movie_api.g.dart';

@RestApi(baseUrl: BASE_URL_DIO)
abstract class TheMovieApi{
  factory TheMovieApi(Dio dio) = _TheMovieApi;

  @GET(END_POINTS_GET_NOW_PLAYING_MOVIES)
  Future<GetNowPlayingResponse> getNowPlayingMovies(
      @Query(PARAM_API_KEY) String apiKey,
      @Query(PARAM_LANGUAGE) String language,
      @Query(PARAM_PAGE) String page
      );

  @GET(END_POINTS_GET_TOP_RATED)
  Future<GetNowPlayingResponse> getTopRatedMovies(
      @Query(PARAM_API_KEY) String apiKey,
      @Query(PARAM_LANGUAGE) String language,
      @Query(PARAM_PAGE) String page
      );

  @GET(END_POINTS_GET_POPULAR)
  Future<GetNowPlayingResponse> getPopularMovies(
      @Query(PARAM_API_KEY) String apiKey,
      @Query(PARAM_LANGUAGE) String language,
      @Query(PARAM_PAGE) String page
      );

  @GET(END_POINTS_GET_GENRES)
  Future<GetGenresResponse> getGenres(
      @Query(PARAM_API_KEY) String apiKey,
      @Query(PARAM_LANGUAGE) String language,
      );

  @GET(END_POINTS_GET_MOVIES_BY_GENRE)
  Future<GetNowPlayingResponse> getMoviesByGenre(
      @Query(PARAM_GENRE_ID) String genreId,
      @Query(PARAM_API_KEY) String apiKey,
      @Query(PARAM_LANGUAGE) String language
      );
  
  @GET(END_POINTS_GET_ACTORS)
  Future<GetActorResponse> getActor(
      @Query(PARAM_API_KEY) String apiKey,
      @Query(PARAM_LANGUAGE) String language,
      @Query(PARAM_PAGE) String page
      );



}
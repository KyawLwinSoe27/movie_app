import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:movie_app/network/api_constants.dart';


part 'the_movie_api.g.dart';

@RestApi(baseUrl: BASE_URL_DIO)
abstract class TheMovieApi {
  //Dio means declare Type
  //_TheMovieApi is constructor for generated files
  factory TheMovieApi(Dio dio, {String baseUrl}) = _TheMovieApi;

  @GET(END_POINTS_GET_NOW_PLAYING_MOVIES)
  Future getNowPlayingMovie(
    @Query(PARAM_API_KEY) String apiKey,
    @Query(PARAM_LANGUAGE) String language,
    @Query(PARAM_PAGE) String page,
  );
}

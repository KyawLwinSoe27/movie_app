// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
//
// import '../api_constants.dart';
// import 'movie_data_agent.dart';
//
// class DioMovieDataAgentImpl extends MovieDataAgent {
//   @override
//   void getNowPlayingMovies(int page) {
//     // TODO: implement getNowPlayingMovies
//     Map<String, String> queryParameters = {
//       PARAM_API_KEY: API_KEY,
//       PARAM_LANGUAGE: LANGUAGE_EN_US,
//       PARAM_PAGE: page.toString(),
//     };
//
//     Dio()
//         .get("$BASE_URL_DIO$END_POINTS_GET_NOW_PLAYING_MOVIES",
//             queryParameters: queryParameters)
//         .then((value) {
//       debugPrint("Now Playing Movie View ==============> ${value.toString()}");
//     }).catchError((error) {
//       debugPrint("Error ============> ${error.toString()}");
//     });
//   }
// }

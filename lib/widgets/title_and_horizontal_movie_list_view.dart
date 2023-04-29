import 'package:flutter/material.dart';
import 'package:movie_app/components/smart_horizontal_list_view.dart';
import 'package:movie_app/widgets/title_text.dart';

import '../data/vos/movie_vo.dart';
import '../resources/dimensions.dart';
import '../viewitems/movie_view.dart';

class TitleAndHorizontalMovieListView extends StatelessWidget {
  final Function(int?) onTapMovie;
  final String title;
  final Function onListEndReached;

  TitleAndHorizontalMovieListView(
      {required this.nowPlayingMovies, required this.onTapMovie, required this.title, required this.onListEndReached});

  List<MovieVO>? nowPlayingMovies;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
          child: TitleText(title),
        ),
        SizedBox(height: MARGIN_MEDIUM_2),
        HorizontalMovieListsView(
          onTapMovie: (movieId) => this.onTapMovie(movieId),
          movieList: nowPlayingMovies,
          onListEndReached: () {
            this.onListEndReached();
          },
        ),
      ],
    );
  }
}

class HorizontalMovieListsView extends StatelessWidget {
  final Function(int?) onTapMovie;
  final Function onListEndReached;
  const HorizontalMovieListsView({
    Key? key,
    required this.onTapMovie,
    required this.movieList,
    required this.onListEndReached
  }) : super(key: key);

  final List<MovieVO>? movieList;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MOVIE_LIST_HEIGHT,
      child: (movieList != null)
      //     ? ListView.builder(
      //   scrollDirection: Axis.horizontal,
      //   padding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
      //   itemCount: movieList?.length ?? 0,
      //   itemBuilder: (BuildContext context, int index) {
      //     return GestureDetector(
      //       onTap: () => onTapMovie(movieList?[index].id),
      //       child: MovieView(
      //         movie: movieList?[index],
      //       ),
      //     );
      //   },
      // )
      ? SmartHorizontalListView(
          itemCount: movieList?.length ?? 0,
          padding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
          itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => onTapMovie(movieList?[index].id),
            child: MovieView(
              movie: movieList?[index],
            ),
          );
        },
          onListEndReached: () {
            this.onListEndReached();
          }
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
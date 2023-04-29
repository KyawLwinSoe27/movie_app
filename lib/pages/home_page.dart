import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/blocs/home_bloc.dart';
import 'package:movie_app/data/models/movie_model_impl.dart';
import 'package:movie_app/pages/movie_details_page.dart';
import 'package:movie_app/resources/colors.dart';
import 'package:movie_app/resources/dimensions.dart';
import 'package:movie_app/resources/strings.dart';
import 'package:movie_app/viewitems/actor_view.dart';
import 'package:movie_app/viewitems/banner_view.dart';
import 'package:movie_app/viewitems/showcase_view.dart';
import 'package:movie_app/widgets/title_text.dart';
import 'package:movie_app/widgets/title_text_with_see_more_view.dart';
import 'package:provider/provider.dart';
import '../data/models/movie_model.dart';
import '../data/vos/actor_vo.dart';
import '../data/vos/genre_vo.dart';
import '../data/vos/movie_vo.dart';
import '../viewitems/movie_view.dart';
import '../widgets/actors_and_creators_section_view.dart';
import '../widgets/see_more_text.dart';
import '../widgets/title_and_horizontal_movie_list_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeBloc(),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: PRIMARY_COLOR,
            title: const Text(
              MAIN_SCREEN_APP_BAR_TITLE,
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            leading: const Icon(Icons.menu),
            actions: const [
              Padding(
                padding: EdgeInsets.only(
                    left: 0, top: 0, right: MARGIN_MEDIUM_2, bottom: 0),
                child: Icon(Icons.search),
              )
            ],
          ),
          body: Container(
            color: HOME_SCREEN_BG_COLOR,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Selector<HomeBloc, List<MovieVO>>(
                    selector: (context, bloc) => bloc.popularMovies ?? [],
                    builder: (context, popularMovies, child) =>
                        BannerSectionView(
                      movieList: popularMovies.take(3).toList(),
                    ),
                  ),
                  const SizedBox(height: MARGIN_LARGE),
                  Selector<HomeBloc, List<MovieVO>>(
                    selector: (context, bloc) => bloc.nowPlayingMovies ?? [],
                    builder: (context, nowPlayingMovies, child) =>
                        TitleAndHorizontalMovieListView(
                      onTapMovie: (movieId) =>
                          _navigateToMovieDetailsScreen(context, movieId),
                      nowPlayingMovies: nowPlayingMovies,
                      title: BEST_POPULAR_MOVIES,
                      onListEndReached: () {
                        var bloc =
                            Provider.of<HomeBloc>(context, listen: false);
                        bloc.onNowPlayingMovieListEndReached();
                      },
                    ),
                  ),
                  SizedBox(height: MARGIN_LARGE),
                  CheckMovieShowtimeSectionView(),
                  SizedBox(
                    height: MARGIN_LARGE,
                  ),
                  Selector<HomeBloc, List<GenreVO>>(
                      selector: (context, bloc) => bloc.genres ?? [],
                      builder: (context, genreList, child) =>
                          Selector<HomeBloc, List<MovieVO>>(
                            selector: (context, bloc) =>
                                bloc.moviesByGenre ?? [],
                            builder: (context, moviesByGenreList, child) =>
                                GenreSectionView(
                              onTapMovie: (movieId) =>
                                  _navigateToMovieDetailsScreen(
                                      context, movieId),
                              genreList: genreList,
                              onChooseGenre: (genreId) {
                                HomeBloc bloc = Provider.of<HomeBloc>(context,
                                    listen: false);
                                bloc.onTapGenre(genreId!);
                              },
                              moviesByGenre: moviesByGenreList,
                                  onListEndReached: () {
                                  },
                            ),
                          )),
                  SizedBox(height: MARGIN_LARGE),
                  Selector<HomeBloc, List<MovieVO>>(
                    selector: (context, bloc) => bloc.topRatedMovies ?? [],
                    builder: (context, topRatedMovies, child) =>
                        ShowCasesSection(
                      showCaseMovies: topRatedMovies,
                    ),
                  ),
                  SizedBox(height: MARGIN_LARGE),
                  Selector<HomeBloc, List<ActorVO>>(
                    selector: (context, bloc) => bloc.actors ?? [],
                    builder: (context, actors, child) =>
                        ActorsAndCreatorsSectionView(
                      BEST_ACTOR_TITLE,
                      BEST_ACTOR_SEE_MORE,
                      actorsList: actors,
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  void _navigateToMovieDetailsScreen(BuildContext context, int? movieId) {
    if (movieId != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailsPage(
              movieId: movieId,
            ),
          ));
    }
  }
}

class GenreSectionView extends StatelessWidget {
  final Function(int?) onTapMovie;
  final List<GenreVO>? genreList;
  final Function(int?) onChooseGenre;
  final List<MovieVO>? moviesByGenre;
  final Function onListEndReached;
  const GenreSectionView(
      {Key? key,
      required this.onTapMovie,
      required this.genreList,
      required this.moviesByGenre,
      required this.onChooseGenre,
      required this.onListEndReached})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child: DefaultTabController(
            length: genreList?.length ?? 0,
            child: TabBar(
              isScrollable: true,
              indicatorColor: PLAY_BUTTON_COLOR,
              unselectedLabelColor: HOME_SCREEN_LIST_TITLE_COLOR,
              tabs: genreList
                      ?.map((genre) => Tab(
                            child: Text(genre.name ?? ""),
                          ))
                      .toList() ??
                  [],
              onTap: (index) {
                onChooseGenre(genreList?[index].id);
              },
            ),
          ),
        ),
        Container(
          color: PRIMARY_COLOR,
          padding: EdgeInsets.only(top: MARGIN_MEDIUM_2, bottom: MARGIN_LARGE),
          child: HorizontalMovieListsView(
            onTapMovie: (movieId) => this.onTapMovie(movieId),
            movieList: moviesByGenre,
            onListEndReached: () {
              this.onListEndReached();
            },
          ),
        )
      ],
    );
  }
}

class CheckMovieShowtimeSectionView extends StatelessWidget {
  const CheckMovieShowtimeSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PRIMARY_COLOR,
      height: SHOW_TIME_SECTION_HEIGHT,
      margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      padding: EdgeInsets.all(MARGIN_LARGE),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                MAIN_SCREEN_CHECK_MOVIE_SHOWTIME,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: TEXT_HEADING_1X,
                    fontWeight: FontWeight.w600),
              ),
              Spacer(),
              SeeMoreText(
                "SEE MORE",
                textColor: Colors.amber,
              )
            ],
          ),
          Spacer(),
          Icon(
            Icons.location_on_rounded,
            color: Colors.white,
            size: BANNER_PLAY_BUTTON_SIZE,
          ),
        ],
      ),
    );
  }
}

class ShowCasesSection extends StatelessWidget {
  List<MovieVO>? showCaseMovies;
  ShowCasesSection({Key? key, required this.showCaseMovies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child:
              TitleTextWithSeeMoreView(SHOW_CASES_TITLE, SHOW_CASES_SEE_MORE),
        ),
        SizedBox(height: MARGIN_MEDIUM_2),
        Container(
          height: SHOW_CASES_HEIGHT,
          child: ListView(
            scrollDirection: Axis.horizontal,
            // children: [ShowCaseView(), ShowCaseView(), ShowCaseView()],
            children: showCaseMovies
                    ?.map((showCaseMovie) => ShowCaseView(movie: showCaseMovie))
                    .toList() ??
                [],
          ),
        ),
      ],
    );
  }
}

class BannerSectionView extends StatefulWidget {
  final List<MovieVO>? movieList;
  const BannerSectionView({Key? key, required this.movieList})
      : super(key: key);

  @override
  State<BannerSectionView> createState() => _BannerSectionViewState();
}

class _BannerSectionViewState extends State<BannerSectionView> {
  double _position = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 3,
          child: PageView(
            onPageChanged: (page) {
              setState(() {
                _position = page.toDouble();
              });
            },
            children: widget.movieList
                    ?.map(
                      (movie) => BannerView(
                        movie: movie,
                      ),
                    )
                    .toList() ??
                [],
          ),
        ),
        const SizedBox(
          height: MARGIN_MEDIUM,
        ),
        DotsIndicator(
          dotsCount: (widget.movieList?.length == 0)
              ? 1
              : widget.movieList?.length ?? 1,
          position: _position,
          decorator: const DotsDecorator(
              color: HOME_SCREEN_DOTS_INDOCATOR_INACTIVE_COLOR,
              activeColor: PLAY_BUTTON_COLOR),
        ),
      ],
    );
  }
}

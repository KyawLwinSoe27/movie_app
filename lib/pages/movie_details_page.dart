import 'package:flutter/material.dart';
import 'package:movie_app/blocs/movie_details_bloc.dart';
import 'package:movie_app/resources/colors.dart';
import 'package:movie_app/widgets/rating_view.dart';
import 'package:movie_app/widgets/title_text.dart';
import 'package:provider/provider.dart';

import '../data/vos/actor_vo.dart';
import '../data/vos/movie_vo.dart';
import '../network/api_constants.dart';
import '../resources/dimensions.dart';
import '../resources/strings.dart';
import '../widgets/actors_and_creators_section_view.dart';
import '../widgets/gradient_view.dart';
import '../widgets/title_and_horizontal_movie_list_view.dart';

class MovieDetailsPage extends StatelessWidget {
  final int movieId;

  const MovieDetailsPage({Key? key, required this.movieId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MovieDetailsBloc(movieId),
      child: Scaffold(
        body: Selector<MovieDetailsBloc, MovieVO>(
          selector: (context, bloc) => bloc.movieDetails!,
          builder: (context, movie, child) => Container(
            color: HOME_SCREEN_BG_COLOR,
            child: CustomScrollView(
              slivers: [
                MovieDetailsSliverAppBarView(() => Navigator.pop(context),
                    movie: movie),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                        child: TrailerSection(
                            overview: movie.overview,
                            genreList:
                            movie.getGenreListAsStringList() ?? []),
                      ),
                      const SizedBox(
                        height: MARGIN_LARGE,
                      ),
                      Selector<MovieDetailsBloc, List<ActorVO>>(
                        selector: (context, bloc) => bloc.cast ?? [],
                        builder: (context, actors, child) => ActorsAndCreatorsSectionView(
                          MOVIE_DETAILS_SCREEN_ACTOR_TITLE,
                          "",
                          seeMoreButtonVisibility: false,
                          actorsList: actors,
                        ),
                      ),
                      const SizedBox(
                        height: MARGIN_LARGE,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                        child: AboutFilmSectionView(aboutMovie: movie),
                      ),
                      const SizedBox(
                        height: MARGIN_LARGE,
                      ),
                      Selector<MovieDetailsBloc, List<ActorVO>>(
                        selector: (context, bloc) => bloc.crew ?? [],
                        builder: (context, crewList, child) {
                          return (crewList.isNotEmpty) ? ActorsAndCreatorsSectionView(
                            MOVIE_DETAILS_SCREEN_CREATOR_TITLE,
                            MOVIE_DETAILS_SCREEN_CREATORS_SEE_MORE,
                            actorsList: crewList,
                          ) : Container();
                        },
                      ),
                      const SizedBox(
                        height: MARGIN_LARGE,
                      ),
                      Selector<MovieDetailsBloc,List<MovieVO>?>(
                        selector: (context,bloc) => bloc.relatedMovies,
                        builder: (context,relatedMovies,child) => TitleAndHorizontalMovieListView(
                            onTapMovie: (movieId) =>
                                _navigateToMovieDetailsScreen(context, movieId),
                            nowPlayingMovies: relatedMovies,
                            title : BEST_POPULAR_MOVIES,
                          onListEndReached: () {},
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
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

class AboutFilmSectionView extends StatelessWidget {
  final MovieVO? aboutMovie;
  const AboutFilmSectionView({
    Key? key, required this.aboutMovie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleText("ABOUT FILM"),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        AboutFilmInfoView("Original Title", aboutMovie?.title ?? ""),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        AboutFilmInfoView("Type", aboutMovie?.getGenreListAsCommaSeparatedString() ?? ""),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        AboutFilmInfoView("Production", aboutMovie?.getProductionCountriesAsCommaSeparatedString() ?? ""),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        AboutFilmInfoView("Premier", aboutMovie?.releaseDate ?? ""),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        AboutFilmInfoView("Description",aboutMovie?.overview ?? "")
      ],
    );
  }
}

class AboutFilmInfoView extends StatelessWidget {
  final String lable;
  final String description;

  const AboutFilmInfoView(this.lable, this.description, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 3,
          child: Text(
            lable,
            style: const TextStyle(
                color: MOVIE_DETAILS_INFO_TEXT_COLOR,
                fontWeight: FontWeight.w600,
                fontSize: MARGIN_MEDIUM_2),
          ),
        ),
        const SizedBox(
          width: MARGIN_CARD_MEDIUM_2,
        ),
        Expanded(
          child: Text(
            description,
            style: const TextStyle(
              color: Colors.white,
              fontSize: MARGIN_MEDIUM_2,
            ),
          ),
        )
      ],
    );
  }
}

class TrailerSection extends StatelessWidget {
  final List<String> genreList;
  final String? overview;

  const TrailerSection(
      {Key? key, required this.overview, required this.genreList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MovieTimeAndGenreView(genreList: genreList),
        const SizedBox(
          height: MARGIN_MEDIUM_3,
        ),
        StoryLineView(overview: overview ?? ""),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        const Row(
          children: [
            MovieDetailsScreenButtonView(
              "PLAY TRAILER",
              PLAY_BUTTON_COLOR,
              Icon(
                Icons.play_circle_filled,
                color: Colors.black54,
              ),
            ),
            SizedBox(
              width: MARGIN_MEDIUM,
            ),
            MovieDetailsScreenButtonView(
              "RATE MOVIE",
              HOME_SCREEN_BG_COLOR,
              Icon(
                Icons.star,
                color: PLAY_BUTTON_COLOR,
              ),
              isGhostButton: true,
            )
          ],
        )
      ],
    );
  }
}

class MovieDetailsScreenButtonView extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Icon buttonIcon;
  final bool isGhostButton;
  const MovieDetailsScreenButtonView(
      this.title, this.backgroundColor, this.buttonIcon,
      {Key? key, this.isGhostButton = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MARGIN_XXLARGE,
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(MARGIN_LARGE),
        border: (isGhostButton)
            ? Border.all(
                color: Colors.white,
                width: 2,
              )
            : null,
      ),
      child: Center(
        child: Row(
          children: [
            buttonIcon,
            const SizedBox(
              width: MARGIN_SMALL,
            ),
            Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: TEXT_REGULAR_2X,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class StoryLineView extends StatelessWidget {
  final String overview;
  const StoryLineView({Key? key, required this.overview}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleText(MOVIE_DETAILS_STORYLINE_TITLE),
        const SizedBox(
          height: MARGIN_MEDIUM,
        ),
        Text(
          overview,
          style: const TextStyle(color: Colors.white, fontSize: TEXT_REGULAR_2X),
        ),
      ],
    );
  }
}

class MovieTimeAndGenreView extends StatelessWidget {
  const MovieTimeAndGenreView({
    Key? key,
    required this.genreList,
  }) : super(key: key);

  final List<String> genreList;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        const Icon(
          Icons.access_time,
          color: Colors.amber,
        ),
        const SizedBox(
          width: MARGIN_SMALL,
        ),
        const Text(
          "2h 30mins",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          width: MARGIN_MEDIUM,
        ),
          ...genreList
            .map((genre) => GenreChipView(genre),).toList(),
        const Icon(
          Icons.favorite_border,
          color: Colors.white,
        ),
      ],
    );
  }
}

class GenreChipView extends StatelessWidget {
  final String genreText;

  const GenreChipView(this.genreText, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Chip(
          backgroundColor: MOVIE_DETAILS_SCREEN_CHIP_BACKGROUND_COLOR,
          label: Text(
            genreText,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          width: MARGIN_SMALL,
        ),
      ],
    );
  }
}

class MovieDetailsSliverAppBarView extends StatelessWidget {
  final Function onTapBack;
  final MovieVO? movie;
  const MovieDetailsSliverAppBarView(this.onTapBack,
      {Key? key, required this.movie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: PRIMARY_COLOR,
      expandedHeight: MOVIE_DETAILS_SCREEN_SLIVER_APP_BAR_HEIGHT,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            Positioned.fill(
              child:
                  MovieDetailsAppBarImageView(imgUrl: movie?.posterPath ?? ""),
            ),
            const Positioned.fill(child: GradientView()),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: MARGIN_XLARGE,
                  left: MARGIN_MEDIUM_2,
                ),
                child: BackButtonView(() {
                  onTapBack();
                }),
              ),
            ),
            const Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(
                  top: MARGIN_XLARGE + MARGIN_SMALL,
                  right: MARGIN_MEDIUM_2,
                ),
                child: SearchButtonView(),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: MARGIN_MEDIUM_2,
                      right: MARGIN_MEDIUM_2,
                      bottom: MARGIN_LARGE),
                  child: MovieDetailsTitleAndRatingView(movie: movie),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MovieDetailsTitleAndRatingView extends StatelessWidget {
  final MovieVO? movie;
  const MovieDetailsTitleAndRatingView({Key? key, required this.movie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            MovieDetailsYearView(
                year: movie?.releaseDate?.substring(0, 4) ?? ""),
            const Spacer(),
            MovieDetailsRatingView(
              rating: movie?.voteCount ?? 0,
              average: movie?.voteAverage ?? 0.0,
            )
          ],
        ),
        const SizedBox(
          height: MARGIN_MEDIUM,
        ),
        Text(
          movie?.title ?? "",
          style: const TextStyle(
              color: Colors.white,
              fontSize: TEXT_HEADING_1X,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}

class MovieDetailsRatingView extends StatelessWidget {
  final int rating;
  final double average;
  const MovieDetailsRatingView({
    Key? key,
    required this.rating,
    required this.average,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const RatingView(),
            const SizedBox(
              height: MARGIN_SMALL / 2,
            ),
            TitleText("$rating VOTES"),
            const SizedBox(
              height: MARGIN_SMALL / 2,
            )
          ],
        ),
        const SizedBox(
          width: MARGIN_MEDIUM,
        ),
        Text(
          average.toString() ?? "",
          style: const TextStyle(
              color: Colors.white, fontSize: MOVIE_DETAILS_RATING_TEXT_SIZE),
        )
      ],
    );
  }
}

class MovieDetailsYearView extends StatelessWidget {
  final String year;
  const MovieDetailsYearView({Key? key, required this.year}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: MARGIN_MEDIUM,
      ),
      height: MARGIN_XLARGE,
      decoration: BoxDecoration(
        color: PLAY_BUTTON_COLOR,
        borderRadius: BorderRadius.circular(
          MARGIN_XLARGE / 2,
        ),
      ),
      child: Center(
          child: Text(
        year,
        style: const TextStyle(color: Colors.white),
      )),
    );
  }
}

class SearchButtonView extends StatelessWidget {
  const SearchButtonView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.search,
      color: Colors.white,
      size: MARGIN_XLARGE,
    );
  }
}

class BackButtonView extends StatelessWidget {
  final Function onTapBack;
  const BackButtonView(this.onTapBack, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapBack();
      },
      child: Container(
        width: MARGIN_XXLARGE,
        height: MARGIN_XXLARGE,
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.black54),
        child: const Icon(
          Icons.chevron_left,
          color: Colors.white,
          size: MARGIN_XLARGE,
        ),
      ),
    );
  }
}

class MovieDetailsAppBarImageView extends StatelessWidget {
  final String imgUrl;
  const MovieDetailsAppBarImageView({
    Key? key,
    required this.imgUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "$IMAGE_BASE_URL$imgUrl",
      fit: BoxFit.cover,
    );
  }
}

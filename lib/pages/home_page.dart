import 'dart:math';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/pages/movie_details_page.dart';
import 'package:movie_app/resources/colors.dart';
import 'package:movie_app/resources/dimensions.dart';
import 'package:movie_app/resources/strings.dart';
import 'package:movie_app/viewitems/actor_view.dart';
import 'package:movie_app/viewitems/banner_view.dart';
import 'package:movie_app/viewitems/showcase_view.dart';
import 'package:movie_app/widgets/title_text.dart';
import 'package:movie_app/widgets/title_text_with_see_more_view.dart';

import '../viewitems/movie_view.dart';
import '../widgets/actors_and_creators_section_view.dart';
import '../widgets/see_more_text.dart';

class HomePage extends StatelessWidget {
  List<String> genreList = [
    "Action",
    "Adventure",
    "Horror",
    "Comedy",
    "Thirller",
    "Drama"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                BannerSectionView(),
                SizedBox(height: MARGIN_LARGE),
                BestPopularMoviesAndSerialsSectionView(
                    () => _navigateToMovieDetailsScreen(context)),
                SizedBox(height: MARGIN_LARGE),
                CheckMovieShowtimeSectionView(),
                SizedBox(
                  height: MARGIN_LARGE,
                ),
                GenreSectionView(() => _navigateToMovieDetailsScreen(context),
                    genreList: genreList),
                SizedBox(height: MARGIN_LARGE),
                ShowCasesSection(),
                SizedBox(height: MARGIN_LARGE),
                ActorsAndCreatorsSectionView(
                    BEST_ACTOR_TITLE, BEST_ACTOR_SEE_MORE),
              ],
            ),
          ),
        ));
  }

  void _navigateToMovieDetailsScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MovieDetailsPage(),
        ));
  }
}

class GenreSectionView extends StatelessWidget {
  const GenreSectionView(this.onTapMovie, {required this.genreList});
  final Function onTapMovie;
  final List<String> genreList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child: DefaultTabController(
            length: genreList.length,
            child: TabBar(
              isScrollable: true,
              indicatorColor: PLAY_BUTTON_COLOR,
              unselectedLabelColor: HOME_SCREEN_LIST_TITLE_COLOR,
              tabs: genreList
                  .map((genre) => Tab(
                        child: Text(genre),
                      ))
                  .toList(),
            ),
          ),
        ),
        Container(
          color: PRIMARY_COLOR,
          padding: EdgeInsets.only(top: MARGIN_MEDIUM_2, bottom: MARGIN_LARGE),
          child: HorizontalMovieListsView(() {
            this.onTapMovie();
          }),
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
  const ShowCasesSection({
    Key? key,
  }) : super(key: key);

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
            children: [ShowCaseView(), ShowCaseView(), ShowCaseView()],
          ),
        ),
      ],
    );
  }
}

class BestPopularMoviesAndSerialsSectionView extends StatelessWidget {
  final Function onTapMovie;

  BestPopularMoviesAndSerialsSectionView(this.onTapMovie);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
          child: const TitleText(MAIN_SCREEN_BEST_POPULAR_MOVIES_AND_SERIALS),
        ),
        SizedBox(height: MARGIN_MEDIUM_2),
        HorizontalMovieListsView(() {
          this.onTapMovie();
        }),
      ],
    );
  }
}

class HorizontalMovieListsView extends StatelessWidget {
  final Function onTapMovie;
  HorizontalMovieListsView(this.onTapMovie);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MOVIE_LIST_HEIGHT,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return MovieView(() {
            this.onTapMovie();
          });
        },
      ),
    );
  }
}

class BannerSectionView extends StatefulWidget {
  const BannerSectionView({
    Key? key,
  }) : super(key: key);

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
            children: const [
              BannerView(),
              BannerView(),
              BannerView(),
              BannerView(),
            ],
          ),
        ),
        SizedBox(
          height: MARGIN_MEDIUM,
        ),
        new DotsIndicator(
          dotsCount: 4,
          position: _position,
          decorator: DotsDecorator(
              color: HOME_SCREEN_DOTS_INDOCATOR_INACTIVE_COLOR,
              activeColor: PLAY_BUTTON_COLOR),
        ),
      ],
    );
  }
}

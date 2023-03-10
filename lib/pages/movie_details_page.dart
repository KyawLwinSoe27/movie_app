import 'package:flutter/material.dart';
import 'package:movie_app/resources/colors.dart';
import 'package:movie_app/widgets/rating_view.dart';
import 'package:movie_app/widgets/title_text.dart';

import '../resources/dimensions.dart';
import '../resources/strings.dart';
import '../widgets/actors_and_creators_section_view.dart';
import '../widgets/gradient_view.dart';

class MovieDetailsPage extends StatelessWidget {
  final List<String> genreList = [
    "Action",
    "Adventrure",
  ];

  MovieDetailsPage({key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: HOME_SCREEN_BG_COLOR,
        child: CustomScrollView(
          slivers: [
            MovieDetailsSliverAppBarView(() => Navigator.pop(context)),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                    child: TrailerSection(genreList),
                  ),
                  SizedBox(
                    height: MARGIN_LARGE,
                  ),
                  ActorsAndCreatorsSectionView(
                    MOVIE_DETAILS_SCREEN_ACTOR_TITLE,
                    "",
                    seeMoreButtonVisibility: false, actorsList: [],
                  ),
                  SizedBox(height: MARGIN_LARGE,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                    child: AboutFilmSectionView(),
                  ),
                  SizedBox(height: MARGIN_LARGE,),
                  ActorsAndCreatorsSectionView(
                      MOVIE_DETAILS_SCREEN_CREATOR_TITLE,
                      MOVIE_DETAILS_SCREEN_CREATORS_SEE_MORE, actorsList: [],),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AboutFilmSectionView extends StatelessWidget {
  const AboutFilmSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText("ABOUT FILM"),
        SizedBox(height: MARGIN_MEDIUM_2,),
        AboutFilmInfoView(
            "Original Title", "X-Men Origins: The Wolverine"),
        SizedBox(height: MARGIN_MEDIUM_2,),
        AboutFilmInfoView("Type", "Action, Adventure"),
        SizedBox(height: MARGIN_MEDIUM_2,),
        AboutFilmInfoView("Production", "United Kingdom, USA"),
        SizedBox(height: MARGIN_MEDIUM_2,),
        AboutFilmInfoView("Premier", "8 November 2016(World)"),
        SizedBox(height: MARGIN_MEDIUM_2,),
        AboutFilmInfoView("Description",
            "The Wolverine was released by 20th Century Fox in various international markets on July 24, 2013, and in the United States two days later. It received generally positive reviews from critics, with praise for its action sequences")
      ],
    );
  }
}

class AboutFilmInfoView extends StatelessWidget {
  final String lable;
  final String description;

  AboutFilmInfoView(this.lable, this.description);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            width: MediaQuery.of(context).size.width / 3,
            child: Text(
              lable,
              style: TextStyle(
                  color: MOVIE_DETAILS_INFO_TEXT_COLOR,
                  fontWeight: FontWeight.w600,
                  fontSize: MARGIN_MEDIUM_2),
            ),),
        SizedBox(
          width: MARGIN_CARD_MEDIUM_2,
        ),
        Expanded(
          child: Text(
            description,
            style: TextStyle(
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

  const TrailerSection(this.genreList);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MovieTimeAndGenreView(genreList: genreList),
        SizedBox(
          height: MARGIN_MEDIUM_3,
        ),
        StoryLineView(),
        SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        Row(
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
  MovieDetailsScreenButtonView(
      this.title, this.backgroundColor, this.buttonIcon,
      {this.isGhostButton = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MARGIN_XXLARGE,
      padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
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
            SizedBox(
              width: MARGIN_SMALL,
            ),
            Text(
              title,
              style: TextStyle(
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
  const StoryLineView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(MOVIE_DETAILS_STORYLINE_TITLE),
        SizedBox(
          height: MARGIN_MEDIUM,
        ),
        Text(
          "The film's development began in 2009 after the release of X-Men Origins: Wolverine. Christopher McQuarrie was hired to write a screenplay for The Wolverine in August 2009. In October 2010, Darren Aronofsky was hired to direct the film. The project was delayed following Aronofsky's departure and the Tōhoku earthquake and tsunami in March 2011. In June 2011, Mangold was brought on board to replace Aronofsky. Bomback was then hired to rewrite the screenplay in September 2011. The supporting characters were cast in July 2012 with principal photography beginning at the end of the month around New South Wales before moving to Tokyo in August 2012 and back to New South Wales in October 2012. The film was converted to 3D in post-production.",
          style: TextStyle(color: Colors.white, fontSize: TEXT_REGULAR_2X),
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
    return Row(
      children: [
        Icon(
          Icons.access_time,
          color: Colors.amber,
        ),
        SizedBox(
          width: MARGIN_SMALL,
        ),
        Text(
          "2h 30mins",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          width: MARGIN_MEDIUM,
        ),
        Row(
          children: genreList.map((genre) => GenreChipView(genre)).toList(),
        ),
        Spacer(),
        Icon(
          Icons.favorite_border,
          color: Colors.white,
        ),
      ],
    );
  }
}

class GenreChipView extends StatelessWidget {
  final String genreText;

  const GenreChipView(this.genreText);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Chip(
          backgroundColor: MOVIE_DETAILS_SCREEN_CHIP_BACKGROUND_COLOR,
          label: Text(
            genreText,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          width: MARGIN_SMALL / 2,
        ),
      ],
    );
  }
}

class MovieDetailsSliverAppBarView extends StatelessWidget {
  final Function onTapBack;
  MovieDetailsSliverAppBarView(this.onTapBack);

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
              child: MovieDetailsAppBarImageView(),
            ),
            Positioned.fill(child: GradientView()),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  top: MARGIN_XLARGE,
                  left: MARGIN_MEDIUM_2,
                ),
                child: BackButtonView(() {
                  this.onTapBack();
                }),
              ),
            ),
            Align(
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
                  padding: EdgeInsets.only(
                      left: MARGIN_MEDIUM_2,
                      right: MARGIN_MEDIUM_2,
                      bottom: MARGIN_LARGE),
                  child: MovieDetailsTitleAndRatingView(),
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
  const MovieDetailsTitleAndRatingView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            MovieDetailsYearView(),
            Spacer(),
            MovieDetailsRatingView()
          ],
        ),
        SizedBox(
          height: MARGIN_MEDIUM,
        ),
        Text(
          "X-Men Origins: The\nWolvering",
          style: TextStyle(
              color: Colors.white,
              fontSize: TEXT_HEADING_1X,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}

class MovieDetailsRatingView extends StatelessWidget {
  const MovieDetailsRatingView({
    Key? key,
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
            RatingView(),
            SizedBox(
              height: MARGIN_SMALL / 2,
            ),
            TitleText("38876 VOTES"),
            SizedBox(
              height: MARGIN_SMALL / 2,
            )
          ],
        ),
        SizedBox(
          width: MARGIN_MEDIUM,
        ),
        Text(
          "9,76",
          style: TextStyle(
              color: Colors.white, fontSize: MOVIE_DETAILS_RATING_TEXT_SIZE),
        )
      ],
    );
  }
}

class MovieDetailsYearView extends StatelessWidget {
  const MovieDetailsYearView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
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
        "2016",
        style: TextStyle(color: Colors.white),
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
    return Icon(
      Icons.search,
      color: Colors.white,
      size: MARGIN_XLARGE,
    );
  }
}

class BackButtonView extends StatelessWidget {

  final Function onTapBack;
  BackButtonView(this.onTapBack);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapBack();
      },
      child: Container(
        width: MARGIN_XXLARGE,
        height: MARGIN_XXLARGE,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black54),
        child: Icon(
          Icons.chevron_left,
          color: Colors.white,
          size: MARGIN_XLARGE,
        ),
      ),
    );
  }
}

class MovieDetailsAppBarImageView extends StatelessWidget {
  const MovieDetailsAppBarImageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "https://i.ytimg.com/vi/u1VCP3O8wG0/maxresdefault.jpg",
      fit: BoxFit.cover,
    );
  }
}

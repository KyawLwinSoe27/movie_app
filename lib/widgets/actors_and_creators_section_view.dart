import 'package:flutter/material.dart';
import 'package:movie_app/widgets/title_text_with_see_more_view.dart';

import '../resources/colors.dart';
import '../resources/dimensions.dart';
import '../resources/strings.dart';
import '../viewitems/actor_view.dart';

class ActorsAndCreatorsSectionView extends StatelessWidget {

  final String textTitle;
  final String seeMoreText;
  final bool seeMoreButtonVisibility;

  const ActorsAndCreatorsSectionView(this.textTitle,this.seeMoreText, {this.seeMoreButtonVisibility = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PRIMARY_COLOR,
      padding: EdgeInsets.only(top: MARGIN_MEDIUM_2, bottom: MARGIN_XXLARGE),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(MARGIN_MEDIUM_2),
            child:
                TitleTextWithSeeMoreView(textTitle, seeMoreText,seeMoreButtonVisibility: seeMoreButtonVisibility,),
          ),
          SizedBox(
            height: MARGIN_MEDIUM,
          ),
          Container(
            height: MOVIE_LIST_HEIGHT,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: MARGIN_MEDIUM),
              children: [
                ActorView(),
                ActorView(),
                ActorView(),
                ActorView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/network/api_constants.dart';

import '../resources/colors.dart';
import '../resources/dimensions.dart';

class ActorView extends StatelessWidget {
  final ActorVO? actor;
  const ActorView({Key? key, required this.actor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MOVIE_LIST_ITEM_WIDTH,
        margin: EdgeInsets.only(left: MARGIN_MEDIUM),
        child: Stack(
          children: [
            Positioned.fill(
              child: actor?.profilePath != null ? ActorImageView(actorProfilePath : actor?.profilePath ?? "") : Container(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topRight,
                child: FavouriteButtonView(),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ActorNameAndLikeView(actorName : actor?.name ?? ""),
            )
          ],
        ));
  }
}

class ActorImageView extends StatelessWidget {
  final String? actorProfilePath;
  const ActorImageView({
    Key? key, required this.actorProfilePath
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "$IMAGE_BASE_URL${actorProfilePath ?? ""}",
      fit: BoxFit.cover,
    );
  }
}

class FavouriteButtonView extends StatelessWidget {
  const FavouriteButtonView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.favorite_border,
      color: Colors.white,
    );
  }
}

class ActorNameAndLikeView extends StatelessWidget {
  final String? actorName;
  const ActorNameAndLikeView({
    Key? key, required this.actorName
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: MARGIN_MEDIUM_2, vertical: MARGIN_MEDIUM_2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            actorName ?? "",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: MARGIN_MEDIUM,
          ),
          Row(
            children: [
              Icon(
                Icons.thumb_up,
                color: Colors.amber,
                size: MARGIN_CARD_MEDIUM_2,
              ),
              SizedBox(width: MARGIN_MEDIUM),
              Text(
                "YOU LIKE 13 MOVIES",
                style: TextStyle(
                    color: HOME_SCREEN_LIST_TITLE_COLOR,
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      ),
    );
  }
}

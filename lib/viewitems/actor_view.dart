import 'package:flutter/material.dart';

import '../resources/colors.dart';
import '../resources/dimensions.dart';

class ActorView extends StatelessWidget {
  const ActorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MOVIE_LIST_ITEM_WIDTH,
        margin: EdgeInsets.only(left: MARGIN_MEDIUM),
        child: Stack(
          children: [
            Positioned.fill(
              child: ActorImageView(),
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
              child: ActorNameAndLikeView(),
            )
          ],
        ));
  }
}

class ActorImageView extends StatelessWidget {
  const ActorImageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "https://pagesix.com/wp-content/uploads/sites/3/2022/12/leonardo-dicaprio-party-0001.jpg?quality=75&strip=all&w=1024",
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
  const ActorNameAndLikeView({
    Key? key,
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
            "Leonado Dicapario",
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

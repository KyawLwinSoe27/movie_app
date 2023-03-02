import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/widgets/rating_view.dart';
import '../resources/dimensions.dart';

class MovieView extends StatelessWidget {
  final Function onTapMovie;
  MovieView(this.onTapMovie);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: MARGIN_MEDIUM),
      width: MOVIE_LIST_ITEM_WIDTH,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              onTapMovie();
            },
            child: Image.network(
              "https://i-viaplay-com.akamaized.net/viaplay-prod/279/556/1460037707-ecdc08be05c2c5d087ea0f67d239b9bcf3fec96b.jpg?width=1600&height=900",
              height: 200.0,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: MARGIN_MEDIUM,
          ),
          Text(
            "West World",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: TEXT_REGULAR_2X,
            ),
          ),
          SizedBox(
            height: MARGIN_MEDIUM,
          ),
          Row(
            children: [
              Text(
                "9,89",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: TEXT_REGULAR),
              ),
              SizedBox(width: MARGIN_MEDIUM),
              RatingView(),
            ],
          )
        ],
      ),
    );
  }
}

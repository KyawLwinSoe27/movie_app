import 'package:flutter/material.dart';
import 'package:movie_app/widgets/rating_view.dart';
import '../data/vos/movie_vo.dart';
import '../network/api_constants.dart';
import '../resources/dimensions.dart';

class MovieView extends StatelessWidget {
  final MovieVO? movie;
  const MovieView({Key? key, required this.movie}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: MARGIN_MEDIUM),
      width: MOVIE_LIST_ITEM_WIDTH,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            "$IMAGE_BASE_URL${movie?.posterPath ?? ""}",
            height: 200.0,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: MARGIN_MEDIUM,
          ),
          Text(
            movie?.title ?? "",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: TEXT_REGULAR_2X,
            ),
          ),
          const SizedBox(
            height: MARGIN_MEDIUM,
          ),
          const Row(
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

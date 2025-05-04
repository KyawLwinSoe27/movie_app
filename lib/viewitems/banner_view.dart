import 'package:flutter/material.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/resources/dimensions.dart';

import '../network/api_constants.dart';
import '../widgets/gradient_view.dart';
import '../widgets/play_button_view.dart';

class BannerView extends StatelessWidget {
  final MovieVO? movie;
  const BannerView({ Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:  [
        Positioned.fill(
          child: BannerImageView(imgUrl: movie?.posterPath ?? ""),
        ),
        const Positioned.fill(
          child: GradientView(),),
        Align(
          alignment: Alignment.bottomLeft,
          child: BannerTitleView(title: movie?.title ?? ""),
        ),
        const Align(
          alignment: Alignment.center,
          child: PlayButtonView(),
        ),
      ],
    );
  }
}




class BannerTitleView extends StatelessWidget {
  final String title;
  const BannerTitleView({
    Key? key,
    required this.title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(MARGIN_MEDIUM_2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: TEXT_HEADING_1X,
            ),
          ),
          const Text(
            "Official Review.",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: TEXT_HEADING_1X,
            ),
          )
        ],
      ),
    );
  }
}

class BannerImageView extends StatelessWidget {
  final String imgUrl;
  const BannerImageView({
    Key? key,
    required this.imgUrl
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "$IMAGE_BASE_URL$imgUrl",
      fit: BoxFit.cover,
    );
  }
}

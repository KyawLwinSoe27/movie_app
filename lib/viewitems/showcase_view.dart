import 'package:flutter/material.dart';
import 'package:movie_app/resources/dimensions.dart';
import 'package:movie_app/widgets/title_text.dart';

import '../data/vos/movie_vo.dart';
import '../network/api_constants.dart';
import '../widgets/play_button_view.dart';

class ShowCaseView extends StatelessWidget {
  final MovieVO? movie;
  const ShowCaseView({ Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
      width: 300,
      child: Stack(
        children: [
          Positioned.fill(
            child: ShowCaseImageView(imageURL: movie?.posterPath ?? "",),
          ),
          const Align(
            alignment: Alignment.center,
            child: PlayButtonView(),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(MARGIN_MEDIUM_2),
              child: ShowCaseTitleView(title : movie?.title ?? ""),
            ),
          ),
        ],
      ),
    );
  }
}

class ShowCaseTitleView extends StatelessWidget {
  final String? title;
  const ShowCaseTitleView({
    Key? key, required this.title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title ?? "",
          style: const TextStyle(
              color: Colors.white,
              fontSize: TEXT_REGULAR_3X,
              fontWeight: FontWeight.w600
          ),
        ),
        const SizedBox(height: MARGIN_MEDIUM),
        const TitleText("15 DECEMBER 2016"),
      ],
    );
  }
}

class ShowCaseImageView extends StatelessWidget {
  final String imageURL;
  const ShowCaseImageView({
    Key? key, required this.imageURL
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "$IMAGE_BASE_URL$imageURL",
      fit: BoxFit.cover,
    );
  }
}

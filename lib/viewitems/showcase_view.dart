import 'package:flutter/material.dart';
import 'package:movie_app/resources/dimensions.dart';
import 'package:movie_app/widgets/title_text.dart';

import '../widgets/play_button_view.dart';

class ShowCaseView extends StatelessWidget {
  const ShowCaseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: MARGIN_MEDIUM_2),
      width: 300,
      child: Container(
        child: Stack(
          children: [
            Positioned.fill(
              child: ShowCaseImageView(),
            ),
            Align(
              alignment: Alignment.center,
              child: PlayButtonView(),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(MARGIN_MEDIUM_2),
                child: ShowCaseTitleView(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShowCaseTitleView extends StatelessWidget {
  const ShowCaseTitleView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Passengers",
          style: TextStyle(
              color: Colors.white,
              fontSize: TEXT_REGULAR_3X,
              fontWeight: FontWeight.w600
          ),
        ),
        SizedBox(height: MARGIN_MEDIUM),
        TitleText("15 DECEMBER 2016"),
      ],
    );
  }
}

class ShowCaseImageView extends StatelessWidget {
  const ShowCaseImageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "https://i-viaplay-com.akamaized.net/viaplay-prod/279/556/1460037707-ecdc08be05c2c5d087ea0f67d239b9bcf3fec96b.jpg?width=1600&height=900",
      fit: BoxFit.cover,
    );
  }
}

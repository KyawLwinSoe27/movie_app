import 'package:flutter/material.dart';
import 'package:movie_app/resources/dimensions.dart';
import 'package:movie_app/resources/colors.dart';

import '../widgets/gradient_view.dart';
import '../widgets/play_button_view.dart';

class BannerView extends StatelessWidget {
  const BannerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children:  [
          Positioned.fill(
            child: BannerImageView(),
          ),
          Positioned.fill(
            child: GradientView(),),
          Align(
            alignment: Alignment.bottomLeft,
            child: BannerTitleView(),
          ),
          Align(
            alignment: Alignment.center,
            child: PlayButtonView(),
          ),
        ],
      ),
    );
  }
}




class BannerTitleView extends StatelessWidget {
  const BannerTitleView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(MARGIN_MEDIUM_2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text(
            "The Wolverine 2013.",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: TEXT_HEADING_1X,
            ),
          ),
          Text(
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
  const BannerImageView({
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

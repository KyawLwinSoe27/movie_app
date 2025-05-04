import 'package:flutter/cupertino.dart';
import 'package:movie_app/widgets/see_more_text.dart';
import 'package:movie_app/widgets/title_text.dart';

class TitleTextWithSeeMoreView extends StatelessWidget {
  final String titleText;
  final String seeMoreText;
  final bool seeMoreButtonVisibility;
  const TitleTextWithSeeMoreView(this.titleText, this.seeMoreText, {Key? key, this.seeMoreButtonVisibility = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TitleText(titleText),
        const Spacer(),
        Visibility(visible:seeMoreButtonVisibility,child: SeeMoreText(seeMoreText)),
      ],
    );
  }
}

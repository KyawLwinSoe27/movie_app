import 'package:flutter/material.dart';

import '../resources/colors.dart';
import '../resources/dimensions.dart';

class TitleText extends StatelessWidget {
  final String text;
  const TitleText(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Text(text,
      style: const TextStyle(
        color: HOME_SCREEN_LIST_TITLE_COLOR,
        fontWeight: FontWeight.bold,
        fontSize: TEXT_REGULAR,
      ),
    );
  }
}

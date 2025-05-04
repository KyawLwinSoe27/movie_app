import 'package:flutter/material.dart';

class SeeMoreText extends StatelessWidget {
  final String text;
  final Color textColor;
  const SeeMoreText(this.text, {Key? key, this.textColor = Colors.white}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: textColor,
          decoration: TextDecoration.underline,
          fontWeight: FontWeight.bold),
    );
  }
}

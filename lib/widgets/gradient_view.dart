import 'package:flutter/material.dart';
import '../resources/colors.dart';

class GradientView extends StatelessWidget {
  const GradientView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                HOME_SCREEN_BG_COLOR
              ]
          )
      ),
    );
  }
}
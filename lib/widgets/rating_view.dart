import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../resources/dimensions.dart';

class RatingView extends StatelessWidget {
  const RatingView({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
        initialRating: 3.0,
        itemBuilder: (BuildContext context, int index) => const Icon(
          Icons.star,
          color: Colors.amber,
          size: 4,
        ),
        itemSize: MARGIN_MEDIUM_2  ,
        onRatingUpdate: (rating) {
          print(rating);
        });
  }
}

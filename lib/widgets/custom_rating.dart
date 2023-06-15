import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomRating extends StatelessWidget {
  const CustomRating({
    Key? key,
    required this.ratingScore,
  }) : super(key: key);

  final double ratingScore;


  @override
  Widget build(BuildContext context) {
    const size = 15.0;
    return Row(
      children: [
        for (int i = 1; i <= 5; i++)
          Container(
            margin: const EdgeInsets.all(1),
            height: size,
            width: size,
            decoration: BoxDecoration(
              color: i <= ratingScore ? Colors.yellow : Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.yellow, width: 2),
            ),
          ),
        Gap(12),
        Text(
          '${ratingScore > 5 ? 5.0 : ratingScore}',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

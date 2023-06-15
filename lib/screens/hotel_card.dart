import 'package:booktickets/widgets/custom_rating.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../utils/app_layout.dart';
import '../utils/app_styles.dart';

class HotelCard extends StatelessWidget {
  final Map <String,dynamic> hotel;
  const HotelCard({Key? key, required this.hotel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0),
              ),
              child: Image.asset(
                "assets/images/${hotel['image']}",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hotel['place'],
                    style: Styles.headLineStyle2.copyWith(color: Styles.textColor,fontSize: 18),
                  ),

                  Row(
                    children: [
                      Text(
                        hotel['destination'],
                        style: Styles.headLineStyle3.copyWith(color: Colors.white,fontSize: 16),
                      ),
                      Gap(5),
                      Icon(Icons.location_on_outlined),
                    ],
                  ),
                  Gap(15),
                  CustomRating(ratingScore: hotel["rating"]),
                  Gap(15),
                  Text(
                    '\$${hotel['price']}/night',
                    style: Styles.headLineStyle1.copyWith(color: Styles.textColor,fontSize: 18),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

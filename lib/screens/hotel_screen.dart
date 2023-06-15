import 'package:booktickets/utils/app_layout.dart';
import 'package:booktickets/utils/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HotelScren extends StatelessWidget {
  final Map <String,dynamic> hotel;
  const HotelScren({Key? key, required this.hotel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 17),
      margin: const EdgeInsets.only(top: 5,right: 17),
      width: size.width * 0.9,
      height: 250,
      decoration: BoxDecoration(
        color: Color(0xff76b5c5),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 20,
            spreadRadius: 5
          )
        ]
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: 200,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Styles.bgColor,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  "assets/images/${hotel['image']}"
                )
              )
            ),
          ),
          const Gap(15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                hotel['place'],
                style: Styles.headLineStyle2.copyWith(color: Styles.kakicolor,fontSize: 18),
              ),
              const Gap(5),
              Text(
                hotel['destination'],
                style: Styles.headLineStyle3.copyWith(color: Colors.white,fontSize: 16),
              ),
              const Gap(8),
              Text(
                '\$${hotel['price']}/night',
                style: Styles.headLineStyle1.copyWith(color: Styles.kakicolor,fontSize: 15),
              )
            ],
          ),
        ],
      ),
    );
  }
}

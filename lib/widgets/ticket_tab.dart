import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/app_layout.dart';

class AppTicketTabs extends StatelessWidget {
  final String firstTable;
  final String secondTable;
  const AppTicketTabs({Key? key,required this.firstTable,required this.secondTable}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return FittedBox(
      child: Container(
        padding: const EdgeInsets.all(3.5),
        child: Row(
          children: [
            //Airline Tickets
            Container(
                child: Center(child:Text(firstTable)),
                padding: EdgeInsets.symmetric(vertical: AppLayout.getHeight(7)),
                width: size.width*.44,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.horizontal(left: Radius.circular(AppLayout.getHeight(50))),
                    color: Colors.white
                )
            ),
            //Hotel Tickets
            Container(
                child: Center(child:Text(secondTable)),
                padding: EdgeInsets.symmetric(vertical: AppLayout.getHeight(7)),
                width: size.width*.44,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.horizontal(right: Radius.circular(AppLayout.getHeight(50))),
                    color: Colors.transparent
                )
            ),
          ],
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppLayout.getHeight(50)),
            color: const Color(0xFFF4F6FD)
        ),
      ),
    );
  }
}

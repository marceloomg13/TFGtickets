import 'package:booktickets/utils/app_info_list.dart';
import 'package:booktickets/utils/app_layout.dart';
import 'package:booktickets/utils/app_styles.dart';
import 'package:booktickets/widgets/layout_builder_widget.dart';
import 'package:booktickets/widgets/thick_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class TicketView extends StatelessWidget {
  final Map <String,dynamic> ticket;
  final bool? isColor;
  const TicketView({Key? key,required this.ticket, this.isColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return SizedBox(
      width: size.width*0.85,
      height: AppLayout.getHeight(GetPlatform.isAndroid==true?167:169),
      child: Container(
        margin: EdgeInsets.only(right: AppLayout.getHeight(16)),
        child: Column(
          children: [
            /*
            * Parte anaranjada del Ticket
            * */
            Container(
              decoration: BoxDecoration(
                color: isColor==null? Color(0xffeab676):Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(AppLayout.getHeight(21)),
                topRight: Radius.circular(AppLayout.getHeight(21)))
              ),
              padding: EdgeInsets.all(AppLayout.getHeight(16)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(ticket['from']['code'],
                        style: isColor==null? Styles.headLineStyle3.copyWith(color: Colors.white):Styles.headLineStyle3,),
                      Expanded(child: Container()),
                      ThickContainer(isColor:this.isColor),
                      Expanded(child: Stack(
                        children: [
                          SizedBox(
                          height: AppLayout.getHeight(24),
                          child: AppLayoutBuilderWidget(sections: 6),
                        ),
                          Center(child: Transform.rotate(angle: 1.5,child: Icon(Icons.local_airport_rounded, color: isColor==null? Colors.white:Color(0xFF8ACCF7)))),
                        ],
                      )),
                      ThickContainer(isColor:this.isColor),
                      Expanded(child: Container()),
                      Text(ticket['to']['code'], style: isColor==null? Styles.headLineStyle3.copyWith(color: Colors.white):Styles.headLineStyle3)
                    ],
                  ),
                  Gap(3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: AppLayout.getWidht(100),child: Text(ticket['from']['name'], style: isColor==null? Styles.headLineStyle4.copyWith(color: Colors.white):Styles.headLineStyle4,),
                      ),
                      Text(ticket['flying_time'], style: isColor==null? Styles.headLineStyle4.copyWith(color: Colors.white):Styles.headLineStyle4,),
                      SizedBox(
                        width: AppLayout.getWidht(100),child: Text(ticket['to']['name'],textAlign: TextAlign.end, style: isColor==null? Styles.headLineStyle4.copyWith(color: Colors.white):Styles.headLineStyle4,),
                      ),
                    ],
                  )
                ],
              ),
            ),
            /*
            * Parte azul del Ticket
            * */
            Container(
              color: isColor==null? Color(0xff76b5c5):Colors.white,
              child: Row(
                children: [
                  SizedBox(
                    height: AppLayout.getHeight(20),
                    width: AppLayout.getWidht(10),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: isColor==null? Styles.bgColor:Colors.white,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10)
                        )
                      ),
                    ),
                  ),
                  Expanded(child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: AppLayoutBuilderWidget(sections: 15),
                  )
                  ),
                  SizedBox(
                    height: 20,
                    width: 10,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: isColor==null? Styles.bgColor:Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(AppLayout.getHeight(10)),
                              bottomLeft: Radius.circular(AppLayout.getHeight(10))
                          )
                      ),
                    ),
                  )
                ],
              )),
              /**
               * Parte azul Bottom
               */
            Container(
              decoration: BoxDecoration(
                  color:isColor==null? Color(0xff76b5c5):Colors.white,
                  borderRadius:  BorderRadius.only(
                      bottomLeft: Radius.circular(isColor==null? AppLayout.getHeight(21):0),
                      bottomRight: Radius.circular(isColor==null? AppLayout.getHeight(21):0))
              ),
              padding: const EdgeInsets.only(left: 16,right: 16,bottom: 16,top: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(ticket["date"], style:isColor==null? Styles.headLineStyle3.copyWith(color: Colors.white):Styles.headLineStyle3),
                          const Gap(5),
                          Text("Date",style: isColor==null? Styles.headLineStyle4.copyWith(color: Colors.white):Styles.headLineStyle4)
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(ticket["departure_time"], style: isColor==null? Styles.headLineStyle3.copyWith(color: Colors.white):Styles.headLineStyle3,),
                          const Gap(5),
                          Text("departure_time",style: isColor==null? Styles.headLineStyle4.copyWith(color: Colors.white):Styles.headLineStyle4)
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(ticket["number"].toString() , style: isColor==null? Styles.headLineStyle3.copyWith(color: Colors.white):Styles.headLineStyle3,),
                          const Gap(5),
                          Text("number",style: isColor==null? Styles.headLineStyle4.copyWith(color: Colors.white):Styles.headLineStyle4)
                        ],
                      )
                    ],
                  )
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}

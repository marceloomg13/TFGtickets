import 'dart:async';

import 'package:booktickets/utils/app_layout.dart';
import 'package:booktickets/widgets/icon_text_widget.dart';
import 'package:booktickets/widgets/ticket_tab.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'dart:developer' as developer;
import '../utils/app_info_list.dart';
import '../utils/app_styles.dart';
import '../widgets/double_text_widget.dart';
import '../widgets/my_textfield.dart';
import 'flight_picker.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);



  void findQuery(TextEditingController toController, TextEditingController fromController,context) async {
    var db = FirebaseFirestore.instance;
    int ticketIDNumber = 0;
    for(var i = 0;i<=ticketList.length-1;i++){
      print(ticketList[i]);
    }
    db.collection("Vuelos").where("to.name", isEqualTo: toController.text).where("from.name", isEqualTo: fromController.text).get().then(
          (querySnapshot) {
        print("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          print('${docSnapshot.id} => ${docSnapshot.data()}');
          Map<String, dynamic> data = docSnapshot.data();
          for(var i = 0;i<=ticketList.length-1;i++){
            print("${data['number']}     ${ticketList[i]['number']}");
            if(data['number'].toString() == ticketList[i]['number'].toString()){

              ticketIDNumber = i;
              print("TRUE" + "  "+ticketIDNumber.toString());

              showCupertinoModalPopup(context: context, builder:
                  (context) => flightPicker(ticketID: ticketIDNumber));
            }else{
              print("false");
            }
          }
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
  }


  
  @override
  Widget build(BuildContext context) {
    final fromController = TextEditingController();
    final toController = TextEditingController();
    final size = AppLayout.getSize(context);
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: AppLayout.getWidht(20),vertical: AppLayout.getHeight(20)),
        children: [
          Gap(AppLayout.getHeight(40)),
          Text("What are\nyou looking for", style: Styles.headLineStyle1.copyWith(fontSize: 35)),
          Gap(AppLayout.getHeight(20)),
          const AppTicketTabs(firstTable: "Airline Tickets",secondTable: "Hotels"),
          Gap(AppLayout.getHeight(25)),
          TextField(
            controller: fromController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.flight_takeoff_rounded),
              enabledBorder: OutlineInputBorder(
                borderSide:
                BorderSide(color: Colors.white), //<-- SEE HERE
                borderRadius: BorderRadius.circular(20.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(20.0),
              ),
                fillColor: Colors.white,
                filled: true,
                hintText: "Departure",
                hintStyle: TextStyle(color: Colors.grey[500])

            ),
          ),
          Gap(AppLayout.getHeight(20)),
          TextField(
            controller: toController,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.flight_land_rounded),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.white), //<-- SEE HERE
                  borderRadius: BorderRadius.circular(20.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                fillColor: Colors.white,
                filled: true,
                hintText: "Arrival",
                hintStyle: TextStyle(color: Colors.grey[500])

            ),
          ),
          Gap(AppLayout.getHeight(25)),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: AppLayout.getHeight(18),
                horizontal: AppLayout.getWidht(15)),
            decoration: BoxDecoration(
                color: Color(0xff76b5c5),
                borderRadius: BorderRadius.circular(AppLayout.getWidht(10))
            ),
            child: InkWell(
              onTap: ()=> findQuery(toController,fromController,context),
              child: Center(
                  child: Text("find tickets",style: Styles.textStyle.copyWith(color: Colors.white),)
              ),
            ),
          ),
          Gap(AppLayout.getHeight(40)),
          const AppDoubleTextWidget(bigText: "Upcoming Flights",smallText: "view all",),
          Gap(AppLayout.getHeight(15)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             Container(
               height: AppLayout.getHeight(425),
               width: size.width*0.42,
               padding: EdgeInsets.symmetric(horizontal: AppLayout.getHeight(15),vertical: AppLayout.getWidht(15)),
               decoration: BoxDecoration(
                 boxShadow: [
                   BoxShadow(
                     color: Colors.grey.shade200,
                     blurRadius: 1,
                     spreadRadius: 1
                   )
                 ],
                 color: Colors.white,
                 borderRadius: BorderRadius.circular(AppLayout.getHeight(20))
               ),
               child: Column(
                 children: [
                   Container(
                     height: AppLayout.getHeight(190),
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(AppLayout.getHeight(12)),
                       image: const DecorationImage(
                         fit: BoxFit.cover,
                         image: AssetImage(
                           "assets/images/sit.jpg"
                         )
                       )
                     ),
                   ),
                   Gap(AppLayout.getHeight(12)),
                   Text("20% discount on the early booking of this fly. Don't miss out this chance"
                   ,style: Styles.headLineStyle2,
                   )
                 ],
               ),
             ),
             Column(
               children: [
                 Stack(
                   children: [
                     Container(
                       width: size.width*0.44,
                       height: AppLayout.getHeight(200),
                       decoration: BoxDecoration(
                           color: Color(0xFF3AB8B8),
                           borderRadius: BorderRadius.circular(AppLayout.getHeight(18))
                       ),
                       padding: EdgeInsets.symmetric(vertical:AppLayout.getHeight(15),horizontal:AppLayout.getHeight(15)),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text("Discount\n for survey", style: Styles.headLineStyle2.copyWith(fontWeight: FontWeight.bold,color: Colors.white),),
                           Gap(AppLayout.getHeight(10)),
                           Text("Take the survey about our services and get discount", style: Styles.headLineStyle2.copyWith(fontWeight: FontWeight.w500,color: Colors.white,fontSize: 18),)
                         ],
                       ),
                     ),
                     Positioned(
                         right: -45,
                         top: -40,
                         child: Container(
                       padding: EdgeInsets.all(AppLayout.getHeight(30)),
                       decoration: BoxDecoration(
                           shape: BoxShape.circle,
                           border: Border.all(width: 18,color: Color(0xFF189999)),
                           color: Colors.transparent
                       ),
                     )
                     )
                   ],
                 ),
                 Gap(AppLayout.getHeight(15)),
                 Container(
                   width: size.width*0.44,
                   height: AppLayout.getHeight(210),
                   padding: EdgeInsets.symmetric(vertical: AppLayout.getHeight(15),horizontal: AppLayout.getHeight(10)),
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(AppLayout.getHeight(18)),
                     color: const Color(0xFFEC6545)
                   ),
                   child: Column(
                     children: [
                       Text("Take love",style: Styles.headLineStyle2.copyWith(color: Colors.white,fontWeight: FontWeight.bold),textAlign: TextAlign.center),
                       Gap(AppLayout.getHeight(5)),
                       RichText(text: const TextSpan(
                         children: [
                           TextSpan(
                             text: '🥰',
                             style: TextStyle(fontSize:35)
                           ),
                           TextSpan(
                             text: '😍',
                               style: TextStyle(fontSize:50)
                           ),
                           TextSpan(
                               text: '😘',
                               style: TextStyle(fontSize:35)
                           )
                         ]
                       ))
                     ],
                   ),
                 )
               ],
             )
           ],
          )
        ],
      ),
    );
  }
}

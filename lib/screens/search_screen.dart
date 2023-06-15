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
import '../widgets/custom_rating.dart';
import '../widgets/double_text_widget.dart';
import '../widgets/my_textfield.dart';
import 'flight_picker.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);



  void findQuery(TextEditingController toController, TextEditingController fromController,context) async {
    temporalTickets.clear();
    var db = FirebaseFirestore.instance;
    var ticketIDNumber =[];
    db.collection("Vuelos").
    where("to.name", isEqualTo: toController.text).
    where("from.name", isEqualTo: fromController.text).get().then(
          (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          Map<String, dynamic> data = docSnapshot.data();
          for(var i = 0;i<=ticketList.length-1;i++){
            if(data['number'].toString() == ticketList[i]['number'].toString()){
              ticketIDNumber.add(i);
            }else{
              print("false");
            }
          }
        }
        for(var i in ticketIDNumber) {
          temporalTickets.add(ticketList[i]);
        }
        showCupertinoModalPopup(context: context, builder:
            (context) => flightPicker(ticketID: ticketIDNumber));
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
          const AppDoubleTextWidget(bigText: "Hotel reviews",smallText: "view all",),
          Gap(AppLayout.getHeight(15)),
          /////////////////////////////
          SingleChildScrollView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: hotelList.map((singleHotel) => HotelReview(hotel: singleHotel)).toList(),
              )
          )
        ],
      ),
    );
  }
}

class HotelReview extends StatelessWidget {
  final Map <String,dynamic> hotel;
  const HotelReview({Key? key, required this.hotel}) : super(key: key);

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
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  Gap(10),
                  Text(
                    hotel['reviews'][0].toString(),
                    style: Styles.headLineStyle3.copyWith(color: Colors.white,fontSize: 12),
                  ),
                  Gap(50),
                  CustomRating(ratingScore: hotel["rating"]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


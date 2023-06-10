import 'dart:ui';

import 'package:booktickets/screens/hotel_screen.dart';
import 'package:booktickets/screens/ticket_view.dart';
import 'package:booktickets/utils/app_styles.dart';
import 'package:booktickets/widgets/double_text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gap/gap.dart';

import '../utils/app_info_list.dart';
import 'flight_picker.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);


  void findQuery(TextEditingController searchController,context) async{
    var db = FirebaseFirestore.instance;
    int ticketIDNumber = 0;
    db.collection("MisVuelos").where('to.name', isEqualTo: searchController.text).get().then(
          (querySnapshot) {
            print("Successfully completed");
            print(querySnapshot.size);
            if (querySnapshot.size == 0) {
              db.collection("MisVuelos").where('to.name', isEqualTo: searchController.text).get().then(
                      (querySnapshot2) {
                        for (var docSnapshot in querySnapshot2.docs) {
                          print('${docSnapshot.id} => ${docSnapshot.data()}');
                          Map<String, dynamic> data = docSnapshot.data();
                          for (var i = 0; i <= ticketList.length - 1; i++) {
                            print("${data['number']}------${ticketList[i]['number']}");
                            if (data['number'].toString() ==
                                ticketList[i]['number'].toString()) {
                              ticketIDNumber = i;
                              print("TRUE" + "  " + ticketIDNumber.toString());

                              showCupertinoModalPopup(context: context, builder:
                                  (context) => flightViewer(ticketID: ticketIDNumber));
                            } else {
                              print("false");
                            }
                          }
                        }
                  }
              );
            } else {
              for (var docSnapshot in querySnapshot.docs) {
                print('${docSnapshot.id} => ${docSnapshot.data()}');
                Map<String, dynamic> data = docSnapshot.data();
                for (var i = 0; i <= ticketList.length - 1; i++) {
                  print("${data['number']}     ${ticketList[i]['number']}");
                  if (data['number'].toString() ==
                      ticketList[i]['number'].toString()) {
                    ticketIDNumber = i;
                    print("TRUE" + "  " + ticketIDNumber.toString());

                    showCupertinoModalPopup(context: context, builder:
                        (context) => flightViewer(ticketID: ticketIDNumber));
                  } else {
                    print("false");
                  }
                }
              }
            }
          },
      onError: (e) => print("Error completing: $e"),
    );
  }

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();
    return Scaffold(

      backgroundColor: const Color(0xFFeeedf2),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(right: 20,left: 20),
            child: Column(
              children: [
                const Gap(40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Good morning",style: Styles.headLineStyle4),
                        const Gap(5),
                        Text("Book tickets", style: Styles.headLineStyle1,)
                      ],
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color:  const Color(0xFFeeedf2),
                        borderRadius: BorderRadius.circular(25),
                        image: const DecorationImage(
                          fit: BoxFit.fitHeight,
                          image: AssetImage("assets/images/flight_icon.png")
                        )
                      ),
                    )
                  ],
                ),
                const Gap(25),
                Row(
                  children: [Flexible(
                    child: TextField(
                        controller: searchController,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white), //<-- SEE HERE
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "Search Flights",
                              hintStyle: TextStyle(color: Colors.grey[500])

                          )
                      ),
                  ),
                    ElevatedButton(
                      onPressed: () => findQuery(searchController,context),
                      child: Icon(Icons.search),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(CircleBorder()),
                        padding: MaterialStateProperty.all(EdgeInsets.all(15)),
                        backgroundColor: MaterialStateProperty.all(Color(0xFF8ACCF7)), // <-- Button color
                        overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                          if (states.contains(MaterialState.pressed)) return  Color(0xffeab676); // <-- Splash color
                        }),
                      ),
                    )
                  ],
                ),

                const Gap(40),
                AppDoubleTextWidget(bigText: "Upcoming Flights", smallText: "view all")
              ],
            ),
          ),
          const Gap(15),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20),
            child: Container(
              height: 200,
              child: Row(
                  children: myTickets.map((singleTicket) => TicketView(ticket: singleTicket)).toList(),
              ),
            )
          ),
          const Gap(15),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: AppDoubleTextWidget(bigText: "Hotels",smallText: "view all",),
          ),
          Gap(15),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: hotelList.map((singleHotel) => HotelScren(hotel: singleHotel)).toList(),
              )
          )
        ],
      ),
    );
  }
}

class flightViewer extends StatelessWidget {
  final int ticketID;
  const flightViewer({Key? key,required this.ticketID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.transparent,
      body:
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: TicketView(ticket: ticketList[ticketID]),
            ),
          ],
        ),


      ),
    );
  }
}



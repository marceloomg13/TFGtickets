import 'dart:ui';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:booktickets/screens/hotel_screen.dart';
import 'package:booktickets/screens/splash.dart';
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

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  void findQuery(TextEditingController searchController,context) async{
    temporalTickets.clear();
    var db = FirebaseFirestore.instance;
    var ticketIDNumber = [];
    var querySize = 0;
    db.collection("MisVuelos").where('to.name', isEqualTo: searchController.text).get().then(
          (querySnapshot) {
            print("query1");
            print(querySnapshot.size);
            querySize = querySnapshot.size;
              for (var docSnapshot in querySnapshot.docs) {
                print('${docSnapshot.id} => ${docSnapshot.data()}');
                Map<String, dynamic> data = docSnapshot.data();
                for (var i = 0; i <= ticketList.length - 1; i++) {
                  print("${data['number']}     ${ticketList[i]['number']}");
                  if (data['number'].toString() == ticketList[i]['number'].toString()) {
                    ticketIDNumber.add(i);
                    print("TRUE" + "  " + ticketIDNumber.toString());
                  } else {
                    print("false");
                  }
                }
              }

            for(var i in ticketIDNumber) {
              temporalTickets.add(ticketList[i]);
              print(temporalTickets.toString());
              print("snap");
            }
            print(ticketIDNumber);
          },
      onError: (e) => print("Error completing: $e"),
    );
    if (querySize == 0) {
      db.collection("MisVuelos").where('from.name', isEqualTo: searchController.text).get().then(
              (querySnapshot2) {
                print(querySnapshot2.size);
            for (var docSnapshot in querySnapshot2.docs) {
              print('${docSnapshot.id} => ${docSnapshot.data()}');
              Map<String, dynamic> data = docSnapshot.data();
              for (var i = 0; i <= ticketList.length - 1; i++) {
                print("${data['number']}------${ticketList[i]['number']}");
                if (data['number'].toString() ==
                    ticketList[i]['number'].toString()) {
                  ticketIDNumber.add(i);
                  print("TRUE" + "  " + ticketIDNumber.toString());
                } else {
                  print("false");
                }
              }
            }
            for(var i in ticketIDNumber) {
              temporalTickets.add(ticketList[i]);
              print(temporalTickets.toString());
              print("snap2");
            }
          }
      );
    }
    showCupertinoModalPopup(context: context, builder:
        (context) => AnimatedSplashScreen(
            splash: SplashBlur(),
            splashIconSize: double.infinity,
            duration: 1500,
            splashTransition: SplashTransition.fadeTransition,
            nextScreen: flightViewer()));
  }


  void viewAll(BuildContext context){
    showCupertinoModalPopup(context: context, builder:
        (context) => flightViewer());
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Upcoming Flights", style: Styles.headLineStyle2),
                    InkWell(
                        onTap: () => viewAll(context),
                        child: Text("view all",style: Styles.textStyle.copyWith(color: Styles.primaryColor)))
                  ],
                )
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
  const flightViewer({Key? key}) : super(key: key);

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
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: temporalTickets.map((singleTicket) => TicketView(ticket: singleTicket)).toList(),
                ),
              ),
            ),
      ),
    );
  }
}
class SplashBlur extends StatelessWidget {
  const SplashBlur({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: double.infinity,
          height:  double.infinity,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
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
                ),
                Gap(5),
                Text("BookTickets",style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),),
                Gap(5),
                Text("App development",style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}




import 'dart:ui';
import 'package:booktickets/screens/ticket_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../utils/app_info_list.dart';

class flightPicker extends StatelessWidget {
  final int ticketID;
  const flightPicker({Key? key,required this.ticketID}) : super(key: key);

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
                    child: GestureDetector(
                        onTap: () =>{
                          myTickets.add(ticketList[ticketID]),
                          print("selected" + ticketList[ticketID].toString())
                        },
                        child: TicketView(ticket: ticketList[ticketID])),
                  ),
                ],
              ),


      ),
    );
  }
}

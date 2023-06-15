import 'dart:ui';
import 'package:booktickets/screens/ticket_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../utils/app_info_list.dart';

class flightPicker extends StatelessWidget {
  final List<dynamic> ticketID;
  const flightPicker({Key? key,required this.ticketID}) : super(key: key);

  Future<void> update(context) async{
    for(var i in ticketID) {
      final myTicketID = ticketList[i]['number'];
      FirebaseFirestore.instance.collection("MisVuelos").doc(myTicketID.toString()).set(ticketList[i]);
    }
    Navigator.pop(context, 'Yes');

    final MisVuelos = FirebaseFirestore.instance.collection("MisVuelos");
    
    MisVuelos.get().then((querySnapshot){
      for (var docSnapshot in querySnapshot.docs) {
        var fromCode;
        var fromName;
        var toCode;
        var toName;
        var flyingTime;
        var date;
        var departureTime;
        var number;

        Map<String, dynamic> data = docSnapshot.data();
        Map<dynamic,dynamic> toData = data['to'];
        Map<dynamic,dynamic> fromData = data['from'];
        toCode = toData["code"].toString();
        toName = toData["name"].toString();
        fromCode = fromData["code"].toString();
        fromName = fromData["name"].toString();
        flyingTime = data["flying_time"].toString();
        date = data["date"].toString();
        departureTime = data["departure_time"].toString();
        number = data["number"];
        bool repetido=false;
        var billete = {
          'from': {
            'code':fromCode,
            'name':fromName
          },
          'to': {
            'code':toCode,
            'name':toName
          },
          'flying_time': flyingTime,
          'date': date,
          'departure_time':departureTime,
          "number":number
        };
        myTickets.forEach((element) {
          if(element["number"] == billete["number"]){
            repetido = true;
          }
        });
        if(repetido == false){
          myTickets.add(billete);
        }
      }
    });
  }

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
                     child:
                      GestureDetector(
                        onTap: () =>showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Confirm'),
                            content: const Text('Are you sure you want to buy this flight?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'Cancel'),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () => update(context),
                                child: const Text('Yes'),
                              ),
                            ],
                          ),
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: temporalTickets.map((singleTicket) => TicketView(ticket: singleTicket)).toList(),
                            ),
                          ),
                        ),
                      ),
                  ),
                ],
              ),


      ),
    );
  }
}


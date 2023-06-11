import 'package:booktickets/screens/auth_page.dart';
import 'package:booktickets/utils/app_info_list.dart';
import 'package:booktickets/utils/app_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
   const MyApp({super.key});


  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  initializeData() async{
    /*
    myTickets.clear();
    FirebaseFirestore.instance.collection("MisVuelos").get().then((snapshot) => {
      for (DocumentSnapshot ds in snapshot.docs){
        ds.reference.delete(),
      }});

     */
    for(var element in hotelList){
      FirebaseFirestore.instance.collection("Hoteles").doc(element['id'].toString()).set(element);
    }
    for(var element in ticketList){
      FirebaseFirestore.instance.collection("Vuelos").doc(element['number'].toString()).set(element);
    }
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
        print(billete);
        myTickets.add(billete);
      }
      FirebaseFirestore.instance.terminate();
      print(myTickets);
    });
  }
  @override
  void initState() {
    super.initState();
    initializeData();
  }


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
    );
  }
}


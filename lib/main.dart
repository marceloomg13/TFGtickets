import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:booktickets/screens/auth_page.dart';
import 'package:booktickets/screens/splash.dart';
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
    var db = FirebaseFirestore.instance;
    var vuelo = {
      'from': {
        'code':"MD",
        'name':"Madrid"
      },
      'to': {
        'code':"BC",
        'name':"Barcelona"
      },
      'flying_time': "45M",
      'date': "26 MAY",
      'departure_time':"12:00 AM",
      "number":13
    };
    db.collection("Vuelos").doc("13").set(vuelo);

    queryHotels();
    queryTickets("MisVuelos");
    queryTickets("Vuelos");
  }

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  void queryTickets(String collection){
    final collectionQuery = FirebaseFirestore.instance.collection(collection);

    collectionQuery.get().then((querySnapshot){
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
        if(collection == 'MisVuelos'){
        myTickets.add(billete);
        }
        if(collection == 'Vuelos'){
          ticketList.add(billete);
        }
      }
    });
  }

  void queryHotels(){
    final collectionQuery = FirebaseFirestore.instance.collection("Hoteles");

    collectionQuery.get().then((querySnapshot){
      for (var docSnapshot in querySnapshot.docs) {
        var destination;
        var id;
        var image;
        var place;
        var price;
        var rating;
        var reviews;

        Map<String, dynamic> data = docSnapshot.data();
        destination = data["destination"].toString();
        id = data["id"].toString();
        image = data["image"].toString();
        place = data["place"].toString();
        price = data["price"];
        rating = data["rating"];
        reviews = data["reviews"];

        var Hotel = {
          'id':id,
          'image': image,
          'place': place,
          'destination': destination,
          'price': price,
          'rating' : rating,
          'reviews' : reviews
        };
        hotelList.add(Hotel);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
          splash: Splash(),
          splashIconSize: double.infinity,
          duration: 1500,
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: const Color(0xFF8ACCF7),
          nextScreen: AuthPage())
    );
  }
}


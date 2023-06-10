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
    for(var element in hotelList){
      FirebaseFirestore.instance.collection("Hoteles").doc(element['id'].toString()).set(element);
    }
    for(var element in ticketList){
      FirebaseFirestore.instance.collection("Vuelos").doc(element['number'].toString()).set(element);
    }
    print("All data added");
  }
  @override
  void initState() {
    super.initState();
    myTickets.clear();
    FirebaseFirestore.instance.collection("MisVuelos").get().then((snapshot) => {
    for (DocumentSnapshot ds in snapshot.docs){
        ds.reference.delete(),
    }});

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


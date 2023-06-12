import 'package:booktickets/screens/auth_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.infinity,
          height:  double.infinity,
          color: Color(0xFF8ACCF7),
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
    );
  }
}

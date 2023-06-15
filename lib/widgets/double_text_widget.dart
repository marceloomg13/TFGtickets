import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/app_styles.dart';

class AppDoubleTextWidget extends StatelessWidget {
  final String bigText;
  final String smallText;
  const AppDoubleTextWidget({Key? key,required this.bigText, required this.smallText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(bigText, style: Styles.headLineStyle2),
          InkWell(
              onTap: (){
              },
              child: Text(smallText,style: Styles.textStyle.copyWith(color: Styles.primaryColor)))
        ],
      ),
    );
  }
}

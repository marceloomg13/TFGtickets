import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';
import '../utils/app_layout.dart';
import '../utils/app_styles.dart';

class AppColumnLayout extends StatelessWidget {
  final CrossAxisAlignment aligment;
  final String firstText;
  final String secondText;
  const AppColumnLayout({Key? key, required this.firstText,required this.secondText,required this.aligment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: aligment,
        children: [
        Text(firstText, style: Styles.headLineStyle3),
        Gap(AppLayout.getHeight(5)),
        Text(secondText, style: Styles.headLineStyle4),
    ]
    );
  }
}

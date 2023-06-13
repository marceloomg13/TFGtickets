import 'package:booktickets/screens/ticket_view.dart';
import 'package:booktickets/utils/app_layout.dart';
import 'package:booktickets/utils/app_styles.dart';
import 'package:booktickets/widgets/Column_layout.dart';
import 'package:booktickets/widgets/ticket_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:barcode_widget/barcode_widget.dart';
import '../utils/app_info_list.dart';
import '../widgets/layout_builder_widget.dart';

class TicketScreen extends StatelessWidget {
  const TicketScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: Stack(children:
      [
        ListView(
          padding: EdgeInsets.symmetric(horizontal: AppLayout.getWidht(20),vertical: AppLayout.getHeight(20)),
          children: [
              Gap(AppLayout.getHeight(40)),
              Text("Tickets",style: Styles.headLineStyle1),
              Gap(AppLayout.getHeight(20)),
              const AppTicketTabs(firstTable: "Upcoming",secondTable: "Previous",),
              Gap(AppLayout.getHeight(20)),
              Container(
                padding: EdgeInsets.only(left: AppLayout.getHeight(15)),
                child: TicketView(ticket: myTickets.last,isColor: true),
              ),
              SizedBox(
                height: 1
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: AppLayout.getWidht(15),vertical: AppLayout.getWidht(15)),
                margin: EdgeInsets.only(right: 16,left: 15),
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppColumnLayout(firstText: "Flutter DB",secondText: "passenger",aligment: CrossAxisAlignment.start),
                        AppColumnLayout(firstText: "5221 364869",secondText: "passport",aligment: CrossAxisAlignment.end,)
                      ],
                    ),
                    Gap(AppLayout.getHeight(20)),
                    const AppLayoutBuilderWidget(sections: 15,width: 5,),
                    Gap(AppLayout.getHeight(20)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppColumnLayout(firstText: "364738 28274478",secondText: "Number of E-ticket",aligment: CrossAxisAlignment.start),
                        AppColumnLayout(firstText: "B2SG28",secondText: "Booking code",aligment: CrossAxisAlignment.end,)
                      ],
                    ),
                    Gap(AppLayout.getHeight(20)),
                    const AppLayoutBuilderWidget(sections: 15,width: 5,),
                    Gap(AppLayout.getHeight(20)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Image.asset("assets/images/visa.png",scale: 11,),
                                Text(" *** 2467", style: Styles.headLineStyle3)
                              ],
                            ),
                            Gap(5),
                            Text("Payment method",style: Styles.headLineStyle4,)
                          ],
                        ),
                        AppColumnLayout(firstText: "\$249.99",secondText: "Price",aligment: CrossAxisAlignment.end),
                      ],
                    ),
                    SizedBox(
                        height: 1
                    ),
                  ],
                ),
              ),


            Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(AppLayout.getHeight(21)),
                      bottomLeft: Radius.circular(AppLayout.getHeight(21))
                  )
                ),
                margin: EdgeInsets.only(left: AppLayout.getWidht(15),right: AppLayout.getWidht(15)),
                padding: EdgeInsets.only(top: AppLayout.getHeight(15),bottom: AppLayout.getHeight(15)),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: AppLayout.getHeight(15)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppLayout.getHeight(15)),
                    child: BarcodeWidget(
                      barcode: Barcode.code128(),
                      data: "https://github.com/marceloomg13",
                      drawText: false,
                      color: Styles.textColor,
                      width: double.infinity,
                      height: 70,
                    ),
                  ),
                ),
              ),
            Gap(AppLayout.getHeight(15)),
            Container(
              padding: EdgeInsets.only(left: AppLayout.getHeight(15)),
              child: TicketView(ticket: ticketList[0]),
            ),
          ],
        ),
        Positioned(
          left: AppLayout.getHeight(25),
          top: AppLayout.getHeight(290),
          child: Container(
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Styles.textColor,width: 2)
            ),
            child: CircleAvatar(
              maxRadius: 4,
              backgroundColor: Styles.textColor,
            ),
          ),
        ),
        Positioned(
          right: AppLayout.getHeight(25),
          top: AppLayout.getHeight(290),
          child: Container(
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Styles.textColor,width: 2)
            ),
            child: CircleAvatar(
              maxRadius: 4,
              backgroundColor: Styles.textColor,
            ),
          ),
        )

      ]
      )
    );
  }
}

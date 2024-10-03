// ignore_for_file: camel_case_types, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gofunds/app_screen/passenger_details.dart';
import 'package:gofunds/app_screen/select_nonprofit.dart';
import 'package:gofunds/common/common_button.dart';
import 'package:provider/provider.dart';
import '../common/light_dark_mode.dart';
import 'add_fundraiser_photo_screen.dart';
import 'describe_fundraising.dart';
import 'fundraiser_details.dart';

  int select = -1;
  List listtiletitle = [
    'Fundraising for yourself'.tr,
    'Fundraising for someone else'.tr,
    'Fundraising for nonprofit or charity'.tr
  ];

List subtitle = [
  'Raise funds for personal goals and needs'.tr,
  'Help achieve their goals and overcome challenges'.tr,
  'Make a difference through your donation'.tr
];

class Create_Fundraiser extends StatefulWidget {
  const Create_Fundraiser({super.key});

  @override
  State<Create_Fundraiser> createState() => _Create_FundraiserState();
}

class _Create_FundraiserState extends State<Create_Fundraiser> {

  List containerindex = [];

  List imagelist = [
    'assets/yourselfa1.png',
    'assets/somonea2.png',
    'assets/nonprofita3.png'
  ];

  ColorNotifier notifier = ColorNotifier();
  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return Scaffold(
      backgroundColor: notifier.background,
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 70,
            width: MediaQuery.of(context).size.width,
            decoration:  BoxDecoration(
                color: notifier.background,
                borderRadius: const BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      select >= 0 ?
                      NextButton(containcolore: theamcolore, onPressed1: () {
                        select == 2 ? Navigator.push(context, MaterialPageRoute(builder: (context) => const Select_Nonprofit(),)) :  Navigator.push(context, MaterialPageRoute(builder: (context) => const Fundraiser_details(),));
                      },) :
                      NextButtonNon(onPressed1: () {},),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
      appBar: AppBar(
        backgroundColor:  notifier.background,
        elevation: 0,
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              Get.back();
              emapty = "";
              emapty1 = "";
              titlecontroller.clear();
              select = -1;
              fundamountcontroller.clear();
              pincode = "";
              storycontroller.clear();
              patentnamecontroller.clear();
              patientdiagnosiscontroller.clear();
              fundplancontroller.clear();
              finalimage = [];
              passengerimage = [];
              image = [];
              charityselect = -1;
            },
            child: Icon(Icons.arrow_back,color: notifier.textcolore)),
        title: Text('Create fundraiser'.tr,style: TextStyle(color: notifier.textcolore,fontFamily: "SofiaProBold",fontSize: 18)),
      ),
      body:  Padding(
        padding: const EdgeInsets.all(15),
        child: PopScope(
          onPopInvoked: (didPop) {
            emapty = "";
            emapty1 = "";
            titlecontroller.clear();
            select = -1;
            fundamountcontroller.clear();
            pincode = "";
            storycontroller.clear();
            patentnamecontroller.clear();
            patientdiagnosiscontroller.clear();
            fundplancontroller.clear();
            finalimage = [];
            passengerimage = [];
            image = [];
            charityselect = -1;
          },
          canPop: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Who are you fundraising for?'.tr,style: TextStyle(color: notifier.textcolore,fontSize: 20,fontFamily: "SofiaProBold"),),
              const SizedBox(height: 20,),
              ListView.separated(
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 15);
                  },
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          select = index;
                        });
                      },
                      child: Container(
                        height: 100,
                        width: Get.width,
                        decoration: BoxDecoration(
                          // color: notifier.containercolore,
                          border: Border.all(color: select == index ? theamcolore : Colors.grey.withOpacity(0.4),width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: ListTile(
                            leading: Image.asset("${imagelist[index]}"),
                            title: Text('${listtiletitle[index]}',style: TextStyle(color: notifier.textcolore,fontFamily: "SofiaProBold",fontSize: 16)),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top:  8.0),
                              child: Text('${subtitle[index]}',style: const TextStyle(color: Colors.grey,fontSize: 14)),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

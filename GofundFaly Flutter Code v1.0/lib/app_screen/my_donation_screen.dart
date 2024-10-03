// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, unused_field, prefer_final_fields

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gofunds/common/config.dart';
import 'package:gofunds/controller/login_controller.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common/common_button.dart';
import '../common/light_dark_mode.dart';
import '../demo_screen.dart';
import 'featured_details_screen.dart';

class My_Dontaion_Screen extends StatefulWidget {
  const My_Dontaion_Screen({super.key});

  @override
  State<My_Dontaion_Screen> createState() => _My_Dontaion_ScreenState();
}

class _My_Dontaion_ScreenState extends State<My_Dontaion_Screen> {


  MyDonationFundlistApiController donationFundlistApiController = Get.put(MyDonationFundlistApiController());


  @override
  void initState() {
    super.initState();
    datagetfunction();
  }

  var userdata;
  var currency1;
  var plateformfee;
  var walletevarable;

  datagetfunction() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var uid = preferences.getString("userLogin");
    var curr = currency1 = preferences.getString("currenci");
    var plate = plateformfee = preferences.getString("plateformfee");
    currency1 = jsonDecode(curr!);
    userdata = jsonDecode(uid!);
    plateformfee = jsonDecode(plate!);
    donationFundlistApiController.MyDonationnapi(uid: userdata['id']);


    var wall = preferences.getDouble("walleteeammount");
    walletevarable = jsonEncode(wall!);
    print("::::::::::::::::::hhhhhhhhhhhhhhhhhh::::::::----------------------- ${walletevarable}");

    print("******************:---  (${plateformfee})");
    setState(() {

    });
  }

  double _currentSliderValue = 20;
  ColorNotifier notifier = ColorNotifier();

  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return Scaffold(
      backgroundColor: notifier.background,
      appBar: AppBar(
        backgroundColor:  notifier.background,
        toolbarHeight: 40,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(
            color: notifier.textcolore,
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text('My donation'.tr,style: TextStyle(color: notifier.textcolore,fontFamily: "SofiaProBold",fontSize: 18)),
        ),
      ),
      body: GetBuilder<MyDonationFundlistApiController>(builder: (donationFundlistApiController) {
        return donationFundlistApiController.isLoading ? Center(child: CircularProgressIndicator(color: theamcolore)) : Padding(
          padding: const EdgeInsets.only(left: 15,right: 15),
          child: donationFundlistApiController.donationFundlistModel!.fundlist.isEmpty ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/nofundeimage.png"),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "No Funds Raised".tr,
                  style:  TextStyle(
                    color: notifier.textcolore,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Please Initiate Fund-Raising Activities".tr,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ) : SingleChildScrollView(
            child: Column(
              children: [
                ListView.separated(
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 0);
                    },
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: donationFundlistApiController.donationFundlistModel!.fundlist.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => details_screen(palteformfee: plateformfee,walletamount: walletevarable,id: donationFundlistApiController.donationFundlistModel!.fundlist[index].id,remainAmt: "${donationFundlistApiController.donationFundlistModel!.fundlist[index].remainAmt}",totalInvestment: donationFundlistApiController.donationFundlistModel!.fundlist[index].totalInvestment),));
                          },
                          child: Container(
                            width: Get.width,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.withOpacity(0.4)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey.withOpacity(0.4)),
                                        borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 130,
                                          width: 130,
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
                                              // image: DecorationImage(image: NetworkImage(Config.imagebaseurl + donationFundlistApiController.donationFundlistModel!.fundlist[index].patientPhoto[0]),fit: BoxFit.cover)
                                          ),
                                          child: ClipRRect(
                                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
                                            child: FadeInImage.assetNetwork(
                                              placeholder: "assets/gfimage.png",
                                              placeholderCacheWidth: 290,
                                              placeholderCacheHeight: 270,
                                              image:
                                              Config.baseurl + donationFundlistApiController.donationFundlistModel!.fundlist[index].fundPhotos[0],
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(donationFundlistApiController.donationFundlistModel!.fundlist[index].title,style: TextStyle(fontSize: 14,fontFamily: "SofiaProBold",color: notifier.textcolore),maxLines: 2,overflow: TextOverflow.ellipsis,),
                                                const SizedBox(height: 5,),
                                                Text(donationFundlistApiController.donationFundlistModel!.fundlist[index].fundDate.toString().split(" ").first,style: TextStyle(fontSize: 14,fontFamily: "SofiaProBold",color: notifier.textcolore),maxLines: 1,overflow: TextOverflow.ellipsis,),

                                                donationFundlistApiController.donationFundlistModel!.fundlist[index].remainAmt == 0 ? Container(
                                                  width: MediaQuery.of(context).size.width,
                                                  height: 8.0,
                                                  margin: const EdgeInsets.only(top: 15,bottom: 15),
                                                  decoration: BoxDecoration(
                                                    color: theamcolore,
                                                    borderRadius: BorderRadius.circular(5),
                                                  ),
                                                ) : MyWidgetSlider((donationFundlistApiController.donationFundlistModel!.fundlist[index].remainAmt + double.parse(donationFundlistApiController.donationFundlistModel!.fundlist[index].totalInvestment) ).toString(),donationFundlistApiController.donationFundlistModel!.fundlist[index].totalInvestment.toString()),

                                                Row(
                                                  children: [
                                                    Text('$currency1${double.parse(donationFundlistApiController.donationFundlistModel!.fundlist[index].totalInvestment).toStringAsFixed(2)}',style: TextStyle(fontSize: 14,color: theamcolore),maxLines: 1,overflow: TextOverflow.ellipsis,),
                                                     Flexible(child: Text('  Raised'.tr,style: TextStyle(fontSize: 14,color: notifier.textcolore),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                                                  ],
                                                ),
                                                const SizedBox(height: 5,),
                                                Row(
                                                  children: [
                                                    Text('$currency1${donationFundlistApiController.donationFundlistModel!.fundlist[index].fundAmt}',style: TextStyle(fontSize: 14,color: theamcolore),maxLines: 1,overflow: TextOverflow.ellipsis,),
                                                    Text(' Target'.tr,style: TextStyle(fontSize: 14,color: notifier.textcolore),maxLines: 1,overflow: TextOverflow.ellipsis,),
                                                    // const SizedBox(width: 10,),
                                                    // Text('\$9',style: TextStyle(fontSize: 12,color: theamcolore),maxLines: 1,overflow: TextOverflow.ellipsis,),
                                                    // const Flexible(child: Text(' days left',style: TextStyle(fontSize: 12,color: Colors.black),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      RichText(text: TextSpan(
                                          children: [
                                            TextSpan(text: 'You have donated'.tr,style: TextStyle(color: notifier.textcolore,fontFamily: "SofiaProBold")),
                                            TextSpan(text: ' $currency1${double.parse(donationFundlistApiController.donationFundlistModel!.fundlist[index].totalDonate).toStringAsFixed(2)}',style: TextStyle(color: theamcolore,fontFamily: "SofiaProBold")),
                                          ]
                                      )),
                                      const Spacer(),
                                      Container(
                                        height: 30,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: theamcolore),
                                            borderRadius: BorderRadius.circular(20)
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                          child: Center(child: Text('Donate Again'.tr,style: TextStyle(color: theamcolore,fontFamily: "SofiaProBold",fontSize: 12),)),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ],
            ),
          ),
        );
      },),
    );
  }
}

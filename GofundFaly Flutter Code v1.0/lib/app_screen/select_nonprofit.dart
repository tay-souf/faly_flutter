// ignore_for_file: camel_case_types, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gofunds/app_screen/passenger_details.dart';
import 'package:gofunds/common/config.dart';
import 'package:gofunds/controller/login_controller.dart';
import 'package:provider/provider.dart';
import '../common/common_button.dart';
import '../common/light_dark_mode.dart';
import 'add_fundraiser_photo_screen.dart';
import 'describe_fundraising.dart';
import 'fundraiser_details.dart';

int charityselect = -1;

class Select_Nonprofit extends StatefulWidget {
  const Select_Nonprofit({super.key});

  @override
  State<Select_Nonprofit> createState() => _Select_NonprofitState();
}

class _Select_NonprofitState extends State<Select_Nonprofit> {


  ColorNotifier notifier = ColorNotifier();

  charitylisttApiController charitycontroller = Get.put(charitylisttApiController());


  @override
  void initState() {
    charitycontroller.chartyselectApi(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return Scaffold(
      backgroundColor: notifier.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: notifier.background,
        iconTheme: IconThemeData(
          color: notifier.textcolore, //change your color here
        ),
        title: Text('Select a nonprofit'.tr,style: TextStyle(color: notifier.textcolore,fontSize: 20,fontFamily: "SofiaProBold"),),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 70,
            width: MediaQuery.of(context).size.width,
            decoration:  BoxDecoration(
                color: notifier.background,
                borderRadius: const BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10))
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      charityselect >= 0 ?
                      NextButton(containcolore: theamcolore, onPressed1: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const Fundraiser_details(),));
                         },)
                          :
                      NextButtonNon(onPressed1: () {},),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      body: GetBuilder<charitylisttApiController>(builder: (charitycontroller) {
        return charitycontroller.isLoading ? Center(child: CircularProgressIndicator(color: theamcolore,)) : Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: PopScope(
              onPopInvoked: (didPop) {
                emapty = "";
                emapty1 = "";
                titlecontroller.clear();
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
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20,),
                  ListView.separated(
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 10);
                      },
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: charitycontroller.charityyApi!.charitydata.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Transform.translate(
                          offset: const Offset(0, -20),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                charityselect = int.parse(charitycontroller.charityyApi!.charitydata[index].id);
                                print(":----------------  $charityselect");
                              });
                            },
                            child: Container(
                              height: 70,
                              width: Get.width,
                              decoration: BoxDecoration(
                                // color: notifier.containercolore,
                                border: Border.all(color: charityselect == int.parse(charitycontroller.charityyApi!.charitydata[index].id) ? theamcolore :  Colors.grey.withOpacity(0.4)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                child: ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image:  DecorationImage(image: NetworkImage(Config.baseurl + charitycontroller.charityyApi!.charitydata[index].charityImg),fit: BoxFit.fill)
                                    ),
                                  ),
                                  title: Text(charitycontroller.charityyApi!.charitydata[index].title,style:  TextStyle(fontSize: 15,fontFamily: "SofiaProBold",color: notifier.textcolore)),
                                  subtitle: Text(charitycontroller.charityyApi!.charitydata[index].tinNo,style: const TextStyle(color: Colors.grey,fontSize: 14)),
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
      },),
    );
  }
}

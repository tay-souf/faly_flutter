// ignore_for_file: camel_case_types, avoid_print, prefer_typing_uninitialized_variables, unnecessary_brace_in_string_interps

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gofunds/app_screen/passenger_details.dart';
import 'package:gofunds/app_screen/select_nonprofit.dart';
import 'package:gofunds/common/common_button.dart';
import 'package:gofunds/controller/login_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common/home_controoler.dart';
import '../common/light_dark_mode.dart';
import 'create_fundraiser.dart';
import 'describe_fundraising.dart';
import 'fundraiser_details.dart';


List<String> finalimage=[];

class Fundraiser_photo extends StatefulWidget {
  const Fundraiser_photo({super.key});

  @override
  State<Fundraiser_photo> createState() => _Fundraiser_photoState();
}

class _Fundraiser_photoState extends State<Fundraiser_photo> {

  FundRaiseApiController fundRaiseApiController = Get.put(FundRaiseApiController());

  @override
  void initState() {
    datagetfunction();
    super.initState();
  }
  HomeApiController homeApiController = Get.put(HomeApiController());

  var userdata;

  datagetfunction() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var uid = preferences.getString("userLogin");
    userdata = jsonDecode(uid!);

    print('+ + + + + + + + ${userdata['id']}');

  }


  ImagePicker picker1 = ImagePicker();

  Future camera() async {
    XFile? file = await picker1.pickImage(source: ImageSource.camera);
    if(file!=null){
      setState(() {
        finalimage.add(file.path);
      });
    } else{
      Fluttertoast.showToast(msg: 'image pick in not Camera!!'.tr);
    }
  }

  Future gallery() async {
    XFile? file = await picker1.pickImage(source: ImageSource.gallery);
    if(file!=null){
      setState(() {
        finalimage.add(file.path);
      });
    }else{
      Fluttertoast.showToast(msg: 'image not selected!!'.tr);
    }
  }

  HomeController homeController = Get.put(HomeController());

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
            decoration: BoxDecoration(
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
                      (finalimage.isNotEmpty) ?
                      Expanded(
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: theamcolore,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child:  ElevatedButton(
                              style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(theamcolore),shape: const MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))))),
                              onPressed: () {

                                fundRaiseApiController.funraisedapi(
                                    cat_id: emapty,
                                    title: titlecontroller.text,
                                    fund_for: select == 0 ? "Self" : select == 1 ? "Other" : "Charity",
                                    fund_amt: fundamountcontroller.text,
                                    fund_story: storycontroller.text,
                                    exp_date: selectedDateAndTime.toString().split(" ").first,
                                    patient_title: patentnamecontroller.text,
                                    patient_diagnosis: patientdiagnosiscontroller.text,
                                    fund_plan: fundplancontroller.text,
                                    fundsize: '${finalimage.length}',
                                    petientsize: '${passengerimage.length}',
                                    certicatesize: '${image.length}',
                                    uid: userdata['id'],
                                    status: sender == "Publish"  ? '1' : '0',
                                    context: context,
                                    charity_id: "${select == 0 ? 0 : select == 1 ? 0 : charityselect}",
                                    full_address: address,
                                    lats: lat.toString(),
                                    longs: long.toString()
                                );

                                print("++    cat_id++            :--  ${emapty}");
                                print("++    title++             :--  ${titlecontroller.text}");
                                print("++    fund_for++          :--  ${select == 0 ? "Self" : select == 1 ? "Other" : "Charity"}");
                                print("++    fund_amt++          :--  ${fundamountcontroller.text}");
                                print("++    fund_story++        :--  ${storycontroller.text}");
                                print("++    exp_date++          :--  ${selectedDateAndTime.toString().split(" ").first}");
                                print("++    patient_title++     :--  ${patentnamecontroller.text}");
                                print("++    patient_diagnosis++ :--  ${patientdiagnosiscontroller.text}");
                                print("++    fund_plan++         :--  ${fundplancontroller.text}");
                                print("++    fundsize++          :--  ${finalimage.length}");
                                print("++    petientsize++       :--  ${passengerimage.length}");
                                print("++    certicatesize++     :--  ${image.length}");
                                print("++    uid++               :--  ${userdata['id']}");
                                print("++    status++            :--  ${sender == "Publish"  ? '0' : '1'}");
                                print("++    charity_id++        :--  ${select == 0 ? 0 : select == 1 ? 0 : charityselect}");
                                print("++    full_address++      :--  ${address}");
                                print("++    lats++              :--  ${lat.toString()}");
                                print("++    longs++             :--  ${long.toString()}");
                                print('+ + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + +');
                              },
                              child:  Center(child: Text('Submit'.tr,style: TextStyle(color: Colors.white,fontFamily: "SofiaProBold",fontSize: 14),))),
                        ),
                      )
                          :
                      Expanded(
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0xffDEE1F7),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ElevatedButton(
                              style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color(0xffDEE1F7)),shape: const MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))))),
                              onPressed: () {},
                              child: Center(child: Text('Submit'.tr,style:  TextStyle(color: theamcolore,fontFamily: "SofiaProBold",fontSize: 14),))),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      body: GetBuilder<FundRaiseApiController>(builder: (fundRaiseApiController) {
        return Stack(
          children: [
            SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  // const SizedBox(height: 20,),
                  Stack(
                    alignment: Alignment.bottomCenter,
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: Get.height,
                        width: Get.width,
                        color: notifier.containercolore,
                        child:  Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 40,),
                              Row(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child:  Icon(Icons.arrow_back,color: notifier.textcolore,size: 20)),
                                  const Spacer(),
                                  Text('Your fundraisers'.tr,style: TextStyle(color: notifier.textcolore,fontFamily: "SofiaProBold",fontSize: 18)),
                                  const Spacer(),
                                ],
                              ),
                              const SizedBox(height: 30,),
                              Text('Nearly finished. Add a'.tr,style: TextStyle(color: notifier.textcolore,fontFamily: "SofiaProBold",fontSize: 22),),
                              const SizedBox(height: 5,),
                              Text('fundraiser photo'.tr,style: TextStyle(color: notifier.textcolore,fontFamily: "SofiaProBold",fontSize: 22),),
                            ],
                          ),
                        ),
                      ),
                      Stack(
                        children: [
                          Container(
                              height: Get.height * 0.80,
                              width: Get.width,
                              decoration:  BoxDecoration(
                                color: notifier.background,
                                borderRadius: const BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child:  Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Step 4'.tr,style: const TextStyle(color: Colors.grey,fontSize: 14,fontFamily: "SofiaProBold"),),
                                    const SizedBox(height: 5,),
                                    const SizedBox(height: 10,),
                                    Text('High-Quality Photos to Build Trust with Donors'.tr,style: TextStyle(color: notifier.textcolore,fontSize: 15),maxLines: 2,overflow: TextOverflow.ellipsis,),

                                    const SizedBox(height: 20,),

                                    // const SizedBox(height: 10,),
                                    Text("Cover Photos".tr,style: TextStyle(color: notifier.textcolore,fontSize: 15,fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 10,),
                                    InkWell(
                                      onTap: () {
                                        showModalBottomSheet(
                                          backgroundColor: notifier.containercolore,
                                          isDismissible: false,
                                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(13))),
                                          context: context,
                                          builder: (context) {
                                            return SingleChildScrollView(
                                              child: Padding(
                                                padding: const EdgeInsets.all(10),
                                                child: Column(
                                                  children: [
                                                    Text("From where do you want to take the photo?".tr, style: TextStyle(fontSize: 20, color: notifier.textcolore),),
                                                    const SizedBox(height: 15),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Expanded(
                                                          child: OutlinedButton(
                                                            style: OutlinedButton.styleFrom(side: BorderSide(color: notifier.textcolore),fixedSize: const Size(100, 50), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
                                                            onPressed: ()  {
                                                              gallery();
                                                              Get.back();
                                                            },
                                                            child:  Text("Gallery".tr, style: TextStyle( fontSize: 15, color: notifier.textcolore),),
                                                          ),
                                                        ),
                                                        const SizedBox(width: 13),
                                                        Expanded(
                                                          child: OutlinedButton(
                                                            style: OutlinedButton.styleFrom(side: BorderSide(color: notifier.textcolore),fixedSize: const Size(100, 50), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
                                                            onPressed: ()  {
                                                              camera();
                                                              Get.back();
                                                            },
                                                            child:  Text("Camera".tr, style: TextStyle(fontSize: 15, color: notifier.textcolore),),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 15),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Container(
                                        width: 190,
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            border: Border.all(color: theamcolore),
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child:  Center(child: Text('Upload Photos (Multiple)'.tr,style: TextStyle(color: notifier.textcolore),)),
                                      ),
                                    ),
                                    const SizedBox(height: 10,),
                                    finalimage.isEmpty ? const SizedBox() : SizedBox(
                                      height:  170,
                                      child: ListView.builder(
                                        clipBehavior: Clip.none,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        padding: EdgeInsets.only(bottom: 10),
                                        itemCount: finalimage.length,
                                        itemBuilder: (context, index) {
                                          return Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              Container(
                                                height: 300,
                                                width: 150,
                                                margin: EdgeInsets.only(right: 15),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    image: DecorationImage(image: FileImage(File(finalimage[index])),fit: BoxFit.cover)
                                                ),
                                              ),
                                              Positioned(
                                                right: 5,
                                                top: -8,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      finalimage.removeAt(index);
                                                    });
                                                  },
                                                  child: Container(
                                                    height: 26,
                                                    width: 26,
                                                    decoration: BoxDecoration(
                                                      color: theamcolore,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: const Center(child: Icon(Icons.close, color: Colors.white, size: 18,)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },),
                                    ),
                                    const SizedBox(height: 10,),
                                  ],
                                ),
                              )

                          ),
                        ],
                      ),

                    ],
                  )
                ],
              ),
            ),
          ],
        );
      },),
    );
  }
}

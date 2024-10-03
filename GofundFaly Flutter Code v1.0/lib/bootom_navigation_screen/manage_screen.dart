// ignore_for_file: camel_case_types, avoid_print, prefer_typing_uninitialized_variables, unused_field, prefer_final_fields

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gofunds/app_screen/create_fundraiser.dart';
import 'package:gofunds/app_screen/describe_fundraising.dart';
import 'package:gofunds/app_screen/passenger_details.dart';
import 'package:gofunds/common/config.dart';
import 'package:gofunds/controller/login_controller.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app_screen/add_fundraiser_photo_screen.dart';
import '../app_screen/fundraiser_details.dart';
import '../common/common_button.dart';
import '../common/light_dark_mode.dart';
import '../controller/getapi_controller.dart';
import '../demo_screen.dart';
import '../secound_bootom_navigation_screen/secound_bottom_navigation_screen.dart';

class Manage_screen extends StatefulWidget {
  const Manage_screen({super.key});

  @override
  State<Manage_screen> createState() => _Manage_screenState();
}

class _Manage_screenState extends State<Manage_screen> with TickerProviderStateMixin {

  int selectindex = 1;


  String description = 'Enter your text'.tr;

  TextEditingController controller = TextEditingController();

  late final TabController _tabController;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  double _currentSliderValue = 20;

  int selectIndex = 0;

  FundListController fundListController = Get.put(FundListController());
  ActivityApiController activityApiController = Get.put(ActivityApiController());
  FundDidWiseController fundDidWiseController = Get.put(FundDidWiseController());

  @override
  void initState() {
    super.initState();
   setState(() {
     datagetfunction();
   });

    // clear data

    emapty = "";
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

    _tabController = TabController(length: 3, vsync: this);
    controller.addListener(() {
      print(controller.text);
    });
  }

  var userdata;
  var currency1;

  datagetfunction() async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var uid = preferences.getString("userLogin");
    userdata = jsonDecode(uid!);
    var curr = currency1 = preferences.getString("currenci");
    currency1 = jsonDecode(curr!);
    setState(() {});

    fundListController.fundlistApi(uid: userdata['id'], status: 'Pending').then((value) {

      fundListController.fundlistApi(uid: userdata['id'], status: 'Completed').then((value) {

        fundListController.fundlistApi(uid: userdata['id'], status: 'Cancelled').then((value) {

          activityApiController.Activityyyapi(uid: userdata['id']);

        },);

      },);

    },);

  }

  ColorNotifier notifier = ColorNotifier();

  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: notifier.background,
        appBar: AppBar(
          backgroundColor: notifier.background,
          toolbarHeight: 80,
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Column(
            children: [
              const SizedBox(height: 25,),
              Text('Your fundraisers'.tr,style: TextStyle(color: notifier.textcolore,fontFamily: "SofiaProBold",fontSize: 18)),
              TabBar(
                onTap: (value) {
                },
                indicatorColor: theamcolore,
                labelColor: Colors.black,
                physics: const NeverScrollableScrollPhysics(),
                indicatorSize: TabBarIndicatorSize.label,
                dividerColor: Colors.transparent,
                // unselectedLabelColor: Colors.grey,
                tabs: <Widget>[
                  Tab(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('My Fundraising'.tr,style: TextStyle(color: notifier.textcolore,fontSize: 15,fontFamily: "SofiaProBold"),),
                    ],
                  )),
                  Tab(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Activity'.tr,style: TextStyle(color: notifier.textcolore,fontSize: 15,fontFamily: "SofiaProBold"),),
                    ],
                  )),
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 80),
          child: FloatingActionButton(
            backgroundColor: theamcolore,
            onPressed: () {
              emapty = "";
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Create_Fundraiser(),));
            },
            child: const Icon(Icons.add),
          ),
        ),
        body: GetBuilder<ActivityApiController>(builder: (activityApiController) {
          return fundListController.isLoading ? Center(child: CircularProgressIndicator(color: theamcolore)) : TabBarView(
            children: [
              NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverToBoxAdapter(
                      child: Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10,top: 10),
                      child: SizedBox(
                        height: 45,
                        child: TabBar(
                          onTap: (value) {
                            value == 0 ? fundListController.fundlistApi(uid: userdata['id'], status: 'Pending') : value == 1 ? fundListController.fundlistApi(uid: userdata['id'], status: 'Completed') : fundListController.fundlistApi(uid: userdata['id'], status: 'Cancelled');
                          },
                          indicator: BoxDecoration(
                            color: theamcolore,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          controller: _tabController,
                          indicatorColor: Colors.red,
                          labelColor: Colors.white,
                          unselectedLabelColor: notifier.textcolore,
                          dividerColor: Colors.transparent,
                          labelStyle:  const TextStyle(fontSize: 13,fontWeight: FontWeight.bold,fontFamily: "SofiaRegular"),
                          tabs: <Widget>[
                            Tab(text: 'Pending'.tr),
                            Tab(text: 'Completed'.tr),
                            Tab(text: 'Cancelled'.tr),
                          ],
                        ),
                      ),
                    ),
                  ),
                 ];
                },
                body: Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15,bottom: 15),
                  child: SizedBox(
                    child: TabBarView(
                      controller: _tabController,
                      children: <Widget>[
                        fundListController.fundlistapimodel!.fundlist.isEmpty ? Center(
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
                        ) : ListView.separated(
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: 0);
                            },
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: fundListController.fundlistapimodel!.fundlist.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => secound_bottombar(ordercancel: false,ordercomplete: false,isComplete: true,id: fundListController.fundlistapimodel!.fundlist[index].id),));
                                  photoscreencontroller.clear();
                                  textscreencontroller.clear();
                                  fundupdateimage = [];
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      // height: 100,
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
                                            decoration:  const BoxDecoration(
                                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
                                            ),
                                            child: ClipRRect(
                                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
                                              child: FadeInImage.assetNetwork(
                                                placeholder: "assets/gfimage.png",
                                                placeholderCacheWidth: 290,
                                                placeholderCacheHeight: 270,
                                                image:
                                                Config.baseurl + fundListController.fundlistapimodel!.fundlist[index].fundPhotos[0],
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
                                                  Text(fundListController.fundlistapimodel!.fundlist[index].title,style:  TextStyle(fontSize: 14,fontFamily: "SofiaProBold",color: notifier.textcolore),maxLines: 1,overflow: TextOverflow.ellipsis,),
                                                  const SizedBox(height: 10,),
                                                  Row(
                                                    children: [
                                                      Text('\$ ${fundListController.fundlistapimodel!.fundlist[index].fundAmt}',style: TextStyle(fontSize: 14,color: theamcolore),maxLines: 1,overflow: TextOverflow.ellipsis,),
                                                      Flexible(child: Text(' fund raised'.tr,style: TextStyle(fontSize: 14,color: notifier.textcolore),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                                                    ],
                                                  ),

                                                  fundListController.fundlistapimodel!.fundlist[index].remainAmt == 0 ? Container(
                                                    width: MediaQuery.of(context).size.width,
                                                    height: 8.0,
                                                    margin: const EdgeInsets.only(top: 15,bottom: 15),
                                                    decoration: BoxDecoration(
                                                      color: theamcolore,
                                                      borderRadius: BorderRadius.circular(5),
                                                    ),
                                                  ) : GetBuilder<CatWiseFundController>(
                                                      builder: (catWiseFundController) {
                                                        return MyWidgetSlider((fundListController.fundlistapimodel!.fundlist[index].remainAmt + double.parse(fundListController.fundlistapimodel!.fundlist[index].totalInvestment) ).toString(),fundListController.fundlistapimodel!.fundlist[index].totalInvestment.toString());
                                                      }
                                                  ),

                                                  Row(
                                                    children: [
                                                      Text("Raised".tr,style: TextStyle(color: notifier.textcolore)),
                                                      const Spacer(),
                                                      fundListController.fundlistapimodel!.fundlist[index].remainAmt == 0 ?  Text("Complete".tr,style: TextStyle(color: notifier.textcolore)) :   Text("${(double.parse(fundListController.fundlistapimodel!.fundlist[index].totalInvestment) / (fundListController.fundlistapimodel!.fundlist[index].remainAmt + double.parse(fundListController.fundlistapimodel!.fundlist[index].totalInvestment)) * 100).toStringAsFixed(2)}%",style: TextStyle(color: notifier.textcolore)),
                                                    ],
                                                  ),

                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10,),
                                  ],
                                ),
                              );
                            }),
                        fundListController.fundlistapimodelcomplete!.fundlist.isEmpty ? Center(
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
                        ) : ListView.separated(
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: 0);
                            },
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: fundListController.fundlistapimodelcomplete!.fundlist.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => secound_bottombar(ordercancel: false,ordercomplete: true,isComplete: false,id: fundListController.fundlistapimodelcomplete!.fundlist[index].id),));
                                },
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
                                            decoration:  const BoxDecoration(
                                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
                                            ),
                                            child: ClipRRect(
                                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
                                              child: FadeInImage.assetNetwork(
                                                placeholder: "assets/gfimage.png",
                                                placeholderCacheWidth: 290,
                                                placeholderCacheHeight: 270,
                                                image:
                                                Config.baseurl + fundListController.fundlistapimodelcomplete!.fundlist[index].fundPhotos[0],
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
                                                  Text(fundListController.fundlistapimodelcomplete!.fundlist[index].title,style:  TextStyle(fontSize: 14,fontFamily: "SofiaProBold",color: notifier.textcolore),maxLines: 1,overflow: TextOverflow.ellipsis,),
                                                  const SizedBox(height: 10,),
                                                  Row(
                                                    children: [
                                                      Text('\$ ${fundListController.fundlistapimodelcomplete!.fundlist[index].fundAmt}',style: TextStyle(fontSize: 14,color: theamcolore),maxLines: 1,overflow: TextOverflow.ellipsis,),
                                                      Flexible(child: Text(' fund raised'.tr,style: TextStyle(fontSize: 14,color: notifier.textcolore),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                                                    ],
                                                  ),

                                                  fundListController.fundlistapimodelcomplete!.fundlist[index].remainAmt == 0 ? Container(
                                                    width: MediaQuery.of(context).size.width,
                                                    height: 8.0,
                                                    margin: const EdgeInsets.only(top: 15,bottom: 15),
                                                    decoration: BoxDecoration(
                                                      color: theamcolore,
                                                      borderRadius: BorderRadius.circular(5),
                                                    ),
                                                  ) : GetBuilder<CatWiseFundController>(
                                                      builder: (catWiseFundController) {
                                                        return MyWidgetSlider((fundListController.fundlistapimodelcomplete!.fundlist[index].remainAmt + double.parse(fundListController.fundlistapimodelcomplete!.fundlist[index].totalInvestment) ).toString(),fundListController.fundlistapimodelcomplete!.fundlist[index].totalInvestment.toString());
                                                      }
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text("Raised".tr,style: TextStyle(color: notifier.textcolore)),
                                                      const Spacer(),
                                                      fundListController.fundlistapimodelcomplete!.fundlist[index].remainAmt == 0 ?  Text("Complete".tr,style: TextStyle(color: notifier.textcolore)) :   Text("${(double.parse(fundListController.fundlistapimodelcomplete!.fundlist[index].totalInvestment) / (fundListController.fundlistapimodelcomplete!.fundlist[index].remainAmt + double.parse(fundListController.fundlistapimodelcomplete!.fundlist[index].totalInvestment)) * 100).toStringAsFixed(2)}%",style: TextStyle(color: notifier.textcolore)),
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
                                  ],
                                ),
                              );
                            }),
                        fundListController.fundlistapimodelcancelled!.fundlist.isEmpty ? Center(
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
                        ) : ListView.separated(
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: 0);
                            },
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: fundListController.fundlistapimodelcancelled!.fundlist.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => secound_bottombar(ordercancel: true,ordercomplete: false,isComplete: false,id: fundListController.fundlistapimodelcancelled!.fundlist[index].id),));
                                },
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
                                            ),
                                            child: ClipRRect(
                                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
                                              child: FadeInImage.assetNetwork(
                                                placeholder: "assets/gfimage.png",
                                                placeholderCacheWidth: 290,
                                                placeholderCacheHeight: 270,
                                                image: Config.baseurl + fundListController.fundlistapimodelcancelled!.fundlist[index].fundPhotos[0],
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
                                                  Text(fundListController.fundlistapimodelcancelled!.fundlist[index].title,style:  TextStyle(fontSize: 14,fontFamily: "SofiaProBold",color: notifier.textcolore),maxLines: 1,overflow: TextOverflow.ellipsis,),
                                                  const SizedBox(height: 10,),
                                                  Row(
                                                    children: [
                                                      Text('\$ ${fundListController.fundlistapimodelcancelled!.fundlist[index].fundAmt}',style: TextStyle(fontSize: 14,color: theamcolore),maxLines: 1,overflow: TextOverflow.ellipsis,),
                                                       Flexible(child: Text(' fund raised'.tr,style: TextStyle(fontSize: 14,color: notifier.textcolore),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                                                    ],
                                                  ),

                                                  fundListController.fundlistapimodelcancelled!.fundlist[index].remainAmt == 0 ? Container(
                                                    width: MediaQuery.of(context).size.width,
                                                    height: 8.0,
                                                    margin: const EdgeInsets.only(top: 15,bottom: 15),
                                                    decoration: BoxDecoration(
                                                      color: theamcolore,
                                                      borderRadius: BorderRadius.circular(5),
                                                    ),
                                                  ) : GetBuilder<CatWiseFundController>(
                                                      builder: (catWiseFundController) {
                                                        return MyWidgetSlider((fundListController.fundlistapimodelcancelled!.fundlist[index].remainAmt + double.parse(fundListController.fundlistapimodelcancelled!.fundlist[index].totalInvestment) ).toString(),fundListController.fundlistapimodelcancelled!.fundlist[index].totalInvestment.toString());
                                                      }
                                                  ),

                                                  Row(
                                                    children: [
                                                      Text("Raised".tr,style: TextStyle(color: notifier.textcolore)),
                                                      const Spacer(),
                                                      fundListController.fundlistapimodelcancelled!.fundlist[index].remainAmt == 0 ?  Text("Complete".tr,style: TextStyle(color: notifier.textcolore)) :   Text("${(double.parse(fundListController.fundlistapimodelcancelled!.fundlist[index].totalInvestment) / (fundListController.fundlistapimodelcancelled!.fundlist[index].remainAmt + double.parse(fundListController.fundlistapimodelcancelled!.fundlist[index].totalInvestment)) * 100).toStringAsFixed(2)}%",style: TextStyle(color: notifier.textcolore)),
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
                                  ],
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
                ),
              ),
              GetBuilder<ActivityApiController>(builder: (activityApiController) {
                return Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15),
                  child: activityApiController.activityModel!.activitylist.isEmpty ? Center(
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListView.separated(
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: 0);
                            },
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: activityApiController.activityModel!.activitylist.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: activityApiController.activityModel!.activitylist[index].profilePic == null ?
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(child: Image(image: const AssetImage('assets/user.png'),color: theamcolore,height: 20,width: 20,)),
                                )
                                    :
                                Container(
                                  height: 40,
                                  width: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.grey.withOpacity(0.4)),
                                      image:  DecorationImage(image: NetworkImage(Config.baseurl + activityApiController.activityModel!.activitylist[index].profilePic),fit: BoxFit.cover)
                                  ),
                                  // child: Image(image: AssetImage('${image[index]}'),height: 20,width: 20,)
                                ),
                                title: Text(activityApiController.activityModel!.activitylist[index].fundTitle,style:  TextStyle(color: notifier.textcolore,fontSize: 14)),
                                subtitle: Text("By ${activityApiController.activityModel!.activitylist[index].name}",style:  const TextStyle(color: Colors.grey,fontSize: 12)),
                                trailing: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(10),
                                      height: 35,
                                      decoration: BoxDecoration(
                                          border: Border.all(color: theamcolore),
                                          borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text('$currency1 ${activityApiController.activityModel!.activitylist[index].donationAmt}',style: TextStyle(color: theamcolore,fontSize: 12),),
                                    ),
                                  ],
                                ),
                              );
                            }),



                      ],
                    ),
                  ),
                );
              },),
            ],
          );
        },),
      ),
    );
  }



}



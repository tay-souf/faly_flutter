// ignore_for_file: camel_case_types, unused_field, prefer_typing_uninitialized_variables, prefer_final_fields, avoid_print, deprecated_member_use, use_key_in_widget_constructors, must_be_immutable

import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gofunds/app_screen/donate_payment_screen.dart';
import 'package:gofunds/common/common_button.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../auth_screen/login_screen.dart';
import '../common/config.dart';
import '../common/home_controoler.dart';
import '../common/light_dark_mode.dart';
import '../common/sliver_appbar_screen.dart';
import '../bootom_navigation_screen/home_screen.dart';
import '../controller/getapi_controller.dart';
import '../demo_screen.dart';



class details_screen extends StatefulWidget {
  final String id;
  final String totalInvestment;
  final String remainAmt;
  final String walletamount;
  final String palteformfee;
  const details_screen({super.key, required this.id, required this.totalInvestment, required this.remainAmt, required this.walletamount, required this.palteformfee});

  @override
  State<details_screen> createState() => _details_screenState();
}

class _details_screenState extends State<details_screen> {

  final controller = PageController();
  final List<String> imgList = [
    "https://images.pexels.com/photos/1099217/pexels-photo-1099217.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    "https://images.pexels.com/photos/1583582/pexels-photo-1583582.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    "https://images.pexels.com/photos/1761279/pexels-photo-1761279.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
  ];



  double _currentSliderValue = 20;
  List isReademore = [];
  bool ischeck = false;
  List likelist = [];

  FundDidWiseController fundDidWiseController = Get.put(FundDidWiseController());

  @override
  void initState() {
    super.initState();
    datagetfunction();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    fundDidWiseController.isLoading = true;
    super.dispose();
  }

  var userdata;
  var currency1;
  var currentdate;
  var expirydate;
  int? daysDifference;

  getCurrentDate() {
    setState(() {

    });
    var date = DateTime.now().toString();

    var dateParse = DateTime.parse(date);
    String dateString = fundDidWiseController.fundidimodel!.funddata[0].expDate.toString().split(" ").first;

    List<String> dateParts = dateString.split('-');
    int year = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1]);
    int day = int.parse(dateParts[2]);

    DateTime startDate = DateTime(dateParse.year, dateParse.month, dateParse.day);
    DateTime endDate = DateTime(year,month,day);

    Duration difference = endDate.difference(startDate);

    daysDifference = difference.inDays;

     print("***//// currentdate ////***:-----   ${startDate}");
     print("***//// expirydate ////***:------   ${endDate}");
     print("***//// value ////***:------   ${daysDifference}");
     print("***//// widget.remainAmtwidget.remainAmtwidget.remainAmt ////***:------   ${fundDidWiseController.fundidimodel!.funddata[0].remainAmt}");

    return currentdate;
  }

  Future datagetfunction() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var uid = preferences.getString("userLogin");
    var curr = currency1 = preferences.getString("currenci");
    currency1 = jsonDecode(curr!);
    boolValue == true ? null : userdata = jsonDecode(uid!);
    fundDidWiseController.funddidApi(uid: boolValue == true ? "0" : userdata['id'], fundid: widget.id,status: "Home").then((value) {
      getCurrentDate();
    },);
    print(" + + + + + + + : - - - - ---  $currency1");
  }

  ColorNotifier notifier = ColorNotifier();

  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return Scaffold(
      backgroundColor: notifier.background,
      bottomNavigationBar: GetBuilder<FundDidWiseController>(builder: (fundDidWiseController) {
        return fundDidWiseController.isLoading ? Center(child: CircularProgressIndicator(color: theamcolore,)) : double.parse(fundDidWiseController.fundidimodel!.funddata[0].remainAmt) <= 0.00 ? const SizedBox() : Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10,top: 10),
          child: CommonButton(containcolore: theamcolore, txt1: 'Donate Now'.tr, context: context,onPressed1: () {
            boolValue == true ? Get.offAll(const Login_Scrren()) : Get.bottomSheet(
              isScrollControlled: true,
             StatefulBuilder(builder: (context, setState) {
               return  Container(
                 height: 620,
                 decoration: BoxDecoration(
                     color: notifier.textcolore,
                     borderRadius: const BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15)),
                 ),
                 child: StatefulBuilder(builder: (context, setState) {
                   return Donate_Payment_Screen(secoundcupon: double.parse(widget.remainAmt) < 1 ? false : true,totalInvestment: widget.totalInvestment,palteformfee: widget.palteformfee,walletamount: widget.walletamount,title: fundDidWiseController.fundidimodel!.funddata[0].title,id: widget.id,remain_amt: double.parse(fundDidWiseController.fundidimodel!.funddata[0].remainAmt));
                 },),
               );
             },),
            );
          }),
        );
      },),
      body: GetBuilder<FundDidWiseController>(builder: (fundDidWiseController) {
        return fundDidWiseController.isLoading ? Center(child: CircularProgressIndicator(color: theamcolore,)) : CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: MySliverAppBar(expandedHeight: 250),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10,),
                            Text(fundDidWiseController.fundidimodel!.funddata[0].title,style: TextStyle(fontSize: 18,fontFamily: "SofiaProBold",color: notifier.textcolore),),
                            widget.remainAmt == "0" ? Container(
                              width: MediaQuery.of(context).size.width,
                              height: 6,
                              margin: const EdgeInsets.only(top: 15,bottom: 15),
                              decoration: BoxDecoration(
                                color: theamcolore,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ) : MyWidgetSlider((double.parse(widget.remainAmt) + double.parse(widget.totalInvestment)).toString(),widget.totalInvestment),
                            RichText(text: TextSpan(children: [
                              TextSpan(text: "$currency1${double.parse(widget.totalInvestment).toStringAsFixed(2)}",style: TextStyle(color: notifier.textcolore,fontWeight: FontWeight.bold,fontFamily: 'SofiaRegular')),
                              TextSpan(text: " raised of ".tr,style: TextStyle(color: notifier.textcolore,fontFamily: 'SofiaRegular')),
                              TextSpan(text: " $currency1${(double.parse(widget.remainAmt) + double.parse((widget.totalInvestment))).toString()}",style: TextStyle(color: notifier.textcolore,fontWeight: FontWeight.bold,fontFamily: 'SofiaRegular')),
                              TextSpan(text: " target".tr,style: TextStyle(color: notifier.textcolore,fontFamily: 'SofiaRegular')),
                            ])),
                            const SizedBox(height: 2,),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Text("${fundDidWiseController.fundidimodel!.funddata[0].donaterlist.length} ",style: TextStyle(color: notifier.textcolore,fontWeight: FontWeight.bold)),
                                    Text("donations",style: TextStyle(color: notifier.textcolore)),
                                  ],
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    daysDifference == null ? const SizedBox() : Text("${daysDifference! <= 0 ? "0" : daysDifference} ",style: TextStyle(color: notifier.textcolore,fontWeight: FontWeight.bold)),
                                    Text("Days left",style: TextStyle(color: notifier.textcolore)),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 20,),
                            Text('Posted By'.tr,style: TextStyle(color: notifier.textcolore,fontSize: 16,fontFamily: "SofiaProBold")),
                            Row(
                              children: [
                                Expanded(
                                  child: ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.1),
                                          shape: BoxShape.circle,
                                          image: DecorationImage(image: NetworkImage('${Config.baseurl}${fundDidWiseController.fundidimodel!.funddata[0].patientPhoto[0]}'),fit: BoxFit.fill),
                                      ),
                                    ),
                                    title: Text(fundDidWiseController.fundidimodel!.funddata[0].patientTitle,style: TextStyle(color: notifier.textcolore,fontSize: 16,)),
                                    subtitle: Text(fundDidWiseController.fundidimodel!.funddata[0].patientDiagnosis,style: const TextStyle(color: Colors.grey,fontSize: 14)),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5,),
                            fundDidWiseController.fundidimodel!.funddata[0].charityName.isEmpty ? const SizedBox() : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10,),
                                Text('Charity'.tr,style: TextStyle(color: notifier.textcolore,fontSize: 16,fontFamily: "SofiaProBold")),
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.2),
                                        shape: BoxShape.circle,
                                        image: DecorationImage(image: NetworkImage(Config.baseurl + fundDidWiseController.fundidimodel!.funddata[0].charityImg),fit: BoxFit.fill)
                                    ),
                                  ),
                                  title: Text(fundDidWiseController.fundidimodel!.funddata[0].charityName,style: TextStyle(color: notifier.textcolore,fontSize: 14)),
                                  subtitle: Text(fundDidWiseController.fundidimodel!.funddata[0].charityTinno,style: const TextStyle(color: Colors.grey,fontSize: 12)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 0,),
                            Text('Story'.tr,style: TextStyle(color: notifier.textcolore,fontSize: 16,fontFamily: "SofiaProBold")),
                            const SizedBox(height: 10,),
                            ReadMoreText(
                             fundDidWiseController.fundidimodel!.funddata[0].fundStory.replaceAll("\\n", "\n"),
                              trimLines: 4,
                              style: TextStyle(color: notifier.textcolore),
                              colorClickableText: theamcolore,
                              trimMode: TrimMode.Line,
                              trimCollapsedText: '...Read more'.tr,
                              trimExpandedText: ' Less'.tr,
                            ),
                            fundDidWiseController.fundidimodel!.fundupdate.isEmpty ? const SizedBox() :  const SizedBox(height: 20,),
                            fundDidWiseController.fundidimodel!.fundupdate.isEmpty ? const SizedBox() :  Text('Updates (${fundDidWiseController.fundidimodel!.fundupdate.length})',style:  TextStyle(fontFamily: "SofiaProBold",color: notifier.textcolore,fontSize: 16),),
                            fundDidWiseController.fundidimodel!.fundupdate.isEmpty ? const SizedBox() : const SizedBox(height: 10,),
                            Padding(
                              padding: const EdgeInsets.only(left: 0, right: 0),
                              child: GetBuilder<HomeController>(builder: (homeController) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                      children: [],
                                    ),

                                    for (int i = 0; i <fundDidWiseController.fundidimodel!.fundupdate.length; i++)

                                      TimelineTile(
                                        isFirst:  i == 0 ? true : false,
                                        isLast: i == fundDidWiseController.fundidimodel!.fundupdate.length-1 ? true : false,
                                        hasIndicator: true,
                                        endChild: Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                margin: const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  color: notifier.containercolore,
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 10, top: 10,bottom: 10,right: 0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        fundDidWiseController.fundidimodel!.fundupdate[i].updateDate.toString().split(' ').first,
                                                        style:  TextStyle(
                                                          fontSize: 14,
                                                          color: notifier.textcolore,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 10,),
                                                      fundDidWiseController.fundidimodel!.fundupdate[i].photo.isEmpty ? const SizedBox() : SizedBox(
                                                        height: 100,
                                                        child: ListView.separated(
                                                          separatorBuilder: (context, index) {
                                                            return const SizedBox(width: 10,);
                                                          },
                                                          shrinkWrap: true,
                                                          scrollDirection: Axis.horizontal,
                                                          itemCount: fundDidWiseController.fundidimodel!.fundupdate[i].photo.length,
                                                          itemBuilder: (context, index) {
                                                            return InkWell(
                                                              onTap: () {
                                                                Get.to(
                                                                  FullScreenImage(
                                                                    itemcountt: fundDidWiseController.fundidimodel!.fundupdate[i].photo.length,
                                                                    imageUrl: fundDidWiseController.fundidimodel!.fundupdate[i].photo,
                                                                    tag: "generate_a_unique_tag",
                                                                    index: index,
                                                                  ),
                                                                );
                                                              },
                                                              child: Container(
                                                                height: 100,
                                                                width: 100,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(10),
                                                                ),
                                                                child: ClipRRect(
                                                                  borderRadius: BorderRadius.circular(10),
                                                                  child: FadeInImage.assetNetwork(
                                                                    placeholder: "assets/gfimage.png",
                                                                    placeholderCacheWidth: 290,
                                                                    placeholderCacheHeight: 270,
                                                                    image:
                                                                    Config.baseurl + fundDidWiseController.fundidimodel!.fundupdate[i].photo[index],
                                                                    fit: BoxFit.cover,
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },),
                                                      ),
                                                      const SizedBox(height: 5,),
                                                      Text(
                                                        fundDidWiseController.fundidimodel!.fundupdate[i].updateDesc.replaceAll("\\n", "\n"),
                                                        style:  TextStyle(
                                                          fontSize: 16,
                                                          color: notifier.textcolore,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        beforeLineStyle: LineStyle(color: notifier.containercolore, thickness: 2),
                                        indicatorStyle: IndicatorStyle(
                                          height: 10,
                                          width: 10,
                                          indicator: Container(
                                            height: 15,
                                            width: 15,
                                            decoration:  BoxDecoration(
                                                color: theamcolore,
                                                shape: BoxShape.circle
                                            ),
                                          ),
                                        ),
                                      ),

                                  ],
                                );
                              },),
                            ),
                            fundDidWiseController.fundidimodel!.funddata[0].donaterlist.isEmpty ? const SizedBox() : const SizedBox(height: 10,),
                            fundDidWiseController.fundidimodel!.funddata[0].donaterlist.isEmpty ? const SizedBox() : Builder(
                              builder: (context) {
                                return Text('Donaters'.tr,style: TextStyle(color: notifier.textcolore,fontSize: 16,fontFamily: "SofiaProBold"));
                              }
                            ),
                            ListView.separated(
                                // reverse: true,
                                separatorBuilder: (context, index) {
                                  return const SizedBox(height: 0);
                                },
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: fundDidWiseController.fundidimodel!.funddata[0].donaterlist.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return index < 3? Transform.translate(
                                    offset: const Offset(0, -40),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      leading: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.1),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Center(child: Image.asset("assets/donateicon.png",height: 30,width: 30,color: notifier.textcolore,)),
                                      ),
                                      title: fundDidWiseController.fundidimodel!.funddata[0].donaterlist[index].name == null ? const Text("") : Text("${fundDidWiseController.fundidimodel!.funddata[0].donaterlist[index].name}",style: TextStyle(color: notifier.textcolore)),
                                      subtitle: Row(
                                        children: [
                                          Text("$currency1${fundDidWiseController.fundidimodel!.funddata[0].donaterlist[index].amt}",style: TextStyle(color: notifier.textcolore)),
                                          const SizedBox(width: 5,),
                                          Text("( ${fundDidWiseController.fundidimodel!.funddata[0].donaterlist[index].depositeDate} )",style: TextStyle(color: notifier.textcolore)),
                                        ],
                                      ),
                                    ),
                                  ) : const SizedBox();
                                }
                              ),
                            fundDidWiseController.fundidimodel!.funddata[0].donaterlist.length > 3 ? Transform.translate(
                              offset: const Offset(0, -35),
                              child: OutlinedButton(
                                style:  ButtonStyle(fixedSize: WidgetStatePropertyAll(Size(Get.width, 50)),side: MaterialStatePropertyAll(BorderSide(color: Colors.grey.withOpacity(0.4))),shape: const MaterialStatePropertyAll(RoundedRectangleBorder(side: BorderSide(color: Colors.red),borderRadius: BorderRadius.all(Radius.circular(10))))),
                                onPressed: () {
                                  Get.bottomSheet(
                                      StatefulBuilder(
                                          builder: (context, setState) {
                                            return Scaffold(
                                              backgroundColor: notifier.background,
                                              appBar: AppBar(
                                                toolbarHeight: 80,
                                                elevation: 0,
                                                backgroundColor: notifier.background,
                                                automaticallyImplyLeading: false,
                                                title: Padding(
                                                  padding:  const EdgeInsets.only(top: 60),
                                                  child: Row(
                                                    children: [
                                                      Text('Donations'.tr,style:  TextStyle(color: notifier.textcolore,fontSize: 16,fontFamily: "SofiaProBold"),overflow: TextOverflow.ellipsis,),
                                                      Text(' (${fundDidWiseController.fundidimodel!.funddata[0].donaterlist.length})',style:  TextStyle(color: notifier.textcolore,fontSize: 16,fontFamily: "SofiaProBold"),overflow: TextOverflow.ellipsis,),
                                                    ],
                                                  ),
                                                ),
                                                actions: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 60,right: 15),
                                                    child: InkWell(
                                                        onTap: () {
                                                          Get.back();
                                                        },
                                                        child:  Icon(Icons.close,color: notifier.textcolore)
                                                    ),
                                                  )
                                                ],
                                              ),
                                              body: Container(
                                                height: Get.height,
                                                width: Get.width,
                                                decoration:  BoxDecoration(
                                                    color: notifier.background,
                                                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(15),
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        const SizedBox(height: 20,),
                                                        ListView.separated(
                                                          reverse: true,
                                                            separatorBuilder: (context, index) {
                                                              return const SizedBox(height: 0);
                                                            },
                                                            shrinkWrap: true,
                                                            scrollDirection: Axis.vertical,
                                                            physics: const NeverScrollableScrollPhysics(),
                                                            itemCount: fundDidWiseController.fundidimodel!.funddata[0].donaterlist.length,
                                                            itemBuilder: (BuildContext context, int index) {
                                                              return Transform.translate(
                                                                offset: const Offset(0, -30),
                                                                child: ListTile(
                                                                  contentPadding: EdgeInsets.zero,
                                                                  leading: Container(
                                                                    height: 50,
                                                                    width: 50,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors.grey.withOpacity(0.1),
                                                                        shape: BoxShape.circle,
                                                                    ),
                                                                    child: Center(child: Image.asset("assets/donateicon.png",height: 30,width: 30,color: notifier.textcolore,)),
                                                                  ),
                                                                  title: Text("${fundDidWiseController.fundidimodel!.funddata[0].donaterlist[index].name}",style: TextStyle(color: notifier.textcolore)),
                                                                  subtitle: Row(
                                                                    children: [
                                                                      Text("$currency1${double.parse(fundDidWiseController.fundidimodel!.funddata[0].donaterlist[index].amt).toStringAsFixed(2)}",style: TextStyle(color: notifier.textcolore)),
                                                                      const SizedBox(width: 5,),
                                                                      Text("( ${fundDidWiseController.fundidimodel!.funddata[0].donaterlist[index].depositeDate} )",style: TextStyle(color: notifier.textcolore)),
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            }
                                                           ),
                                                        const SizedBox(height: 20,),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                      ),
                                      isScrollControlled: true
                                  );
                                },
                                child:  Center(child: Text('See all'.tr,style: TextStyle(color: notifier.textcolore,fontFamily: "SofiaProBold"),)),
                              ),
                            ) : const SizedBox(),
                            Transform.translate( offset: const Offset(0, -20),child: Text('Beneficiary Pictures'.tr,style: TextStyle(color: notifier.textcolore,fontSize: 16,fontFamily: "SofiaProBold"))),
                            const SizedBox(height: 10,),
                            Transform.translate(
                              offset: const Offset(0, -20),
                              child: SizedBox(
                                height: 100,
                                child: ListView.separated(
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(width: 10,);
                                  },
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: fundDidWiseController.fundidimodel!.funddata[0].patientPhoto.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Get.to(
                                          FullScreenImage(
                                            itemcountt: fundDidWiseController.fundidimodel!.funddata[0].patientPhoto.length,
                                            imageUrl: fundDidWiseController.fundidimodel!.funddata[0].patientPhoto,
                                            tag: "generate_a_unique_tag",
                                            index: index,
                                          ),
                                        );
                                      },
                                      child: Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: FadeInImage.assetNetwork(
                                            placeholder: "assets/gfimage.png",
                                            placeholderCacheWidth: 290,
                                            placeholderCacheHeight: 270,
                                            image:
                                            Config.baseurl + fundDidWiseController.fundidimodel!.funddata[0].patientPhoto[index],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    );
                                  },),
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Transform.translate(offset: const Offset(0, -20),child: Text('Other Documentation'.tr,style: TextStyle(color: notifier.textcolore,fontSize: 16,fontFamily: "SofiaProBold"))),
                            const SizedBox(height: 10,),
                            Transform.translate(
                              offset: const Offset(0, -20),
                              child: SizedBox(
                                height: 100,
                                child: ListView.separated(
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(width: 10,);
                                  },
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: fundDidWiseController.fundidimodel!.funddata[0].medicalCertificate.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Get.to(
                                          FullScreenImage(
                                            itemcountt: fundDidWiseController.fundidimodel!.funddata[0].medicalCertificate.length,
                                            imageUrl: fundDidWiseController.fundidimodel!.funddata[0].medicalCertificate,
                                            tag: "generate_a_unique_tag",
                                            index: index,
                                          ),
                                        );
                                      },
                                      child: Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: FadeInImage.assetNetwork(
                                            placeholder: "assets/gfimage.png",
                                            placeholderCacheWidth: 290,
                                            placeholderCacheHeight: 270,
                                            image:
                                            Config.baseurl + fundDidWiseController.fundidimodel!.funddata[0].medicalCertificate[index],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    );
                                  },),
                              ),
                            ),


                          ],
                        ),
                      ),
                    ],
                  )
                ])
            ),
          ],
        );
      },),
    );
  }

}



class FullScreenImage extends StatelessWidget {
  final List<dynamic> imageUrl;
  String? tag;
  final int itemcountt;
  final int index;

  FullScreenImage({required this.imageUrl, this.tag, required this.itemcountt, required this.index});

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();

    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: tag ?? "",
            child: PhotoViewGallery.builder(
              itemCount: itemcountt,
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage("${Config.baseurl}${imageUrl[index]}"),
                );
              },
              pageController: PageController(initialPage: index),
              onPageChanged: (index) {

              },
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

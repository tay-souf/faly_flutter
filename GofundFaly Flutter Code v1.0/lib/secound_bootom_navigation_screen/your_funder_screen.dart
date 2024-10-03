// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, unused_field, prefer_final_fields, avoid_print

import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gofunds/common/common_button.dart';
import 'package:gofunds/common/config.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../app_screen/featured_details_screen.dart';
import '../common/home_controoler.dart';
import '../common/light_dark_mode.dart';
import '../controller/getapi_controller.dart';
import '../controller/login_controller.dart';
import '../demo_screen.dart';

class Your_Funder_Screen extends StatefulWidget {
  final String id;
  final bool isComplete;
  const Your_Funder_Screen({super.key, required this.id, required this.isComplete});

  @override
  State<Your_Funder_Screen> createState() => _Your_Funder_ScreenState();
}

class _Your_Funder_ScreenState extends State<Your_Funder_Screen> {

  double _currentSliderValue = 20;
  HomeController homeController = Get.put(HomeController());


  FundDidWiseController fundDidWiseController = Get.put(FundDidWiseController());
  FundCompleteApiController fundCompleteApiController = Get.put(FundCompleteApiController());

  FundCacelApiController fundCacelApiController = Get.put(FundCacelApiController());

  @override
  void initState() {
    super.initState();
    fundDidWiseController.isLoading = true;
    datagetfunction();
  }

  var userdata;
  var currency1;

  // Home,My_Fund

  datagetfunction() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var uid = preferences.getString("userLogin");
    var curr = currency1 = preferences.getString("currenci");
    userdata = jsonDecode(uid!);
    currency1 = jsonDecode(curr!);

    print(" + + + +lghlhgsgs + + + + + :--------  ${widget.id}");
    fundDidWiseController.funddidApi(uid: userdata['id'], fundid: widget.id,status: "My_Fund");
  }

  final CarouselController _controller = CarouselController();
  int _current = 0;

  ColorNotifier notifier = ColorNotifier();
  TextEditingController cancelcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return Scaffold(
      backgroundColor: notifier.background,
      appBar: AppBar(
        toolbarHeight: 30,
        backgroundColor:  notifier.background,
        elevation: 0,
        centerTitle: true,
        iconTheme:  IconThemeData(
            color: notifier.textcolore,
        ),
      ),
      bottomNavigationBar: fundDidWiseController.isLoading ? Center(child: CircularProgressIndicator(color: theamcolore)) :  widget.isComplete ? double.parse(fundDidWiseController.fundidimodel!.funddata[0].remainAmt) <= 0 ? Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 90),
        child: CommonButton(containcolore: theamcolore, txt1: 'Complete'.tr, context: context,onPressed1: () {
          fundCompleteApiController.fundcomplteapi(fund_id: widget.id, uid: userdata['id']);
        }
        ),
      ) :
      (fundDidWiseController.fundidimodel!.funddata[0].remainAmt.toString() == fundDidWiseController.fundidimodel!.funddata[0].fundAmt) ? Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 90),
        child: CommonButton(containcolore: cancelbutton, txt1: 'Cancel'.tr, context: context,onPressed1: () {

          Get.bottomSheet(
            StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: 200,
                decoration: BoxDecoration(
                  color: notifier.background,
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10)),
                ),
                child:  Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      TextFormField(
                        style: TextStyle(color: notifier.textcolore),
                        controller: cancelcontroller,
                        maxLines: 4,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.withOpacity(0.4)),borderRadius: BorderRadius.circular(10)),
                          disabledBorder: OutlineInputBorder(borderSide:BorderSide(color: Colors.grey.withOpacity(0.4)),borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.withOpacity(0.4)),borderRadius: BorderRadius.circular(10)),
                          hintText: "Enter Cancel Reason".tr,
                          hintStyle: TextStyle(color: notifier.textcolore,fontSize: 13),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              style: ButtonStyle(fixedSize: WidgetStatePropertyAll(Size(Get.width, 50)),side: MaterialStatePropertyAll(BorderSide(color: Colors.grey.withOpacity(0.4))),elevation: const MaterialStatePropertyAll(0),shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),backgroundColor: const MaterialStatePropertyAll(Colors.white)),
                              onPressed: () => Navigator.pop(context),
                              child: Text('Cancel'.tr,style: const TextStyle(color: Colors.black)),
                            ),
                          ),
                          const SizedBox(width: 10,),
                          Expanded(
                            child: ElevatedButton(
                              style: ButtonStyle(fixedSize: WidgetStatePropertyAll(Size(Get.width, 50)),elevation: const MaterialStatePropertyAll(0),shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),backgroundColor:  MaterialStatePropertyAll(theamcolore)),
                              onPressed: () => {
                                cancelcontroller.text.isEmpty ?
                                Fluttertoast.showToast(
                                  msg: "Please Enter Reason",
                                )
                                    :  fundCacelApiController.fundcancelapi(fund_id: widget.id, uid: userdata['id'], reject_comment: cancelcontroller.text),
                              },
                              child: Text('proceed'.tr,style: const TextStyle(color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
          );
        }),
      )  : const SizedBox() : null,
      body: GetBuilder<FundDidWiseController>(builder: (fundDidWiseController) {
        return fundDidWiseController.isLoading ? Center(child: CircularProgressIndicator(color: theamcolore)) : Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Your fundraiser'.tr,style: TextStyle(fontSize: 20,color: notifier.textcolore),),
                const SizedBox(height: 5,),
                Text('$currency1${double.parse(fundDidWiseController.fundidimodel!.funddata[0].remainAmt.toString()).toStringAsFixed(2)}',style: TextStyle(fontSize: 16,fontFamily: "SofiaProBold",color: theamcolore),),
                const SizedBox(height: 10,),
                Stack(
                  children: [
                    CarouselSlider(
                      items: [
                        for(int a=0; a<fundDidWiseController.fundidimodel!.funddata[0].fundPhotos.length; a++) Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 200,
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(image: NetworkImage(Config.baseurl + fundDidWiseController.fundidimodel!.funddata[0].fundPhotos[a]),fit: BoxFit.cover),
                                  ),
                                  // child: Image.network(imgList[a],fit: BoxFit.fill),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                      carouselController: _controller,
                      options: CarouselOptions(
                        viewportFraction: 1,
                          height: 230,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          aspectRatio: 2.0,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          }),
                    ),
                    Positioned(
                      bottom: 50,
                      right: 0,
                      left: 0,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: fundDidWiseController.fundidimodel!.funddata[0].fundPhotos.asMap().entries.map((entry) {
                              return GestureDetector(
                                onTap: () => _controller.animateToPage(entry.key),
                                child: Container(
                                  width: 8,
                                  height: 8,
                                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: (_current == entry.key ? theamcolore : Colors.white)),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Text(fundDidWiseController.fundidimodel!.funddata[0].title,style:  TextStyle(color: notifier.textcolore,fontFamily: "SofiaProBold",fontSize: 16),),
                fundDidWiseController.fundidimodel!.funddata[0].remainAmt == 0 ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: 3,
                  margin: const EdgeInsets.only(top: 15,bottom: 15),
                  decoration: BoxDecoration(
                    color: theamcolore,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ) : GetBuilder<CatWiseFundController> (
                    builder: (catWiseFundController) {
                      return MyWidgetSlider((double.parse(fundDidWiseController.fundidimodel!.funddata[0].remainAmt) + double.parse(fundDidWiseController.fundidimodel!.funddata[0].totalInvestment) ).toString(),fundDidWiseController.fundidimodel!.funddata[0].totalInvestment.toString());
                    }
                ),

                const SizedBox(height: 10,),
                Text('Posted By'.tr,style: TextStyle(color: notifier.textcolore,fontSize: 16,fontFamily: "SofiaProBold")),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Center(child: Image(image: const AssetImage('assets/user.png'),color: theamcolore,height: 20,width: 20,)),
                  ),
                  title: Text(fundDidWiseController.fundidimodel!.funddata[0].patientTitle,style: TextStyle(color: notifier.textcolore,fontSize: 14,fontWeight: FontWeight.bold)),
                  subtitle: Text(fundDidWiseController.fundidimodel!.funddata[0].patientDiagnosis,style: const TextStyle(color: Colors.grey,fontSize: 12)),
                ),

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
                      title: Text(fundDidWiseController.fundidimodel!.funddata[0].charityName,style: TextStyle(color: notifier.textcolore,fontSize: 14,fontWeight: FontWeight.bold)),
                      subtitle: Text(fundDidWiseController.fundidimodel!.funddata[0].charityTinno,style: const TextStyle(color: Colors.grey,fontSize: 12)),
                    ),
                  ],
                ),

                Divider(color: Colors.grey.withOpacity(0.4),),
                const SizedBox(height: 10,),
                Text(fundDidWiseController.fundidimodel!.funddata[0].fundPlan,style: TextStyle(fontSize: 12,color: notifier.textcolore),),
                const SizedBox(height: 10,),
                Divider(color: Colors.grey.withOpacity(0.4),),
                const SizedBox(height: 10,),
                Text(fundDidWiseController.fundidimodel!.funddata[0].fundStory.replaceAll("\\n", "\n"),maxLines: 50,overflow: TextOverflow.ellipsis,style:  TextStyle(fontSize: 12,color: notifier.textcolore)),
                const SizedBox(height: 10,),
                Divider(color: Colors.grey.withOpacity(0.4),),
                const SizedBox(height: 10,),
                fundDidWiseController.fundidimodel!.fundupdate.isEmpty ? const SizedBox() :  Text('Updates (${fundDidWiseController.fundidimodel!.fundupdate.length})',style:  TextStyle(fontFamily: "SofiaProBold",color: notifier.textcolore,fontSize: 16),),
                const SizedBox(height: 20,),
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
                                                      imageUrl:
                                                      fundDidWiseController.fundidimodel!.fundupdate[i].photo,
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
                const SizedBox(height: 80,),
              ],
            ),
          ),
        );
      },)
    );
  }
}

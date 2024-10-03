// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, avoid_print, unused_local_variable

import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:gofunds/app_screen/featured_details_screen.dart';
import 'package:gofunds/app_screen/search_screen.dart';
import 'package:gofunds/app_screen/top_up_screen.dart';
import 'package:gofunds/common/common_button.dart';
import 'package:gofunds/controller/login_controller.dart';
import 'package:gofunds/demo_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app_screen/account_screen.dart';
import '../common/config.dart';
import '../common/light_dark_mode.dart';

bool? boolValue;

var lathome;
var longhome;
var addresshome;

class home_screen extends StatefulWidget {
  const home_screen({super.key});

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {

  int _current = 0;

  final CarouselController _controller = CarouselController();

  final List<String> imgList = [
    'https://images.pexels.com/photos/1761279/pexels-photo-1761279.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/1761279/pexels-photo-1761279.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/1761279/pexels-photo-1761279.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/1761279/pexels-photo-1761279.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/1761279/pexels-photo-1761279.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/1761279/pexels-photo-1761279.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
  ];



  int selectIndex = 0;
  int allIndex = 0;


  HomeApiController homeApiController = Get.put(HomeApiController());
  CatWiseFundController catWiseFundController = Get.put(CatWiseFundController());
  SearchFundeController searchFundeController = Get.put(SearchFundeController());
  NotificationApiController notificationApiController = Get.put(NotificationApiController());

  @override
  void initState() {
    print("**********:::::----- (${boolValue})");
    datagetfunction();
    super.initState();
  }


  fun() async{
    await Future.delayed(const Duration(milliseconds: 800),() {
      common();
    },

    );
  }

  var userdata;
  var currency1;
  var walletevarable;
  String usernameu = "";

  Future datagetfunction() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var uid = preferences.getString("userLogin");

    boolValue = preferences.getBool('guestlogin');
    if(boolValue != true){
      userdata = jsonDecode(uid!);
      usernameu = userdata["name"];
      print('+ + + + + + + + fbjahfvj :----- $uid');
      print('+ + + + + + + + fbjahhhhhhhhhhhhhfvj :----- $usernameu');
      setState(() {
      });
    }else{

    }

    notificationApiController.notificationapi(uid: boolValue == true ? "0" : userdata['id']);

    getCurrentLatAndLong().then((value) {
      setState(() {

        homeApiController.homeApi(uid: boolValue == true ? "0" : userdata['id'],latitude: lathome.toString(),logitude: longhome.toString()).then((value) {

          var curr = preferences.getString("currenci");
          currency1 = jsonDecode(curr!);

          preferences.setDouble("walleteeammount", double.parse(homeApiController.homeapimodel!.wallet));
          var wall = preferences.getDouble("walleteeammount");
          walletevarable = jsonEncode(wall!);
          print("::::::::::::::::::::::::::----------------------- ${double.parse(walletevarable)}");
          setState(() {
          });

        });

      });
    });


    catWiseFundController.catwise(cat_id: "0", uid: boolValue == true ? "0" : userdata['id']);
    print("*********:--(${userdata['name']})");

  }

  double totaldonation = 0.0;

  ColorNotifier notifier = ColorNotifier();

 Future getCurrentLatAndLong() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      if (Platform.isAndroid) {
        SystemNavigator.pop();
      } else if (Platform.isIOS) {
        exit(0);
      }
    }

    var currentLocation = await locateUser();
    List<Placemark> addresses = await placemarkFromCoordinates(currentLocation.latitude, currentLocation.longitude);
    await placemarkFromCoordinates(currentLocation.latitude, currentLocation.longitude).then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      addresshome = '${placemarks.first.name!.isNotEmpty ? '${placemarks.first.name!},' : ''}${placemarks.first.locality!.isNotEmpty ? '${placemarks.first.locality!},' : ''}${placemarks.first.subAdministrativeArea!.isNotEmpty ? '${placemarks.first.subAdministrativeArea!},' : ''}${placemarks.first.administrativeArea!.isNotEmpty ? placemarks.first.administrativeArea : ''}';
    });
    setState(() {
      print("****** addresses user ****** $addresshome");
      lathome = currentLocation.latitude;
      longhome = currentLocation.longitude;
      print("****** lathome user ****** $lathome");
      print("****** longhome user ****** $longhome");
    });
  }

  Future<Position> locateUser() async {
    return Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   homeApiController.isLoading = true;
  // }

  Future<void> _refresh() async {
    Future.delayed(const Duration(milliseconds: 100),() {
      setState(() {
        homeApiController.homeApi(uid: boolValue == true ? "0" : userdata['id'],latitude: lathome.toString(),logitude: longhome.toString());
        print("++++++ refresh ++++++");
      });
    },);
  }

  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: notifier.background,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Transform.translate(offset: const Offset(-15, 0),child: Text('GoFund'.tr,style: TextStyle(fontSize: 23,fontFamily: "SofiaProBold",color: theamcolore),)),
            Transform.translate(offset: const Offset(-15, 0),child: Text('Change Lives Today'.tr,style: TextStyle(fontSize: 9,fontFamily: "SofiaProBold",color: theamcolore),)),
          ],
        ),
        leading: Padding(padding: const EdgeInsets.all(8.0),
        child: SvgPicture.asset("assets/applogo.svg",height: 30,width: 30,),
        ),
        actions: [
          addresshome == null ? const SizedBox() : Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                print("Address:-- ($addresshome)");
                print("$lathome");
                print("$longhome");
              },
              child: Container(
                height: 40,
                width: 170,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.withOpacity(0.4)),
                    borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Image.asset("assets/locationiconborder.png",height: 16,width: 16,color: notifier.textcolore,),
                      // Icon(Icons.location_on_outlined,color: notifier.textcolore,size: 16),
                      const SizedBox(width: 5,),
                      Flexible(child: Text("$addresshome",style: TextStyle(color: notifier.textcolore,fontSize: 12),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: notifier.background,
      body: GetBuilder<HomeApiController>(builder: (homeApiController) {
        return homeApiController.isLoading ? Center(child: CircularProgressIndicator(color: theamcolore)) : GetBuilder<HomeApiController>(
          builder: (homeApiController) {
            return RefreshIndicator(
              color: theamcolore,
              onRefresh: _refresh,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10,),
                    boolValue == true ? Padding(
                      padding: const EdgeInsets.only(left: 15,right: 15),
                      child: Text('Good Morning!'.tr,style: TextStyle(color: notifier.textcolore,fontSize: 16),),
                    ) : Padding(
                      padding: const EdgeInsets.only(left: 15,right: 15),
                      child: Text('Hello! $usernameu',style: TextStyle(color: notifier.textcolore,fontSize: 16),),
                    ),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(left: 15,right: 15),
                      child: Text('Together we can'.tr,style: TextStyle(color: notifier.textcolore,fontSize: 20,fontFamily: "SofiaProBold"),),
                    ),
                    const SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.only(left: 15,right: 15),
                      child: Container(
                        decoration: BoxDecoration(
                            color: notifier.containercolore,
                            borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Search_Screen(palteformfee: homeApiController.homeapimodel!.plaform_free,walletamount: homeApiController.homeapimodel!.wallet,),));
                          },
                          readOnly: true,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(top: 16),
                              enabledBorder: const UnderlineInputBorder(borderSide: BorderSide.none),
                              focusedBorder: const UnderlineInputBorder(borderSide: BorderSide.none),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Image.asset("assets/searchicon.png",height: 20,width: 20,color: notifier.textcolore,),
                              ),
                              hintText: 'Search by charity or cause'.tr,
                              hintStyle: TextStyle(color: notifier.textcolore)
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    boolValue == true ? const SizedBox() : Padding(
                      padding: const EdgeInsets.only(left: 15,right: 15),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Available To Donate".tr,style: TextStyle(color: notifier.textcolore,fontSize: 16),),
                              const SizedBox(height: 10,),
                               Text("${currency1 ?? homeApiController.homeapimodel!.currency} ${homeApiController.homeapimodel!.wallet}",style: TextStyle(color: notifier.textcolore,fontSize: 24),),
                            ],
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const Top_up(),));
                            },
                            child: Container(
                              width: 130,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: theamcolore,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(Icons.add,color: theamcolore,),
                                  ),
                                  const SizedBox(width: 10,),
                                  Text("Top-up".tr,style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20,),
                    homeApiController.homeapimodel!.banner.isEmpty ? const SizedBox() :
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        CarouselSlider(
                          items: [
                            for(int a=0; a<homeApiController.homeapimodel!.banner.length; a++) Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  details_screen(palteformfee: homeApiController.homeapimodel!.plaform_free,walletamount: homeApiController.homeapimodel!.wallet,id: homeApiController.homeapimodel!.banner[a].id,remainAmt: "${homeApiController.homeapimodel!.banner[a].remainAmt}",totalInvestment: homeApiController.homeapimodel!.banner[a].totalInvestment),));
                                  },
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Container(
                                        height: 200,
                                        width: MediaQuery.of(context).size.width,
                                        margin: const EdgeInsets.only(right: 10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(20),
                                          child: FadeInImage.assetNetwork(
                                            placeholder: "assets/gfimage.png",
                                            placeholderCacheWidth: 290,
                                            placeholderCacheHeight: 270,
                                            image: Config.baseurl + homeApiController.homeapimodel!.banner[a].fundPhotos,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        child: Container(
                                          height: 300,
                                          width: MediaQuery.of(context).size.width / 1.29,
                                          decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              stops: [0.7, 1, 1.5],
                                              colors: [
                                                Colors.transparent,
                                                Colors.black87,
                                                Colors.black87,
                                              ],
                                            ),
                                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20)),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 30,
                                        left: 10,
                                        child: Text(homeApiController.homeapimodel!.banner[a].title,style: const TextStyle(fontSize: 18,fontFamily: "SofiaProBold",color: Colors.white)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                          carouselController: _controller,
                          options: CarouselOptions(
                              height: 240,
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
                          bottom: 45,
                          right: 0,
                          left: 0,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: homeApiController.homeapimodel!.banner.asMap().entries.map((entry) {
                                  return GestureDetector(
                                    onTap: () => _controller.animateToPage(entry.key),
                                    child: Container(
                                      width: 8,
                                      height: 8,
                                      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: (_current == entry.key ? theamcolore : Colors.white),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // homeApiController.homeapimodel!.banner.isEmpty ? const SizedBox(height: 20) :   const SizedBox(),
                    Transform.translate(
                      offset: const Offset(0, -20),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15,right: 15,bottom: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Featured stories'.tr,style: TextStyle(color: notifier.textcolore,fontFamily: "SofiaProBold",fontSize: 18),),
                            const SizedBox(height: 20,),
                            GetBuilder<CatWiseFundController>(builder: (catWiseFundController) {
                              return SizedBox(
                                height: 45,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            selectIndex = 0;
                                            catWiseFundController.catwise(cat_id: "0", uid: userdata['id']);
                                          });
                                        },
                                        child: Container(
                                          height: 130,
                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: selectIndex == 0 ? theamcolore: Colors.grey.withOpacity(0.4)),
                                            borderRadius: BorderRadius.circular(10),
                                            color: selectIndex == 0 ? theamcolore : Colors.transparent,
                                          ),
                                          child: Column(
                                            children: [
                                              Icon(Icons.more_horiz,color: selectIndex == 0 ? Colors.white : notifier.textcolore),
                                              Transform.translate(offset: const Offset(0, -3),child: Text("All".tr, style: TextStyle(fontWeight: selectIndex == 0 ? FontWeight.bold : FontWeight.normal,fontSize: 14, color: selectIndex == 0 ? Colors.white : notifier.textcolore), overflow: TextOverflow.ellipsis,)),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10,),
                                      ListView.separated(
                                        shrinkWrap: true,
                                        itemCount: homeApiController.homeapimodel!.category.length,
                                        scrollDirection: Axis.horizontal,
                                        separatorBuilder: (context, index) {
                                          return const SizedBox(width: 10,);
                                        },
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                selectIndex = index + 1;
                                                catWiseFundController.categryWiseFund!.catwisefund?.clear();
                                                catWiseFundController.catwise(cat_id: homeApiController.homeapimodel!.category[index].id, uid: userdata['id']).then((value) {
                                                  setState(() {
                                                  });
                                                });
                                              });
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 10,),
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(
                                                border: Border.all(color: selectIndex == index + 1 ? theamcolore: Colors.grey.withOpacity(0.4)),
                                                borderRadius: BorderRadius.circular(10),
                                                color: selectIndex == index +1  ? theamcolore : Colors.transparent,
                                              ),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(homeApiController.homeapimodel!.category[index].title.toString().split(" ").first, style: TextStyle(fontWeight: selectIndex == index+1 ? FontWeight.bold : FontWeight.normal,fontSize: 14, color: selectIndex == index+1 ? Colors.white : notifier.textcolore), overflow: TextOverflow.ellipsis,),
                                                  Text(homeApiController.homeapimodel!.category[index].title.toString().split(" ").last, style: TextStyle(fontWeight: selectIndex == index+1 ? FontWeight.bold : FontWeight.normal,fontSize: 14, color: selectIndex == index+1 ? Colors.white : notifier.textcolore), overflow: TextOverflow.ellipsis,),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },),
                            const SizedBox(height: 20,),
                            GetBuilder<CatWiseFundController>(builder: (catWiseFundController) {
                              return SizedBox(
                                height: 383,
                                child: ListView.separated(
                                    separatorBuilder: (context, index) {
                                      return const SizedBox(height: 0);
                                    },
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: catWiseFundController.categryWiseFund!.catwisefund!.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) =>  details_screen(palteformfee: homeApiController.homeapimodel!.plaform_free,walletamount: homeApiController.homeapimodel!.wallet,id: "${catWiseFundController.categryWiseFund!.catwisefund?[index].id}",remainAmt: "${catWiseFundController.categryWiseFund!.catwisefund?[index].remainAmt}",totalInvestment: "${catWiseFundController.categryWiseFund!.catwisefund?[index].totalInvestment}"),));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(right: 10),
                                          child: Container(
                                            height: 50,
                                            width: 270,
                                            decoration: BoxDecoration(
                                              color: notifier.containercolore,
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 200,
                                                  decoration: const BoxDecoration(
                                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                                                    child: FadeInImage.assetNetwork(
                                                      placeholder: "assets/gfimage.png",
                                                      placeholderCacheWidth: 290,
                                                      placeholderCacheHeight: 270,
                                                      width: 270,
                                                      image: "${Config.baseurl}${catWiseFundController.categryWiseFund!.catwisefund![index].fundPhotos?[0]}",
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      const SizedBox(height: 10,),
                                                      Text("${catWiseFundController.categryWiseFund!.catwisefund?[index].title}",style:  TextStyle(fontSize: 20,fontFamily: "SofiaProBold",color: notifier.textcolore),maxLines: 1,overflow: TextOverflow.ellipsis,),
                                                      const SizedBox(height: 10,),
                                                      Row(
                                                        children: [
                                                          Text('Raised'.tr,style: const TextStyle(color: Colors.grey,fontSize: 12),),
                                                          const Spacer(),
                                                          Text('Funds Required'.tr,style: const TextStyle(color: Colors.grey,fontSize: 12),),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 5,),
                                                      Row(
                                                        children: [
                                                          Text('${currency1 ?? "${homeApiController.homeapimodel!.currency}"} ${double.parse(catWiseFundController.categryWiseFund!.catwisefund![index].totalInvestment.toString()).toStringAsFixed(2)}',style:  TextStyle(color: notifier.textcolore,fontFamily: "SofiaProBold",fontSize: 16),),
                                                          const Spacer(),
                                                          Text('${currency1 ?? "${homeApiController.homeapimodel!.currency}"} ${double.parse(catWiseFundController.categryWiseFund!.catwisefund![index].remainAmt.toString()).toStringAsFixed(2)}',style: const TextStyle(color: Colors.red,fontFamily: "SofiaProBold",fontSize: 16),),
                                                        ],
                                                      ),
                                                      catWiseFundController.categryWiseFund!.catwisefund?[index].remainAmt == 0 ? Container(
                                                        width: MediaQuery.of(context).size.width,
                                                        height: 6,
                                                        margin: const EdgeInsets.only(top: 15,bottom: 15),
                                                        decoration: BoxDecoration(
                                                          color: theamcolore,
                                                          borderRadius: BorderRadius.circular(5),
                                                        ),
                                                      ) : GetBuilder<CatWiseFundController>(
                                                          builder: (catWiseFundController) {
                                                            return MyWidgetSlider((catWiseFundController.categryWiseFund!.catwisefund![index].remainAmt! + double.parse("${catWiseFundController.categryWiseFund!.catwisefund?[index].totalInvestment}") ).toString(),catWiseFundController.categryWiseFund!.catwisefund![index].totalInvestment.toString());
                                                          }
                                                      ),

                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [

                                                              catWiseFundController.categryWiseFund!.catwisefund![index].donaterlist!.isEmpty ? Container(
                                                                height: 30,
                                                                width: 30,
                                                                decoration: BoxDecoration(
                                                                  color: Colors.grey.withOpacity(0.1),
                                                                  shape: BoxShape.circle,
                                                                ),
                                                                child: Center(child: Image.asset("assets/donateicon.png",height: 20,width: 20,color: notifier.textcolore,)),
                                                              ) :   SizedBox(
                                                                height: 35,
                                                                child: Padding(
                                                                  padding: const EdgeInsets.only(left: 8.0),
                                                                  child: ListView.builder(
                                                                    shrinkWrap: true,
                                                                    scrollDirection: Axis.horizontal,
                                                                    itemCount: catWiseFundController.categryWiseFund!.catwisefund?[index].donaterlist?.length,
                                                                    itemBuilder: (context, index1) {
                                                                      return index1 < 3 ? SizedBox(
                                                                        height: 50,
                                                                        width: 20,
                                                                        child: Stack(
                                                                          clipBehavior: Clip.none,
                                                                          children: [

                                                                            catWiseFundController.categryWiseFund!.catwisefund![index].donaterlist?[index1].profilePic == null ? Positioned(
                                                                              left: -10,
                                                                              child: Container(
                                                                                height: 30,
                                                                                width: 30,
                                                                                decoration:  BoxDecoration(
                                                                                  color: notifier.background,
                                                                                  shape: BoxShape.circle,
                                                                                  border: Border.all(color: Colors.grey.withOpacity(0.4),width: 2),
                                                                                ),
                                                                                child: Center(child: Text("${ boolValue == true ? "K" : userdata['name'][0]}")),
                                                                              ),
                                                                            ) :  Positioned(
                                                                              left: -10,
                                                                              child: Container(
                                                                                height: 30,
                                                                                width: 30,
                                                                                decoration: BoxDecoration(
                                                                                  shape: BoxShape.circle,
                                                                                  image: DecorationImage(image: NetworkImage('${Config.baseurl}${catWiseFundController.categryWiseFund!.catwisefund![index].donaterlist?[index1].profilePic}'),fit: BoxFit.cover),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ) : const SizedBox();
                                                                    },),
                                                                ),
                                                              ),

                                                              catWiseFundController.categryWiseFund!.catwisefund![index].donaterlist!.isEmpty ? Padding(
                                                                padding: const EdgeInsets.only(top: 5),
                                                                child: Text('Be the first to donate'.tr,style: TextStyle(color: notifier.textcolore)),
                                                              ) : Row(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                children: [
                                                                  Text('${catWiseFundController.categryWiseFund!.catwisefund?[index].donaterlist?.length}',style: TextStyle(color: notifier.textcolore)),
                                                                  Text(' people donated'.tr,style: TextStyle(color: notifier.textcolore)),
                                                                ],
                                                              )
                                                            ],
                                                          ),

                                                          Column(
                                                            children: [
                                                              Container(
                                                                height: 40,
                                                                width: 100,
                                                                decoration: BoxDecoration(
                                                                    color: theamcolore,
                                                                    borderRadius: BorderRadius.circular(20)
                                                                ),
                                                                child:  Padding(
                                                                  padding: const EdgeInsets.all(12),
                                                                  child: Center(child: Text('Donate'.tr,style: const TextStyle(color: Colors.white,fontFamily: "SofiaProBold",fontSize: 14),)),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),

                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              );
                            },),
                          ],
                        ),
                      ),
                    ),
              
                    homeApiController.homeapimodel!.listnearby.isEmpty ? const SizedBox() : Transform.translate(
                      offset: const Offset(0, -20),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15,right: 15,bottom: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('Nearby'.tr,style: TextStyle(color: notifier.textcolore,fontFamily: "SofiaProBold",fontSize: 18),),
                                const Spacer(),
                              ],
                            ),
                            const SizedBox(height: 15,),
                            GetBuilder<CatWiseFundController>(builder: (catWiseFundController) {
                              return SizedBox(
                                height: 220,
                                child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: homeApiController.homeapimodel?.listnearby.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) =>  details_screen(palteformfee: homeApiController.homeapimodel!.plaform_free,walletamount: homeApiController.homeapimodel!.wallet,id: homeApiController.homeapimodel!.listnearby[index].id,remainAmt: "${homeApiController.homeapimodel?.listnearby[index].remainAmt}",totalInvestment: homeApiController.homeapimodel!.listnearby[index].totalInvestment),));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(right: 10),
                                          child: Container(
                                            height: 50,
                                            width: 150,
                                            decoration: BoxDecoration(
                                              color: notifier.containercolore,
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Stack(
                                              alignment: Alignment.bottomLeft,
                                              children: [
                                                Container(
                                                  height: 220,
                                                  decoration: const BoxDecoration(
                                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                                  ),
                                                 child: ClipRRect(
                                                   borderRadius: BorderRadius.circular(10),
                                                   child: FadeInImage.assetNetwork(
                                                     placeholder: "assets/gfimage.png",
                                                     placeholderCacheWidth: 290,
                                                     placeholderCacheHeight: 270,
                                                     image:
                                                     "${Config.baseurl}${homeApiController.homeapimodel?.listnearby[index].fundPhotos[0]}",
                                                     fit: BoxFit.cover,
                                                   ),
                                                 ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(10),
                                                    child: Container(
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                        color: Colors.black.withOpacity(0.6),
                                                        borderRadius: BorderRadius.circular(10),
                                                      ),
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(4.0),
                                                        child: Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            Image.asset("assets/locationiconborder.png",height: 15,width: 15,color: Colors.white,),
                                                            const SizedBox(width: 5,),
                                                            Text("${homeApiController.homeapimodel?.listnearby[index].fundDistance}",style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 10),),
                                                            const SizedBox(width: 5,),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              );
                            },),
                          ],
                        ),
                      ),
                    ),
                    homeApiController.homeapimodel!.popularFund.isEmpty ? const SizedBox() : Transform.translate(
                      offset: const Offset(0, -20),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15,right: 15),
                        child: Text('Popular now'.tr,style: TextStyle(color: notifier.textcolore,fontFamily: "SofiaProBold",fontSize: 18)),
                      ),
                    ),
                    const SizedBox(height: 15,),
                    homeApiController.homeapimodel!.popularFund.isEmpty ? const SizedBox() : Transform.translate(
                      offset: const Offset(0, -20),
                      child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 15);
                          },
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: homeApiController.homeapimodel!.popularFund.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>  details_screen(palteformfee: homeApiController.homeapimodel!.plaform_free,walletamount: homeApiController.homeapimodel!.wallet,id: homeApiController.homeapimodel!.popularFund[index].id,remainAmt: "${homeApiController.homeapimodel!.popularFund[index].remainAmt}",totalInvestment: homeApiController.homeapimodel!.popularFund[index].totalInvestment),));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15,right: 15),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: notifier.containercolore,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 150,
                                        width: Get.width,
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
                                            "${Config.baseurl}${homeApiController.homeapimodel!.popularFund[index].fundPhotos[0]}",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                height: 35,
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  scrollDirection: Axis.horizontal,
                                                  itemCount: homeApiController.homeapimodel!.popularFund[index].donaterlist.length,
                                                  itemBuilder: (context, index1) {
                                                    return  index1 < 3? SizedBox(
                                                      height: 50,
                                                      width: 20,
                                                      child: Stack(
                                                        clipBehavior: Clip.none,
                                                        children: [
                                                          homeApiController.homeapimodel!.popularFund[index].donaterlist[index1].profilePic == null ?  Positioned(
                                                            left: 10,
                                                            child: Container(
                                                              height: 30,
                                                              width: 30,
                                                              decoration:  const BoxDecoration(
                                                                color: Colors.white,
                                                                  shape: BoxShape.circle,
                                                              ),
                                                              child: Center(child: Text("${ boolValue == true ? "K" :  userdata['name'][0]}")),
                                                            ),
                                                          ) :  rtl ?  Positioned(
                                                            // left: 10,
                                                            right: 10,
                                                            child: Container(
                                                              height: 30,
                                                              width: 30,
                                                              decoration:  BoxDecoration(
                                                                  shape: BoxShape.circle,
                                                                  image: DecorationImage(image: NetworkImage('${Config.baseurl}${homeApiController.homeapimodel!.popularFund[index].donaterlist[index1].profilePic}'),fit: BoxFit.cover)
                                                              ),
                                                            ),
                                                          ) : Positioned(
                                                            left: 10,
                                                            // right: rtl ? 10 : 0,
                                                            child: Container(
                                                              height: 30,
                                                              width: 30,
                                                              decoration:  BoxDecoration(
                                                                  shape: BoxShape.circle,
                                                                  image: DecorationImage(image: NetworkImage('${Config.baseurl}${homeApiController.homeapimodel!.popularFund[index].donaterlist[index1].profilePic}'),fit: BoxFit.cover)
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ) : const SizedBox();
                                                  },),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 20,right: 20),
                                                child: Text("  ${homeApiController.homeapimodel!.popularFund[index].donaterlist.length} people donated",style: TextStyle(color: notifier.textcolore)),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(height: 5,),
                                                Text(homeApiController.homeapimodel!.popularFund[index].title,style: TextStyle(color: notifier.textcolore,fontFamily: "SofiaProBold",fontSize: 14),maxLines: 1,overflow: TextOverflow.ellipsis,),
                                                homeApiController.homeapimodel!.popularFund[index].remainAmt == 0 ? Transform.translate(
                                                  offset: const Offset(0, -5),
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 4.0,right: 4.0),
                                                    child: Container(
                                                      width: MediaQuery.of(context).size.width,
                                                      height: 6,
                                                      margin: const EdgeInsets.only(top: 15,bottom: 15),
                                                      decoration: BoxDecoration(
                                                        color: theamcolore,
                                                        borderRadius: BorderRadius.circular(5),
                                                      ),
                                                    ),
                                                  ),
                                                ) : Transform.translate(offset: const Offset(0, -5),child: MyWidgetSlider((homeApiController.homeapimodel!.popularFund[index].remainAmt + double.parse(homeApiController.homeapimodel!.popularFund[index].totalInvestment) ).toString(),homeApiController.homeapimodel!.popularFund[index].totalInvestment.toString())),
                                                Transform.translate(
                                                  offset: const Offset(0, -10),
                                                  child: Row(
                                                    children: [
                                                      Text("Raised".tr,style: TextStyle(color: notifier.textcolore)),
                                                      const Spacer(),
                                                      homeApiController.homeapimodel!.popularFund[index].remainAmt == 0 ?  Text("Complete".tr,style: TextStyle(color: notifier.textcolore)) :   Text("${(double.parse(homeApiController.homeapimodel!.popularFund[index].totalInvestment) / (homeApiController.homeapimodel!.popularFund[index].remainAmt + double.parse(homeApiController.homeapimodel!.popularFund[index].totalInvestment)) * 100).toStringAsFixed(2)}%",style: TextStyle(color: notifier.textcolore)),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            );
          }
        );
      },),
    );
  }



  Future<void> common(){
   return showDialog<void>(
     context: context,
     builder: (BuildContext context) {
       return AlertDialog(
         title: Text('Basic dialog title'.tr),
         content: Text(
           'A dialog is a type of modal window that\n'
               'appears in front of app content to\n'
               'provide critical information, or prompt\n'
               'for a decision to be made.'.tr,
         ),
         actions: <Widget>[
           TextButton(
             style: TextButton.styleFrom(
               textStyle: Theme.of(context).textTheme.labelLarge,
             ),
             child: Text('Disable'.tr),
             onPressed: () {
               Navigator.of(context).pop();
             },
           ),
           TextButton(
             style: TextButton.styleFrom(
               textStyle: Theme.of(context).textTheme.labelLarge,
             ),
             child: Text('Enable'.tr),
             onPressed: () {
               Navigator.of(context).pop();
             },
           ),
         ],
       );
     },
   );
  }


}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight;
    final trackLeft = offset.dx;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}

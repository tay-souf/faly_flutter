// ignore_for_file: camel_case_types, depend_on_referenced_packages, file_names

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:gofunds/common/common_button.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_screen/onboarding_screen.dart';
import 'auth_screen/push_notification.dart';
import 'bootom_navigation_screen/bottom_navigation_bar.dart';

class Splase_Screen extends StatefulWidget {
  const Splase_Screen({super.key});

  @override
  State<Splase_Screen> createState() => _Splase_ScreenState();
}

class _Splase_ScreenState extends State<Splase_Screen> {

  bool? isLogin;

  @override
  void initState() {
    super.initState();
    initPlatformState(context: context).then((value) {
      getCurrentLatAndLong();
    },);

  }



  Future getCurrentLatAndLong() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      if (Platform.isAndroid) {
        // SystemNavigator.pop();
      } else if (Platform.isIOS) {
        exit(0);
      }
    }else{
      getDataFromLocal().then((value) {
        if(isLogin!){
          Timer(const Duration(seconds: 3), () {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => BoardingPage(),), (route) => false);
          });
        } else{
          Timer(const Duration(seconds: 3), () {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>  const Bottom_Navigation(),), (route) => false);
          });
        }
      });
    }
  }


  Future<Position> locateUser() async {
    return Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/applogo.svg",height: 50,width: 50,),
            const SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('GoFund'.tr,style: TextStyle(color: theamcolore,fontSize: 25,fontFamily: 'SofiaProBold'),),
                Text('Donation App'.tr,style: TextStyle(color: theamcolore,fontSize: 14,fontFamily: 'SofiaProBold'),),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future getDataFromLocal() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLogin = prefs.getBool("UserLogin") ?? true;
    });
  }

}
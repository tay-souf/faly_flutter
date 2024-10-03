// ignore_for_file: unused_local_variable, camel_case_types

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gofunds/bootom_navigation_screen/home_screen.dart';
import 'package:provider/provider.dart';
import 'common_button.dart';
import 'light_dark_mode.dart';

class Home_SliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final String username;

  Home_SliverAppBar({required this.expandedHeight,required this.username,});
  ColorNotifier notifier = ColorNotifier();

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    final controller = PageController();

    return Container(
      height: 160,
      width: Get.width,
      decoration: BoxDecoration(
        color: notifier.background,
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Stack(
          children: [
            const SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  const Image(image: AssetImage('assets/application_logo.png'),height: 30,width: 30,fit: BoxFit.fill),
                  const SizedBox(width: 15,),
                  Text('K A R M A'.tr,style: TextStyle(fontSize: 16,fontFamily: "SofiaProBold",color: notifier.textcolore),),
                  const Spacer(),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: greaycolore),
                      borderRadius: BorderRadius.circular(30)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.location_on_outlined,color: notifier.textcolore,size: 20),
                          SizedBox(width: 5,),
                          Text("Surat,Gujarat".tr,style: TextStyle(color: notifier.textcolore,fontSize: 14),)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10,),
            boolValue == true ? Positioned(
                bottom: 30,
                child: Opacity(
                    opacity: (1-shrinkOffset/expandedHeight),
                    child:  Text('Good Morning!'.tr,style: TextStyle(color: notifier.textcolore,fontSize: 16),))
            ) :
            Positioned(
              bottom: 30,
              child: Opacity(
                opacity: (1-shrinkOffset/expandedHeight),
                child:  Text('Hello! $username',style: TextStyle(color: notifier.textcolore,fontSize: 16),),
              ),
            ),
            const SizedBox(height: 10,),
            Positioned(
                bottom: 0,
                child: Opacity(
                    opacity: (1-shrinkOffset/expandedHeight),
                    child:  Text('Your home for help'.tr,style: TextStyle(color: notifier.textcolore,fontSize: 20,fontFamily: "SofiaProBold"),))
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => 90;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
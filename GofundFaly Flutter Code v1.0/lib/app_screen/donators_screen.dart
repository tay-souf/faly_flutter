// ignore_for_file: camel_case_types

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gofunds/common/common_button.dart';

class Donater_Screen extends StatefulWidget {
  const Donater_Screen({super.key});

  @override
  State<Donater_Screen> createState() => _Donater_ScreenState();
}

class _Donater_ScreenState extends State<Donater_Screen> {

  List titletext = [
    'Anonymous'.tr,
    'Lisa Anderson'.tr,
    'Thomas Garden'.tr,
    'Anonymous'.tr,
    'Lisa Anderson'.tr,
    'Thomas Garden'.tr,
    'Anonymous'.tr,
    'Lisa Anderson'.tr,
    'Thomas Garden'.tr,
    'Anonymous'.tr,
    'Lisa Anderson'.tr,
    'Thomas Garden'.tr,
    'Anonymous'.tr,
    'Lisa Anderson'.tr,
    'Thomas Garden'.tr,
  ];

  List subtitletext = [
    '\$20',
    '\$10',
    '\$30',
    '\$20',
    '\$10',
    '\$30',
    '\$20',
    '\$10',
    '\$30',
    '\$20',
    '\$10',
    '\$30',
    '\$20',
    '\$10',
    '\$30',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff2C2C2C),
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(Icons.arrow_back_ios_new,color: Colors.white,size: 20)),
        title: Transform.translate(offset: const Offset(-20, 0),child:  Text('Donations (11.6k)'.tr,style: TextStyle(color: Colors.white,fontSize: 18))),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: CommonButtonsmallround(containcolore: theamcolore, txt1: 'Donate'.tr, context: context,onPressed1: () {}),
      ),
      body:  SingleChildScrollView(
        child: Column(
          children: [
            ListView.separated(
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 0);
                },
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                itemCount: subtitletext.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: theamcolore.withOpacity(0.2),
                        shape: BoxShape.circle
                      ),
                      child:  Center(child: Image(image: const AssetImage('assets/user-circle.png'),height: 30,width: 30,color: theamcolore,)),
                    ),
                    title: Text('${titletext[index]}',style: const TextStyle(color: Colors.black)),
                    subtitle: Row(
                      children: [
                        Text('${subtitletext[index]}',style: const TextStyle(color: Colors.black)),
                        const SizedBox(width: 4,),
                        Container(
                          height: 8,
                          width: 8,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey
                          ),
                        ),
                        const SizedBox(width: 4,),
                        Text('3M'.tr,style: TextStyle(color: Colors.black)),
                      ],
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

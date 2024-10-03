import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common/light_dark_mode.dart';
import '../controller/login_controller.dart';

class Notification_Screen extends StatefulWidget {
  const Notification_Screen({super.key});

  @override
  State<Notification_Screen> createState() => _Notification_ScreenState();
}

class _Notification_ScreenState extends State<Notification_Screen> {

  NotificationApiController notificationApiController = Get.put(NotificationApiController());


  @override
  void initState() {
    datagetfunction();
    super.initState();
  }

  var userData;
  bool varload = true;

  datagetfunction() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var uid = preferences.getString("userLogin");
    userData = jsonDecode(uid!);
    print("+++++:---  ${userData['id']}");
    varload = true;

    notificationApiController.notificationapi(uid: userData['id']).then((value) {
      setState(() {
      });
      varload = false;
    },);
  }

  ColorNotifier notifier = ColorNotifier();

  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: notifier.background,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text('Notification'.tr,style: TextStyle(color: notifier.textcolore,fontFamily: "SofiaProBold",fontSize: 18)),
      ),
      backgroundColor: notifier.background,
      body: GetBuilder<NotificationApiController>(builder: (notificationApiController) {
        return notificationApiController.notificatonListAPiModel!.notificationdata.isEmpty ?  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: Text("No new notifications".tr,style: TextStyle(color: notifier.textcolore),)),
            Center(child: Text("Looks like you haven't received any notification".tr,style: TextStyle(color: notifier.textcolore),)),
          ],
        ) : SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 5,);
                  },
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: notificationApiController.notificatonListAPiModel!.notificationdata.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(border: Border.all(color: Colors.grey.withOpacity(0.4)),borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(notificationApiController.notificatonListAPiModel!.notificationdata[index].title,style: TextStyle(color: notifier.textcolore)),
                                      const Spacer(),
                                      Text(notificationApiController.notificatonListAPiModel!.notificationdata[index].datetime.toString().split(" ").first,style: TextStyle(color: Colors.grey)),
                                    ],
                                  ),
                                  const SizedBox(height : 5),
                                  Text(notificationApiController.notificatonListAPiModel!.notificationdata[index].description,style: TextStyle(color: notifier.textcolore),),
                                ],),
                            ),

                          ],
                        ),
                      ),
                    );
                  }) ,
            ],
          ),
        );
      },),
    );
  }
}

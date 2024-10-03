// ignore_for_file: avoid_print, depend_on_referenced_packages, camel_case_types, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gofunds/common/common_button.dart';
import 'package:gofunds/controller/login_controller.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common/light_dark_mode.dart';

class Faq_Screeen extends StatefulWidget {
  const Faq_Screeen({super.key});

  @override
  State<Faq_Screeen> createState() => _Faq_ScreeenState();
}

class _Faq_ScreeenState extends State<Faq_Screeen> {

  FaqApiController faqApiController = Get.put(FaqApiController());

  @override
  void initState() {
    datagetfunction();
    super.initState();
  }

  var userData;

  datagetfunction() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var uid = preferences.getString("userLogin");
    userData = jsonDecode(uid!);

    faqApiController.faqlistapi(uid: userData['id']);
    setState(() {
    });
  }

  ColorNotifier notifier = ColorNotifier();

  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return  Scaffold(
      // backgroundColor: const Color(0xffF5F5F5),
      backgroundColor: notifier.background,
      appBar: AppBar(
        backgroundColor: notifier.background,
        elevation: 0,
        iconTheme: IconThemeData(
          color: notifier.textcolore,
        ),
        title: Text('Faq List'.tr,style:  TextStyle(color: notifier.textcolore,fontSize: 16,fontFamily: 'SofiaProBold')),
      ),
      body: GetBuilder<FaqApiController>(builder: (faqApiController) {
        return faqApiController.isLoading ? Center(child: CircularProgressIndicator(color: theamcolore),) : SingleChildScrollView(
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
                  itemCount: faqApiController.faqApiiimodel!.faqData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: notifier.fagcontainer,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.all(10),
                      child: ExpansionTile(
                        collapsedIconColor: notifier.textcolore,
                        iconColor: notifier.textcolore,
                        textColor: const Color(0xff7D2AFF),
                        title: Text(faqApiController.faqApiiimodel!.faqData[index].question,style:  TextStyle(fontFamily: 'SofiaProBold',color: notifier.textcolore,fontSize: 14)),
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(width: 17,),
                              Expanded(child: Text(faqApiController.faqApiiimodel!.faqData[index].answer,style: TextStyle(color: notifier.textcolore),)),
                              const SizedBox(width: 17,),
                            ],
                          ),
                          const SizedBox(height: 10,),
                        ],
                      ),
                    );
                  }),
                 const SizedBox(height: 20,),
            ],
          ),
        );
      },)
    );
  }
}
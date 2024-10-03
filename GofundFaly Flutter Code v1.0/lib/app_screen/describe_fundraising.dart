import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gofunds/app_screen/passenger_details.dart';
// import 'package:markdown_editable_textinput/format_markdown.dart';
// import 'package:markdown_editable_textinput/markdown_text_input.dart';
import 'package:provider/provider.dart';
import '../common/common_button.dart';
import '../common/light_dark_mode.dart';

TextEditingController titlecontroller = TextEditingController();
TextEditingController storycontroller = TextEditingController();

class Describe_Fundraisinf extends StatefulWidget {
  const Describe_Fundraisinf({super.key});

  @override
  State<Describe_Fundraisinf> createState() => _Describe_FundraisinfState();
}

class _Describe_FundraisinfState extends State<Describe_Fundraisinf> {

  String description = '';

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
                borderRadius: const BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      (titlecontroller.text.isNotEmpty && storycontroller.text.isNotEmpty) ?

                      NextButton(containcolore: theamcolore,onPressed1: () {
                        Navigator.push(context,MaterialPageRoute(builder: (context) => const Passenger_Details(),));
                      },)
                          :
                      NextButtonNon(onPressed1: () {}),

                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
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
                        Text('Describe why you`re'.tr,style: TextStyle(color: notifier.textcolore,fontFamily: "SofiaProBold",fontSize: 22),),
                        const SizedBox(height: 5,),
                        Text('fundraising'.tr,style: TextStyle(color: notifier.textcolore,fontFamily: "SofiaProBold",fontSize: 22),),
                      ],
                    ),
                  ),
                ),
                Container(
                    height: Get.height * 0.78,
                    width: Get.width,
                    decoration: BoxDecoration(
                        color: notifier.background,
                        borderRadius: const BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
                    ),
                    child: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Step 2 of 4'.tr,style: const TextStyle(color: Colors.grey,fontSize: 14,fontFamily: "SofiaProBold"),),
                            const SizedBox(height: 10,),
                            Text('Fundraiser Title'.tr,style: TextStyle(color: notifier.textcolore,fontWeight: FontWeight.bold)),
                            const SizedBox(height: 10,),
                            TextFormField(
                              controller: titlecontroller,
                              style:  TextStyle(fontSize: 16,color: notifier.textcolore),
                              decoration: InputDecoration(
                                errorStyle: const TextStyle(fontSize: 0.1),
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(vertical: 13,horizontal: 10),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(color: Colors.pink)
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(color: theamcolore),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Colors.grey.withOpacity(0.4),
                                    )),
                                hintText: 'Support for Urgent Medical Treatment'.tr,
                                hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Text('Fund Description'.tr,style: TextStyle(color: notifier.textcolore,fontWeight: FontWeight.bold)),
                            const SizedBox(height: 10,),
                            SizedBox(
                              height: Get.height,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  TextFormField(
                                    maxLines: 15,
                                    controller: storycontroller,
                                    style: TextStyle(color: notifier.textcolore),
                                    decoration: InputDecoration(
                                      errorStyle: const TextStyle(fontSize: 0.1),
                                      isDense: true,
                                      contentPadding: const EdgeInsets.symmetric(vertical: 13,horizontal: 10),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: const BorderSide(color: Colors.pink),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                                          borderSide: BorderSide(color: theamcolore),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(color: Colors.grey.withOpacity(0.4)),
                                      ),
                                      hintText: 'Help us provide life-saving treatment and care.'.tr,
                                      hintStyle: const TextStyle(
                                          fontSize: 13, color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      storycontroller.clear();
                                    },
                                    child: Text('Clear'.tr),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20,),
                          ],
                        ),
                      ),
                    )

                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

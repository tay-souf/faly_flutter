// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gofunds/app_screen/account_screen.dart';
import 'package:gofunds/common/common_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common/config.dart';
import '../controller/login_controller.dart';
import '../demo_screen.dart';
import 'featured_details_screen.dart';

class Search_Screen extends StatefulWidget {
  final String walletamount;
  final String palteformfee;
  const Search_Screen({super.key, required this.walletamount, required this.palteformfee});

  @override
  State<Search_Screen> createState() => _Search_ScreenState();
}

class _Search_ScreenState extends State<Search_Screen> {

  SearchFundeController searchFundeController = Get.put(SearchFundeController());

  TextEditingController searchcontroller = TextEditingController();


 @override
  void initState() {
    super.initState();
    // TODO: implement initState
  datagetfunction();
  }

  var userdata;
  var currency1;

  Future datagetfunction() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var uid = preferences.getString("userLogin");

    boolValue = preferences.getBool('guestlogin');
    if(boolValue != true){
      userdata = jsonDecode(uid!);
      print('+ + + + + + + + fbjahfvj :----- ${userdata["id"]}');
      setState(() {
      });
    }else{

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: notifier.background,
      appBar: AppBar(
        toolbarHeight: 35,
        iconTheme: IconThemeData(
          color: notifier.textcolore,
        ),
        backgroundColor: notifier.background,
        elevation: 0,
      ),
      body: GetBuilder<SearchFundeController>(builder: (searchFundeController) {
        return Padding(
          padding: const EdgeInsets.only(left: 15,right: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                        decoration: BoxDecoration(
                          color: notifier.containercolore,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child:  TextField(
                          style: TextStyle(color: notifier.textcolore),
                          controller: searchcontroller,
                          onChanged: (value) {
                            print("+++++ OnChange +++++");
                            setState(() {
                              Future.delayed(const Duration(milliseconds: 100), () {
                                setState(() {
                                  searchcontroller.text;
                                  searchFundeController.searchApi(uid: userdata["id"],keyword: searchcontroller.text);
                                });
                              });
                            });
                            print("onchange result :--- ${searchFundeController.searchApiModel?.result}");
                          },
                          onSubmitted: (value) {
                            print("+++++ OnSubmit +++++");
                            setState(() {
                              searchcontroller.text;
                              searchFundeController.searchApi(uid: userdata["id"],keyword: searchcontroller.text);
                            });
                            print("onchange result :--- ${searchFundeController.searchApiModel?.result}");
                          },

                          decoration: InputDecoration(
                            errorStyle: const TextStyle(fontSize: 0.1),
                            isDense: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                const BorderSide(color: Colors.pink)),
                            focusedBorder:  OutlineInputBorder(
                                borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                                borderSide:
                                BorderSide(color: theamcolore)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.grey.withOpacity(0.4))),
                            hintText: 'Search by charity or cause'.tr,
                            hintStyle: TextStyle(
                                fontSize: 13, color: notifier.textcolore),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
              searchcontroller.text.isEmpty ? Padding(
                  padding: const EdgeInsets.only(top: 200),
                  child: Center(
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
                  ),
                ) :  searchFundeController.searchApiModel?.result == null ? const SizedBox() : ListView.separated(
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 15);
                    },
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: searchFundeController.searchApiModel!.fundlist.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => details_screen(palteformfee: widget.palteformfee,id: searchFundeController.searchApiModel!.fundlist[index].id,remainAmt: "${searchFundeController.searchApiModel!.fundlist[index].remainAmt}",totalInvestment: searchFundeController.searchApiModel!.fundlist[index].totalInvestment, walletamount: widget.walletamount,),));
                        },
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
                                    image: DecorationImage(image: NetworkImage('${Config.baseurl}${searchFundeController.searchApiModel!.fundlist[index].fundPhotos[0]}'),fit: BoxFit.cover)
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      searchFundeController.searchApiModel!.fundlist[index].donaterlist.isEmpty ? Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.1),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Center(child: Image.asset("assets/donateicon.png",height: 20,width: 20,color: notifier.textcolore,)),
                                        ),
                                      ) : SizedBox(
                                        height: 35,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: searchFundeController.searchApiModel!.fundlist[index].donaterlist.length,
                                          itemBuilder: (context, index1) {
                                            return  index1 < 3? SizedBox(
                                              height: 50,
                                              width: 20,
                                              child: Stack(
                                                clipBehavior: Clip.none,
                                                children: [
                                                  searchFundeController.searchApiModel!.fundlist[index].donaterlist[index1].profilePic == null ?  Positioned(
                                                    left: 10,
                                                    child: Container(
                                                      height: 30,
                                                      width: 30,
                                                      decoration:  BoxDecoration(
                                                        color: notifier.background,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Center(child: Text("${ boolValue == true ? "K" :  userdata['name'][0]}")),
                                                    ),
                                                  ) :  rtl ? Positioned(
                                                    right: 10,
                                                    child: Container(
                                                      height: 30,
                                                      width: 30,
                                                      decoration:  BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          image:  DecorationImage(image: NetworkImage('${Config.baseurl}${searchFundeController.searchApiModel!.fundlist[index].donaterlist[index1].profilePic}'),fit: BoxFit.cover)
                                                      ),
                                                    ),
                                                  ) :
                                                  Positioned(
                                                    left: 10,
                                                    child: Container(
                                                      height: 30,
                                                      width: 30,
                                                      decoration:  BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          image:  DecorationImage(image: NetworkImage('${Config.baseurl}${searchFundeController.searchApiModel!.fundlist[index].donaterlist[index1].profilePic}'),fit: BoxFit.cover)
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ) : const SizedBox();
                                          },),
                                      ),
                                      searchFundeController.searchApiModel!.fundlist[index].donaterlist.isEmpty ?
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Text("Be the first to donate",style: TextStyle(color: notifier.textcolore)),
                                      )
                                          :    Padding(
                                        padding: const EdgeInsets.only(left: 20,right: 20),
                                        child: Text("  ${searchFundeController.searchApiModel!.fundlist[index].donaterlist.length} people donated",style: TextStyle(color: notifier.textcolore)),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 5,),
                                        Text(searchFundeController.searchApiModel!.fundlist[index].title,style: TextStyle(color: notifier.textcolore,fontFamily: "SofiaProBold",fontSize: 14),maxLines: 1,overflow: TextOverflow.ellipsis,),
                                        searchFundeController.searchApiModel!.fundlist[index].remainAmt == 0 ? Transform.translate(
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
                                        ) :


                                        Transform.translate(offset: const Offset(0, -5),child:  MyWidgetSlider((searchFundeController.searchApiModel!.fundlist[index].remainAmt + double.parse(searchFundeController.searchApiModel!.fundlist[index].totalInvestment) ).toString(),searchFundeController.searchApiModel!.fundlist[index].totalInvestment.toString())),
                                        Transform.translate(
                                          offset: const Offset(0, -10),
                                          child: Row(
                                            children: [
                                              Text("Raised".tr,style: TextStyle(color: notifier.textcolore)),
                                              const Spacer(),
                                              searchFundeController.searchApiModel!.fundlist[index].remainAmt == 0 ?  Text("Complete".tr,style: TextStyle(color: notifier.textcolore)) :   Text("${(double.parse(searchFundeController.searchApiModel!.fundlist[index].totalInvestment) / (searchFundeController.searchApiModel!.fundlist[index].remainAmt + double.parse(searchFundeController.searchApiModel!.fundlist[index].totalInvestment)) * 100).toStringAsFixed(2)}%",style: TextStyle(color: notifier.textcolore)),
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
                      );
                    }),
              ],
            ),
          ),
        );
      },),
    );
  }
}


// ignore_for_file: unused_import, unnecessary_import, depend_on_referenced_packages, camel_case_types, prefer_typing_uninitialized_variables, non_constant_identifier_names, avoid_print, sort_child_properties_last, no_leading_underscores_for_local_identifiers

import 'dart:convert';
import 'package:gofunds/common/common_button.dart';
import 'package:gofunds/common/config.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common/light_dark_mode.dart';
import '../common/payout_controller.dart';
import '../controller/login_controller.dart';

List<String> payType = ["UPI", "BANK Transfer", "Paypal"];

class payout_screen extends StatefulWidget {
  const payout_screen({super.key});

  @override
  State<payout_screen> createState() => _payout_screenState();
}

class _payout_screenState extends State<payout_screen> {

  var daat;
  bool isloading = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? selectType;

  PayOutController payOutController = Get.put(PayOutController());
  RequestwithdreawApiController requestwithdreawApiController = Get.put(RequestwithdreawApiController());



  GetmonyApiController getmonyApiController = Get.put(GetmonyApiController());
  PayoutlistApiController payoutlistApiController = Get.put(PayoutlistApiController());



  @override
  void initState() {
    datagetfunction();
    super.initState();
  }

  var userData;
  var currency1;

  datagetfunction() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var uid = preferences.getString("userLogin");
    var curr = currency1 = preferences.getString("currenci");
    userData = jsonDecode(uid!);
    currency1 = jsonDecode(curr!);
    setState(() {

    });

    getmonyApiController.getbalnceapi(uid: userData['id']).then((value) {
      setState(() {
      });
    });

    payoutlistApiController.payoutlisttapi(uid: userData['id']).then((value) {
      setState(() {

      });
    });

    print("..................+++++++.................. :-------  $currency1");
    print("..................+++++++.................. :-------  ${userData['id']}");
  }


  ColorNotifier notifier = ColorNotifier();

  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return Scaffold(
      backgroundColor: notifier.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: notifier.background,
        title: Text("Withdraw",style: TextStyle(fontSize: 18,color: notifier.textcolore)),
        leading:  InkWell(
          onTap: () {
            Get.back();
          },
          child:  Icon(Icons.arrow_back,color: notifier.textcolore),
        ),
      ),
      body: GetBuilder<GetmonyApiController>(builder: (getmonyApiController) {
        return getmonyApiController.isLoading ? Center(child: CircularProgressIndicator(color: theamcolore,)) : Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Total Balance",style: TextStyle(color: notifier.textcolore),),
                      SizedBox(height: 5,),
                      Text("$currency1${getmonyApiController.getBalance!.totalFund}",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color: notifier.textcolore),),
                    ],
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {

                      // payOutController.amount.cl,
                      payOutController.amount.clear();
                      payOutController.accountNumber.clear();
                      payOutController.bankName.clear();
                      payOutController.accountHolderName.clear();
                      payOutController.ifscCode.clear();
                      payOutController.upi.clear();
                      payOutController.emailId.clear();

                      // requestwithdreawApiController.Withdrawapi(uid: userData['id'], amt: payOutController.amount.text, r_type: "$selectType", acc_number: payOutController.accountNumber.text, bank_name: payOutController.bankName.text, acc_name: payOutController.accountHolderName.text, ifsc_code: payOutController.ifscCode.text, upi_id: payOutController.upi.text, paypal_id: payOutController.emailId.text).then((value) {
                      //   datagetfunction();
                      // });

                      getmonyApiController.getBalance!.totalFund <= 0 ?   Fluttertoast.showToast(msg: "No Withdrawal Amount") : requestSheet().then((value) {
                        setState(() {

                        });
                      });
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
                            child: const Center(child: Image(image: AssetImage("assets/arrow-up.png"),height: 18,width: 18,),),
                          ),
                          const SizedBox(width: 10,),
                          Text("Withdraw",style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),

              payoutlistApiController.payOutListApi!.payoutlist.isEmpty ? const SizedBox() : Column(
                children: [
                  Row(
                    children: [
                      Text('Transaction History'.tr,style: TextStyle(fontSize: 17,color: notifier.textcolore),),
                      const Spacer(),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 5,),
              GetBuilder<PayoutlistApiController>(builder: (payoutlistApiController) {
                return payoutlistApiController.payOutListApi!.payoutlist.isEmpty  ? const SizedBox() : Expanded(
                  child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return const SizedBox(width : 0);
                      },
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: payoutlistApiController.payOutListApi!.payoutlist.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            Get.bottomSheet(
                                isScrollControlled: true,
                                Padding(
                                  padding: const EdgeInsets.only(top: 150),
                                  child: Container(
                                    decoration:  BoxDecoration(
                                      color: notifier.containercolore,
                                      borderRadius: const BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15)),
                                    ),
                                    child:  Padding(
                                      padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          const SizedBox(height: 20,),
                                          Row(
                                            children: [
                                              Text('Payout id'.tr,style:  TextStyle(color: notifier.textcolore,fontSize: 15)),
                                              const Spacer(),
                                              Text(payoutlistApiController.payOutListApi!.payoutlist[index].payoutId,style: TextStyle(color: notifier.textcolore,fontSize: 15)),
                                            ],
                                          ),
                                          const SizedBox(height: 10,),
                                          Row(
                                            children: [
                                              Text('Amount'.tr,style:  TextStyle(color: notifier.textcolore,fontSize: 15)),
                                              const Spacer(),
                                              Text(payoutlistApiController.payOutListApi!.payoutlist[index].amt,style: TextStyle(color: notifier.textcolore,fontSize: 15)),
                                            ],
                                          ),
                                          const SizedBox(height: 10,),
                                          Row(
                                            children: [
                                              Text('Pay by'.tr,style:  TextStyle(color: notifier.textcolore,fontSize: 15)),
                                              const Spacer(),
                                              payoutlistApiController.payOutListApi!.payoutlist[index].rType == "BANK Transfer" ? Text('BANK Transfer'.tr,style: TextStyle(color: notifier.textcolore,fontSize: 15)) :  Text('${payoutlistApiController.payOutListApi!.payoutlist[index].rType}(${payoutlistApiController.payOutListApi!.payoutlist[index].rType == "Paypal" ? payoutlistApiController.payOutListApi!.payoutlist[index].paypalId : payoutlistApiController.payOutListApi!.payoutlist[index].upiId})',style: TextStyle(color: notifier.textcolore,fontSize: 15)),
                                            ],
                                          ),
                                          payoutlistApiController.payOutListApi!.payoutlist[index].rType == "BANK Transfer" ?   Column(
                                            children: [
                                              const SizedBox(height: 10,),
                                              Row(
                                                children: [
                                                  Text('Account Number'.tr,style:  TextStyle(color: notifier.textcolore,fontSize: 15)),
                                                  const Spacer(),
                                                  Text(payoutlistApiController.payOutListApi!.payoutlist[index].accNumber,style: TextStyle(color: notifier.textcolore,fontSize: 15)),
                                                ],
                                              ),
                                              const SizedBox(height: 10,),
                                              Row(
                                                children: [
                                                  Text('Bank Name'.tr,style:  TextStyle(color: notifier.textcolore,fontSize: 15)),
                                                  const Spacer(),
                                                  Text(payoutlistApiController.payOutListApi!.payoutlist[index].bankName,style: TextStyle(color: notifier.textcolore,fontSize: 15)),
                                                ],
                                              ),
                                              const SizedBox(height: 10,),
                                              Row(
                                                children: [
                                                  Text('Account Name'.tr,style:  TextStyle(color: notifier.textcolore,fontSize: 15)),
                                                  const Spacer(),
                                                  Text(payoutlistApiController.payOutListApi!.payoutlist[index].accName,style: TextStyle(color: notifier.textcolore,fontSize: 15)),
                                                ],
                                              ),
                                            ],
                                          ) : const SizedBox(),
                                          const SizedBox(height: 10,),
                                          Row(
                                            children: [
                                              Text('Request Date'.tr,style:  TextStyle(color: notifier.textcolore,fontSize: 15)),
                                              const Spacer(),
                                              Text(payoutlistApiController.payOutListApi!.payoutlist[index].rDate.toString().split(' ').first,style: TextStyle(color: notifier.textcolore,fontSize: 15)),
                                            ],
                                          ),
                                          payoutlistApiController.payOutListApi!.payoutlist[index].status == 'completed' ? Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(top: 10),
                                                child: Text('Proof'.tr,style: TextStyle(color: notifier.textcolore,fontSize: 15)),
                                              ),
                                              const Spacer(),
                                              payoutlistApiController.payOutListApi!.payoutlist[index].proof == null ? const SizedBox() : Image(image: NetworkImage('${Config.baseurl}${payoutlistApiController.payOutListApi!.payoutlist[index].proof}'),height: 80,width: 80,),
                                            ],
                                          ) : const SizedBox() ,
                                          const SizedBox(height: 20,),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                            );
                          },
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: payoutlistApiController.payOutListApi!.payoutlist[index].status == 'completed' ? const Image(image: AssetImage('assets/walletecomplete.png'),height: 40):const Image(image: AssetImage('assets/walletpending.png'),height: 40),
                            title: Text(payoutlistApiController.payOutListApi!.payoutlist[index].status,style: TextStyle(color: notifier.textcolore)),
                            subtitle: Text(payoutlistApiController.payOutListApi!.payoutlist[index].rDate.toString().split(' ').first,style: TextStyle(color: notifier.textcolore)),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('$currency1${payoutlistApiController.payOutListApi!.payoutlist[index].amt}',style: const TextStyle(fontSize: 15,color: Colors.green)),
                                Icon(Icons.keyboard_arrow_right,color: notifier.textcolore),
                              ],
                            ),
                          ),
                        );
                      }),
                );
              },)

            ],
          ),
        );
      },),
    );
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  Future<void> requestSheet() {
    return Get.bottomSheet(
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return Form(
          key: _formKey,
          child: Container(
            width: Get.size.width,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Payout Request".tr,
                    style: TextStyle(
                      color: notifier.textcolore,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(),
                  textfield(
                    controller: payOutController.amount,
                    labelText: "Amount".tr,
                    textInputType: TextInputType.number,
                    onChanged: (p0) {
                      if(getmonyApiController.getBalance!.totalFund < double.parse(p0)) {
                        payOutController.amount.clear();
                        Fluttertoast.showToast(msg: "Please Enter ${getmonyApiController.getBalance!.totalFund} under donation");
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Amount'.tr;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: const EdgeInsets.only(left: 15),
                    child: Text(
                      "Select Type".tr,
                      style: TextStyle(
                        fontSize: 16,
                        color: notifier.textcolore,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 50,
                    width: Get.size.width,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: DropdownButton(
                      dropdownColor: notifier.containercolore,
                      hint: Text(
                        "Select Type".tr,
                        style: TextStyle(color: notifier.textcolore),
                      ),
                      value: selectType,
                      isExpanded: true,
                      underline: const SizedBox.shrink(),
                      items: payType.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                              color: notifier.textcolore,
                              fontSize: 14,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectType = value ?? "";
                        });
                      },
                    ),
                    decoration: BoxDecoration(
                      // color: notifier.textColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.withOpacity(0.4)),
                    ),
                  ),
                  selectType == "UPI"
                      ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          "UPI".tr,
                          style: TextStyle(
                            fontSize: 16,
                            color: notifier.textcolore,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      textfield(
                        controller: payOutController.upi,
                        labelText: "UPI".tr,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter UPI'.tr;
                          }
                          return null;
                        },
                      )
                    ],
                  )
                      : selectType == "BANK Transfer"
                      ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          "Account Number".tr,
                          style:  TextStyle(
                            fontSize: 16,
                            color: notifier.textcolore,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      textfield(
                        controller: payOutController.accountNumber,
                        labelText: "Account Number".tr,
                        textInputType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Account Number'.tr;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          "Bank Name".tr,
                          style:  TextStyle(
                            fontSize: 16,
                            color: notifier.textcolore,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      textfield(
                        controller: payOutController.bankName,
                        labelText: "Bank Name".tr,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Bank Name'.tr;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          "Account Holder Name".tr,
                          style:  TextStyle(
                            fontSize: 16,
                            color: notifier.textcolore,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      textfield(
                        controller:
                        payOutController.accountHolderName,
                        labelText: "Account Holder Name".tr,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Account Holder Name'
                                .tr;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          "IFSC Code".tr,
                          style:  TextStyle(
                            fontSize: 16,
                            color: notifier.textcolore,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      textfield(
                        controller: payOutController.ifscCode,
                        labelText: "IFSC Code".tr,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter IFSC Code'.tr;
                          }
                          return null;
                        },
                      ),
                    ],
                  )
                      : selectType == "Paypal"
                      ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          "Email ID".tr,
                          style:  TextStyle(
                            fontSize: 16,
                            color: notifier.textcolore,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      textfield(
                        controller: payOutController.emailId,
                        labelText: "Email Id".tr,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Paypal id'.tr;
                          }
                          return null;
                        },
                      ),
                    ],
                  )
                      : Container(),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ButtonStyle(fixedSize: const MaterialStatePropertyAll(Size(120, 40)),elevation: const MaterialStatePropertyAll(0),shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),backgroundColor: const MaterialStatePropertyAll(Colors.transparent)),
                            onPressed: () => Navigator.pop(context),
                            child: Text('Cancel'.tr,style:   TextStyle(color: notifier.textcolore)),
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Expanded(
                          child: ElevatedButton(
                            style: ButtonStyle(fixedSize: const MaterialStatePropertyAll(Size(120, 40)),elevation: const MaterialStatePropertyAll(0),shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),backgroundColor:  MaterialStatePropertyAll(theamcolore)),
                            onPressed: () => {
                              if (_formKey.currentState?.validate() ?? false) {
                                if (selectType != null) {
                                  requestwithdreawApiController.Withdrawapi(uid: userData['id'], amt: payOutController.amount.text, r_type: "$selectType", acc_number: payOutController.accountNumber.text, bank_name: payOutController.bankName.text, acc_name: payOutController.accountHolderName.text, ifsc_code: payOutController.ifscCode.text, upi_id: payOutController.upi.text, paypal_id: payOutController.emailId.text).then((value) {
                                    datagetfunction();
                                  }),
                                  Get.back(),
                                  payOutController.amount.clear(),
                                } else {
                                  Fluttertoast.showToast(msg: 'Please Select Type'.tr,timeInSecForIosWeb: 4),
                                }
                              }
                            },
                            child: Text('Proceed'.tr,style: const TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
            decoration:  BoxDecoration(
              color: notifier.containercolore,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
          ),
        );
      }),
    );
  }

  textfield({String? type, labelText, prefixtext, suffix, Color? labelcolor, prefixcolor, floatingLabelColor, focusedBorderColor, TextDecoration? decoration, bool? readOnly, double? Width, int? max, TextEditingController? controller, TextInputType? textInputType, Function(String)? onChanged, String? Function(String?)? validator, Height}) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        cursorColor: Colors.black,
        keyboardType: textInputType,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        maxLength: max,
        readOnly: readOnly ?? false,

        style:  TextStyle(

            color: notifier.textcolore,
            fontSize: 18),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
          hintText: labelText,
          hintStyle: const TextStyle(
              color: Colors.grey, fontSize: 16),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xff7D2AFF)),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:  BorderSide(color: Colors.grey.withOpacity(0.4)),
          ),
          border: OutlineInputBorder(
            borderSide:  BorderSide(color: Colors.grey.withOpacity(0.4)),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        validator: validator,
      ),
    );
  }

}

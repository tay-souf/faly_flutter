// ignore_for_file: avoid_print, use_build_context_synchronously, camel_case_types, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gofunds/common/common_button.dart';
import 'package:gofunds/common/config.dart';
import 'package:gofunds/controller/login_controller.dart';
import 'package:lottie/lottie.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../bootom_navigation_screen/home_screen.dart';
import '../common/light_dark_mode.dart';
import '../payment_getway_screen/common_webview.dart';
import '../payment_getway_screen/inputformater.dart';
import '../payment_getway_screen/paymentcard.dart';
import '../payment_getway_screen/paypal.dart';
import '../payment_getway_screen/razorpay.dart';

TextEditingController walletController = TextEditingController();
String currencybol = "";

class Top_up extends StatefulWidget {
  const Top_up({Key? key}) : super(key: key);

  @override
  State<Top_up> createState() => _Top_upState();
}

class _Top_upState extends State<Top_up> {

  WalletApiController walletApiController = Get.put(WalletApiController());

  WalletReportApiController walletReportApiController = Get.put(WalletReportApiController());
  PaymentGetApiController paymentGetApiController = Get.put(PaymentGetApiController());
  PayStackPayMentApiController payStackPayMentApiController = Get.put(PayStackPayMentApiController());



  @override
  void initState() {
    getPackage();
    datagetfunction();
    razorPayClass.initiateRazorPay(handlePaymentSuccess: handlePaymentSuccess, handlePaymentError: handlePaymentError, handleExternalWallet: handleExternalWallet);
    // TODO: implement initState
    super.initState();
  }




  PackageInfo? packageInfo;
  String? appName;
  String? packageName;

  void getPackage() async {

    packageInfo = await PackageInfo.fromPlatform();

    appName = packageInfo!.appName;


    packageName = packageInfo!.packageName;

    setState(() {

    });
  }


  int payment = -1;
  String selectedOption = '';
  String selectBoring = "";


  var userdata;
  var currency1;


  datagetfunction() async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var uid = preferences.getString("userLogin");
    userdata = jsonDecode(uid!);

    var curr = currency1 = preferences.getString("currenci");
    currency1 = jsonDecode(curr!);
    walletReportApiController.walletreportApi(uid: userdata['id']);
    paymentGetApiController.paymentlistApi(context);
    currencybol = currency1;
    print("******hello cureency++++:--- ${currencybol}");
  }

  @override
  void dispose() {
    walletReportApiController.isLoading = true;
    // TODO: implement dispose
    super.dispose();
  }

  RazorPayClass  razorPayClass = RazorPayClass();
  HomeApiController homeApiController = Get.put(HomeApiController());

  void handlePaymentSuccess(PaymentSuccessResponse response){
    walletApiController.walletaddapi(wallet: walletController.text, uid: userdata['id'],context: context).then((value) {
      walletReportApiController.walletreportApi(uid: userdata['id']);
      homeApiController.homeApi(uid: userdata['id'],latitude: lathome.toString(),logitude: longhome.toString());
    });

    Fluttertoast.showToast(msg: 'SUCCESS PAYMENT : ${response.paymentId}',timeInSecForIosWeb: 4);
  }
  void handlePaymentError(PaymentFailureResponse response){
    Fluttertoast.showToast(msg: 'ERROR HERE: ${response.code} - ${response.message}',timeInSecForIosWeb: 4);
  }
  void handleExternalWallet(ExternalWalletResponse response){
    Fluttertoast.showToast(msg: 'EXTERNAL_WALLET IS: ${response.walletName}',timeInSecForIosWeb: 4);
  }



  String amountvarable = "";

  ColorNotifier notifier = ColorNotifier();
  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return Scaffold(
      backgroundColor: notifier.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: notifier.background,
        title: Text("Wallet",style: TextStyle(fontSize: 18,color: notifier.textcolore)),
        leading:  InkWell(
          onTap: () {
            Get.back();
          },
          child:  Icon(Icons.arrow_back,color: notifier.textcolore),
        ),
      ),
      body: GetBuilder<WalletReportApiController>(builder: (walletReportApiController) {
        return walletReportApiController.isLoading ? Center(child: CircularProgressIndicator(color: theamcolore,)) : Padding(
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
                      Text("${currency1}${walletReportApiController.walletReportApiModel?.wallet}",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color: notifier.textcolore),),
                    ],
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                       selectedOption = '';
                       selectBoring = "";
                      walletController.clear();
                      Get.bottomSheet(
                        isScrollControlled: true,
                        StatefulBuilder(builder: (context, setState) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 150),
                            child: Container(
                              decoration: BoxDecoration(
                                color: notifier.background,
                                borderRadius: const BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    const SizedBox(height: 10,),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 6,right: 6),
                                      child: Text('Add Wallet Amount'.tr,style: TextStyle(color: theamcolore,fontSize: 15,fontWeight: FontWeight.bold)),
                                    ),
                                    const SizedBox(height: 10,),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: SizedBox(
                                        height: 45,
                                        child: TextFormField(
                                          controller: walletController,
                                          cursorColor: Colors.black,
                                          keyboardType: TextInputType.number,
                                          onChanged: (value) {
                                            setState(() {
                                              amountvarable = value;
                                            });
                                            print("*****::--(${amountvarable})");
                                          },
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: notifier.textcolore
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding: const EdgeInsets.only(top: 15),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                color: Colors.grey.withOpacity(0.4),
                                              ),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                color: Colors.grey.withOpacity(0.4),
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                color: Colors.grey.withOpacity(0.4),
                                              ),
                                            ),
                                            prefixIcon: SizedBox(
                                              height: 20,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 14),
                                                child: Image.asset(
                                                  'assets/a1.png',
                                                  width: 20,
                                                  color: notifier.textcolore,
                                                ),
                                              ),
                                            ),
                                            hintText: "Enter Amount".tr,
                                            hintStyle:  const TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10,),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 6,right: 6),
                                      child: Text('Select Payment Method'.tr,style: const TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 12)),
                                    ),
                                    const SizedBox(height: 0,),
                                    Expanded(
                                      child: ListView.separated(
                                          separatorBuilder: (context, index) {
                                            return const SizedBox(width:0,);
                                          },
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount: paymentGetApiController.paymentgetwayapi!.paymentdata.length,
                                          itemBuilder: (BuildContext context, int index) {
                                            return InkWell(
                                              onTap: walletController.text.isEmpty ? (){
                                                Fluttertoast.showToast(
                                                  msg: "Enter Amount!!!",
                                                );
                                              } :    () {
                                                setState(() {
                                                  payment = index;
                                                });
                                                if(paymentGetApiController.paymentgetwayapi!.paymentdata[payment].title == "Razorpay"){
                                                  razorPayClass.openCheckout(key: paymentGetApiController.paymentgetwayapi!.paymentdata[0].attributes, amount: '${double.parse(walletController.text)}', number: '${userdata['mobile']}', name: '${userdata['email']}');
                                                  Get.back();
                                                }
                                                else if(paymentGetApiController.paymentgetwayapi!.paymentdata[payment].title == "Paypal"){
                                                  List ids = paymentGetApiController.paymentgetwayapi!.paymentdata[1].attributes.toString().split(",");
                                                  print('++++++++++ids:------$ids');
                                                  paypalPayment(
                                                    context: context,
                                                    function: (e){
                                                      walletApiController.walletaddapi(wallet: walletController.text, uid: userdata['id'],context: context).then((value) {
                                                        walletReportApiController.walletreportApi(uid: userdata['id']);
                                                      });
                                                    },
                                                    amt: walletController.text,
                                                    clientId: ids[0],
                                                    secretKey: ids[1],
                                                  );
                                                }
                                                else if(paymentGetApiController.paymentgetwayapi!.paymentdata[payment].title == "Stripe"){
                                                  stripePayment();
                                                }
                                                else if(paymentGetApiController.paymentgetwayapi!.paymentdata[payment].title == "PayStack"){
                                                  payStackPayMentApiController.paystackApi(email: userdata['email'], amount: walletController.text,context: context).then((value) {
                                                    print("***value***:-------   ${value}");


                                                    Navigator.push(context, MaterialPageRoute(
                                                      builder: (context) => PaymentWebVIew(
                                                        initialUrl: "${value}",
                                                        navigationDelegate: (request) async {
                                                          final uri = Uri.parse(request.url);
                                                          print("Navigating to URL: ${request.url}");
                                                          print("Parsed URI: $uri");

                                                          // Check the status parameter instead of Result
                                                          final status = uri.queryParameters["status"];
                                                          print("Hello Status:---- $status");

                                                          if (status == null) {
                                                            print("No status parameter found.");
                                                          } else {
                                                            print("Status parameter: $status");
                                                            if (status == "success") {
                                                              print("Purchase successful.");
                                                              walletApiController.walletaddapi(wallet: walletController.text, uid: userdata['id'],context: context).then((value) {
                                                                walletReportApiController.walletreportApi(uid: userdata['id']);
                                                              });
                                                              return NavigationDecision.prevent;
                                                            } else {
                                                              print("Purchase failed with status: $status.");
                                                              Navigator.pop(context);
                                                              Fluttertoast.showToast(msg: status, timeInSecForIosWeb: 4);
                                                              return NavigationDecision.prevent;
                                                            }
                                                          }
                                                          return NavigationDecision.navigate;
                                                        },
                                                      ),
                                                    ));



                                                  },);
                                                }
                                                else if(paymentGetApiController.paymentgetwayapi!.paymentdata[payment].title == "FlutterWave"){
                                                  Navigator.push(context, MaterialPageRoute(
                                                    builder: (context) => PaymentWebVIew(
                                                      initialUrl: "${Config.baseurl}flutterwave/index.php?amt=${walletController.text}&email=${userdata['email']}",
                                                      navigationDelegate: (request) async {
                                                        final uri = Uri.parse(request.url);
                                                        print("Navigating to URL: ${request.url}");
                                                        print("Parsed URI: $uri");

                                                        // Check the status parameter instead of Result
                                                        final status = uri.queryParameters["status"];
                                                        final transactionn_id = uri.queryParameters["transaction_id"];
                                                        print("Hello Status:---- $status");
                                                        print("Hello Status:---- $transactionn_id");

                                                        if (status == null) {
                                                          print("No status parameter found.");
                                                        } else {
                                                          print("Status parameter: $status");
                                                          if (status == "successful") {
                                                            print("Purchase successful.");
                                                            walletApiController.walletaddapi(wallet: walletController.text, uid: userdata['id'],context: context).then((value) {
                                                              walletReportApiController.walletreportApi(uid: userdata['id']);
                                                            });
                                                            return NavigationDecision.prevent;
                                                          } else {
                                                            print("Purchase failed with status: $status.");
                                                            Navigator.pop(context);
                                                            Fluttertoast.showToast(msg: status, timeInSecForIosWeb: 4);
                                                            return NavigationDecision.prevent;
                                                          }
                                                        }
                                                        return NavigationDecision.navigate;
                                                      },
                                                    ),
                                                  ));

                                                }
                                                else if(paymentGetApiController.paymentgetwayapi!.paymentdata[payment].title == "Paytm"){
                                                  Navigator.push(context, MaterialPageRoute(
                                                    builder: (context) => PaymentWebVIew(
                                                      initialUrl: "${Config.baseurl}paytm/index.php?amt=${walletController.text}&uid=${userdata['id']}",
                                                      navigationDelegate: (request) async {
                                                        final uri = Uri.parse(request.url);
                                                        print("Navigating to URL: ${request.url}");
                                                        print("Parsed URI: $uri");

                                                        // Check the status parameter instead of Result
                                                        final status = uri.queryParameters["status"];
                                                        final transaction_idddd = uri.queryParameters["transaction_id"];
                                                        print("Hello Status:---- $status");
                                                        print("Hello Status:---- $transaction_idddd");

                                                        if (status == null) {
                                                          print("No status parameter found.");
                                                        } else {
                                                          print("Status parameter: $status");
                                                          if (status == "successful") {
                                                            print("Purchase successful.");
                                                            walletApiController.walletaddapi(wallet: walletController.text, uid: userdata['id'],context: context).then((value) {
                                                              walletReportApiController.walletreportApi(uid: userdata['id']);
                                                            });
                                                            return NavigationDecision.prevent;
                                                          } else {
                                                            print("Purchase failed with status: $status.");
                                                            Navigator.pop(context);
                                                            Fluttertoast.showToast(msg:  status, timeInSecForIosWeb: 4);
                                                            return NavigationDecision.prevent;
                                                          }
                                                        }
                                                        return NavigationDecision.navigate;
                                                      },
                                                    ),
                                                  ));
                                                }
                                                else if(paymentGetApiController.paymentgetwayapi!.paymentdata[payment].title == "SenangPay"){
                                                  final notificationId = UniqueKey().hashCode;
                                                  Navigator.push(context, MaterialPageRoute(
                                                    builder: (context) => PaymentWebVIew(
                                                      initialUrl: "${Config.baseurl}result.php?detail=Movers&amount=${walletController.text}&order_id=$notificationId&name=${userdata['name']}&email=${userdata['email']}&phone=${userdata['mobile']}",
                                                      navigationDelegate: (request) async {
                                                        final uri = Uri.parse(request.url);
                                                        print("Navigating to URL: ${request.url}");
                                                        print("Parsed URI: $uri");

                                                        // Check the status parameter instead of Result
                                                        final status = uri.queryParameters["msg"];
                                                        final transactionn_id = uri.queryParameters["transaction_id"];
                                                        print("Hello Status:---- $status");
                                                        print("Hello Status:---- $transactionn_id");

                                                        if (status == null) {
                                                          print("No status parameter found.");
                                                        } else {
                                                          print("Status parameter: $status");
                                                          if (status == "Payment_was_successful") {
                                                            print("Purchase successful.");
                                                            walletApiController.walletaddapi(wallet: walletController.text, uid: userdata['id'],context: context).then((value) {
                                                              walletReportApiController.walletreportApi(uid: userdata['id']);
                                                            });
                                                            return NavigationDecision.prevent;
                                                          } else {
                                                            print("Purchase failed with status: $status.");
                                                            Navigator.pop(context);
                                                            Fluttertoast.showToast(msg: status, timeInSecForIosWeb: 4);
                                                            return NavigationDecision.prevent;
                                                          }
                                                        }
                                                        return NavigationDecision.navigate;
                                                      },
                                                    ),
                                                  ));
                                                }
                                                else if(paymentGetApiController.paymentgetwayapi!.paymentdata[payment].title == "MercadoPago"){
                                                  Navigator.push(context, MaterialPageRoute(
                                                    builder: (context) => PaymentWebVIew(
                                                      initialUrl: "${Config.baseurl}merpago/index.php?amt=${walletController.text}",
                                                      navigationDelegate: (request) async {
                                                        final uri = Uri.parse(request.url);
                                                        print("Navigating to URL: ${request.url}");
                                                        print("Parsed URI: $uri");

                                                        // Check the status parameter instead of Result
                                                        final status = uri.queryParameters["Result"];
                                                        print("Hello Status:---- $status");

                                                        if (status == null) {
                                                          print("No status parameter found.");
                                                        } else {
                                                          print("Status parameter: $status");
                                                          if (status == "success") {
                                                            print("Purchase successful.");
                                                            walletApiController.walletaddapi(wallet: walletController.text, uid: userdata['id'],context: context).then((value) {
                                                              walletReportApiController.walletreportApi(uid: userdata['id']);
                                                            });
                                                            return NavigationDecision.prevent;
                                                          } else {
                                                            print("Purchase failed with status: $status.");
                                                            Navigator.pop(context);
                                                            Fluttertoast.showToast(msg: status, timeInSecForIosWeb: 4);
                                                            return NavigationDecision.prevent;
                                                          }
                                                        }
                                                        return NavigationDecision.navigate;
                                                      },
                                                    ),
                                                  ));
                                                }
                                                else if(paymentGetApiController.paymentgetwayapi!.paymentdata[payment].title == "Payfast"){
                                                  Navigator.push(context, MaterialPageRoute(
                                                    builder: (context) => PaymentWebVIew(
                                                      initialUrl: "${Config.baseurl}Payfast/index.php?amt=${walletController.text}",
                                                      navigationDelegate: (request) async {
                                                        final uri = Uri.parse(request.url);
                                                        print("Navigating to URL: ${request.url}");
                                                        print("Parsed URI: $uri");

                                                        // Check the status parameter instead of Result
                                                        final status = uri.queryParameters["status"];
                                                        final payment_iddd = uri.queryParameters["payment_id"];
                                                        print("Hello Status:---- $status");
                                                        print("Hello Status:---- $payment_iddd");

                                                        if (status == null) {
                                                          print("No status parameter found.");
                                                        } else {
                                                          print("Status parameter: $status");
                                                          if (status == "success") {
                                                            print("Purchase successful.");
                                                            walletApiController.walletaddapi(wallet: walletController.text, uid: userdata['id'],context: context).then((value) {
                                                              walletReportApiController.walletreportApi(uid: userdata['id']);
                                                            });
                                                            return NavigationDecision.prevent;
                                                          } else {
                                                            print("Purchase failed with status: $status.");
                                                            Navigator.pop(context);
                                                            Fluttertoast.showToast(msg: status, timeInSecForIosWeb: 4);
                                                            return NavigationDecision.prevent;
                                                          }
                                                        }
                                                        return NavigationDecision.navigate;
                                                      },
                                                    ),
                                                  ));
                                                }
                                                else if(paymentGetApiController.paymentgetwayapi!.paymentdata[payment].title == "Midtrans"){
                                                  Navigator.push(context, MaterialPageRoute(
                                                    builder: (context) => PaymentWebVIew(
                                                      initialUrl: "${Config.baseurl}Midtrans/index.php?name=${userdata['name']}&email=${userdata['email']}&phone=${userdata['mobile']}&amt=${walletController.text}",
                                                      navigationDelegate: (request) async {
                                                        final uri = Uri.parse(request.url);
                                                        print("Navigating to URL: ${request.url}");
                                                        print("Parsed URI: $uri");

                                                        // Check the status parameter instead of Result
                                                        final status = uri.queryParameters["status_code"];
                                                        final order_iddd = uri.queryParameters["order_id"];
                                                        print("Hello Status:---- $status");
                                                        print("Hello Status:---- $order_iddd");

                                                        if (status == null) {
                                                          print("No status parameter found.");
                                                        } else {
                                                          print("Status parameter: $status");
                                                          if (status == "200") {
                                                            print("Purchase successful.");
                                                            walletApiController.walletaddapi(wallet: walletController.text, uid: userdata['id'],context: context).then((value) {
                                                              walletReportApiController.walletreportApi(uid: userdata['id']);
                                                            });
                                                            return NavigationDecision.prevent;
                                                          } else {
                                                            print("Purchase failed with status: $status.");
                                                            Navigator.pop(context);
                                                            Fluttertoast.showToast(msg: status, timeInSecForIosWeb: 4);
                                                            return NavigationDecision.prevent;
                                                          }
                                                        }
                                                        return NavigationDecision.navigate;
                                                      },
                                                    ),
                                                  ));
                                                }
                                                else if(paymentGetApiController.paymentgetwayapi!.paymentdata[payment].title == "2checkout"){
                                                  Navigator.push(context, MaterialPageRoute(
                                                    builder: (context) => PaymentWebVIew(
                                                      initialUrl: "${Config.baseurl}2checkout/index.php?amt=${walletController.text}",
                                                      navigationDelegate: (request) async {
                                                        final uri = Uri.parse(request.url);
                                                        print("Navigating to URL: ${request.url}");
                                                        print("Parsed URI: $uri");

                                                        // Check the status parameter instead of Result
                                                        final status = uri.queryParameters["Result"];
                                                        print("Hello Status:---- $status");

                                                        if (status == null) {
                                                          print("No status parameter found.");
                                                        } else {
                                                          print("Status parameter: $status");
                                                          if (status == "success") {
                                                            print("Purchase successful.");
                                                            walletApiController.walletaddapi(wallet: walletController.text, uid: userdata['id'],context: context).then((value) {
                                                              walletReportApiController.walletreportApi(uid: userdata['id']);
                                                            });
                                                            return NavigationDecision.prevent;
                                                          } else {
                                                            print("Purchase failed with status: $status.");
                                                            Navigator.pop(context);
                                                            Fluttertoast.showToast(msg: status, timeInSecForIosWeb: 4);
                                                            return NavigationDecision.prevent;
                                                          }
                                                        }
                                                        return NavigationDecision.navigate;
                                                      },
                                                    ),
                                                  ));
                                                }
                                                else if(paymentGetApiController.paymentgetwayapi!.paymentdata[payment].title == "Khalti Payment"){
                                                  Navigator.push(context, MaterialPageRoute(
                                                    builder: (context) => PaymentWebVIew(
                                                      initialUrl: "${Config.baseurl}Khalti/index.php?amt=${walletController.text}",
                                                      navigationDelegate: (request) async {
                                                        final uri = Uri.parse(request.url);
                                                        print("Navigating to URL: ${request.url}");
                                                        print("Parsed URI: $uri");

                                                        // Check the status parameter instead of Result
                                                        final status = uri.queryParameters["status"];
                                                        final transactionn_id = uri.queryParameters["transaction_id"];
                                                        print("Hello Status:---- $status");
                                                        print("Hello Status:---- $transactionn_id");

                                                        if (status == null) {
                                                          print("No status parameter found.");
                                                        } else {
                                                          print("Status parameter: $status");
                                                          if (status == "Completed") {
                                                            print("Purchase successful.");
                                                            walletApiController.walletaddapi(wallet: walletController.text, uid: userdata['id'],context: context).then((value) {
                                                              walletReportApiController.walletreportApi(uid: userdata['id']);
                                                            });
                                                            return NavigationDecision.prevent;
                                                          } else {
                                                            print("Purchase failed with status: $status.");
                                                            Navigator.pop(context);
                                                            Fluttertoast.showToast(msg: status, timeInSecForIosWeb: 4);
                                                            return NavigationDecision.prevent;
                                                          }
                                                        }
                                                        return NavigationDecision.navigate;
                                                      },
                                                    ),
                                                  ));
                                                }


                                                else{
                                                  Get.back();
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(
                                                      content: Text('Not Valid'.tr),behavior: SnackBarBehavior.floating, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),),
                                                  );
                                                }

                                              },
                                              child: paymentGetApiController.paymentgetwayapi!.paymentdata[index].status == "0" ? SizedBox() : Container(
                                                height: 90,
                                                margin: const EdgeInsets.only(left: 10,right: 10,top: 6,bottom: 6),
                                                padding: const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  // color: Colors.yellowAccent,
                                                  border: Border.all(color: payment == index ? theamcolore : Colors.grey.withOpacity(0.4)),
                                                  borderRadius: BorderRadius.circular(15),
                                                ),
                                                child: Center(
                                                  child:  ListTile(
                                                    leading: Transform.translate(offset: const Offset(-5, 0),child: Container(
                                                      height: 100,
                                                      width: 60,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(15),
                                                          border: Border.all(color: Colors.grey.withOpacity(0.4)),
                                                          image: DecorationImage(image: NetworkImage('${Config.baseurl}/${paymentGetApiController.paymentgetwayapi!.paymentdata[index].img}'))
                                                      ),
                                                    ),),
                                                    title: Padding(
                                                      padding: const EdgeInsets.only(bottom: 4),
                                                      child: Text(paymentGetApiController.paymentgetwayapi!.paymentdata[index].title,style:  TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: notifier.textcolore),maxLines: 2,),
                                                    ),
                                                    subtitle: Padding(
                                                      padding: const EdgeInsets.only(bottom: 4),
                                                      child: Text(paymentGetApiController.paymentgetwayapi!.paymentdata[index].subtitle,style:  TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: notifier.textcolore),maxLines: 2,),
                                                    ),
                                                    trailing: Radio(
                                                      value: payment == index ? true : false,
                                                      fillColor:  MaterialStatePropertyAll(theamcolore),
                                                      groupValue: true,
                                                      onChanged: (value) {
                                                        print(value);
                                                        setState(() {
                                                          selectedOption = value.toString();
                                                          selectBoring = paymentGetApiController.paymentgetwayapi!.paymentdata[index].img;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },),
                      );
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
                          Text("Top-up".tr,style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              InkWell(
                onTap: () {
                  Share.share(
                    "You can download ${appName} and it just takes a few moments to get started. Your support would mean a lot to us and to the causes we’re working towards:${Platform.isAndroid
                        ? 'https://play.google.com/store/apps/details?id=${packageName}'
                        : Platform.isIOS
                        ? 'https://apps.apple.com/us/app/${appName}/id${packageName}'
                        : ""}",
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: theamcolore,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Join Our App and Make a Difference:",style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold)),
                                SizedBox(height: 5,),
                                Text("Donate Today!",style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold)),
                                const SizedBox(height: 15,),
                                Row(
                                  children: [
                                    Text("Invite friend",style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.yellow,fontSize: 14)),
                                    const SizedBox(width: 5,),
                                    const Icon(Icons.arrow_right_alt_sharp,color: Colors.yellow),
                                  ],
                                ),
                              ],
                            ),
                            Spacer(),
                            Lottie.asset('assets/lottie/walletsecounde.json',height: 100),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15,),

              Padding(
                padding: const EdgeInsets.only(left: 0,right: 0),
                child: Column(
                  children: [
                    walletReportApiController.walletReportApiModel!.walletitem.isEmpty ? const SizedBox() : Row(
                      children: [
                        Text('Transaction History'.tr,style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: notifier.textcolore),),
                        const Spacer(),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 7,),
              Expanded(
                child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return const SizedBox(width : 0,);
                    },
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: walletReportApiController.walletReportApiModel!.walletitem.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: const EdgeInsets.only(left: 0,right: 0,top: 4,bottom: 4),
                        decoration: BoxDecoration(
                          color: notifier.background,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: walletReportApiController.walletReportApiModel!.walletitem[index].status == 'Debit' ? const Image(image: AssetImage('assets/Debit.png'),height: 40):const Image(image: AssetImage('assets/Creadit.png'),height: 40),
                          title: Transform.translate(offset: const Offset(-6, 0),child: Text(walletReportApiController.walletReportApiModel!.walletitem[index].message,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: notifier.textcolore))),
                          subtitle: Transform.translate(offset: const Offset(-6, 0),child: Text(walletReportApiController.walletReportApiModel!.walletitem[index].status,style: const TextStyle(fontSize: 14,color: Colors.grey))),
                          trailing: Text('${walletReportApiController.walletReportApiModel!.walletitem[index].status == 'Debit' ? '-' : "+"} $currency1${walletReportApiController.walletReportApiModel!.walletitem[index].amt}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:  walletReportApiController.walletReportApiModel!.walletitem[index].status == "Debit"  ? Colors.red : Colors.green)),
                        ),
                      );
                    }),
              ),
            ],
          ),
        );
      },),
    );
  }



  // Strip code



  final _formKey = GlobalKey<FormState>();
  var numberController = TextEditingController();
  final _paymentCard = PaymentCardCreated();
  var _autoValidateMode = AutovalidateMode.disabled;

  final _card = PaymentCardCreated();


  stripePayment() {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Ink(
                    child: Column(
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height / 45),
                        Center(
                          child: Container(
                            height: MediaQuery.of(context).size.height / 85,
                            width: MediaQuery.of(context).size.width / 5,
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.4),
                                borderRadius: const BorderRadius.all(Radius.circular(20))),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                              Text("Add Your payment information".tr,
                                  style:  TextStyle(
                                      color: notifier.textcolore,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      letterSpacing: 0.5)),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                              Form(
                                key: _formKey,
                                autovalidateMode: _autoValidateMode,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 16),
                                    TextFormField(
                                      style:  TextStyle(color: notifier.textcolore),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(19),
                                        CardNumberInputFormatter()
                                      ],
                                      controller: numberController,
                                      onSaved: (String? value) {
                                        _paymentCard.number =
                                            CardUtils.getCleanedNumber(value!);

                                        CardTypee cardType =
                                        CardUtils.getCardTypeFrmNumber(
                                            _paymentCard.number.toString());
                                        setState(() {
                                          _card.name = cardType.toString();
                                          _paymentCard.type = cardType;
                                        });
                                      },
                                      onChanged: (val) {
                                        CardTypee cardType =
                                        CardUtils.getCardTypeFrmNumber(val);
                                        setState(() {
                                          _card.name = cardType.toString();
                                          _paymentCard.type = cardType;
                                        });
                                      },
                                      validator: CardUtils.validateCardNum,
                                      decoration: InputDecoration(
                                        prefixIcon: SizedBox(
                                          height: 10,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 14,
                                              horizontal: 6,
                                            ),
                                            child: CardUtils.getCardIcon(_paymentCard.type,),
                                          ),
                                        ),
                                        focusedErrorBorder:  OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey.withOpacity(0.4),
                                          ),
                                        ),
                                        errorBorder:  OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey.withOpacity(0.4),
                                          ),
                                        ),
                                        enabledBorder:  OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey.withOpacity(0.4),
                                          ),
                                        ),
                                        focusedBorder:  OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey.withOpacity(0.4),
                                          ),
                                        ),
                                        hintText:
                                         "What number is written on card?".tr,
                                        hintStyle: const TextStyle(color: Colors.grey),
                                        labelStyle: const TextStyle(color: Colors.grey),
                                        labelText: "Number".tr,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Flexible(
                                          flex: 4,
                                          child: TextFormField(
                                            style:  TextStyle(color: notifier.textcolore),
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                              LengthLimitingTextInputFormatter(4),
                                            ],
                                            decoration: InputDecoration(
                                                prefixIcon: const SizedBox(
                                                  height: 10,
                                                  child: Padding(
                                                    padding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 14),
                                                    child: Icon(Icons.credit_card,color: Color(0xff7D2AFF)),
                                                  ),
                                                ),
                                                focusedErrorBorder:
                                                OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.grey.withOpacity(0.4),
                                                  ),
                                                ),
                                                errorBorder:  OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.grey.withOpacity(0.4),
                                                  ),
                                                ),
                                                enabledBorder:  OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.grey.withOpacity(0.4),
                                                  ),
                                                ),
                                                focusedBorder:  OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                        Colors.grey.withOpacity(0.4))),
                                                hintText:  "Number behind the card".tr,
                                                hintStyle:
                                                const TextStyle(color: Colors.grey),
                                                labelStyle:
                                                const TextStyle(color: Colors.grey),
                                                labelText: "CVV".tr),
                                            validator: CardUtils.validateCVV,
                                            keyboardType: TextInputType.number,
                                            onSaved: (value) {
                                              _paymentCard.cvv = int.parse(value!);
                                            },
                                          ),
                                        ),
                                        SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                                        Flexible(
                                          flex: 4,
                                          child: TextFormField(
                                            style:  TextStyle(color: notifier.textcolore),
                                            inputFormatters: [
                                              FilteringTextInputFormatter.digitsOnly,
                                              LengthLimitingTextInputFormatter(4),
                                              CardMonthInputFormatter()
                                            ],
                                            decoration: InputDecoration(
                                              prefixIcon: const SizedBox(
                                                height: 10,
                                                child: Padding(
                                                  padding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 14),
                                                  child: Icon(Icons.calendar_month,color: Color(0xff7D2AFF)),
                                                ),
                                              ),
                                              errorBorder:  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.grey.withOpacity(0.4),
                                                ),
                                              ),
                                              focusedErrorBorder:
                                              OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.grey.withOpacity(0.4),
                                                ),
                                              ),
                                              enabledBorder:  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.grey.withOpacity(0.4),
                                                ),
                                              ),
                                              focusedBorder:  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.grey.withOpacity(0.4),
                                                ),
                                              ),
                                              hintText:  "MM/YY".tr,
                                              hintStyle:  const TextStyle(color: Colors.grey),
                                              labelStyle: const TextStyle(color: Colors.grey),
                                              labelText:  "Expiry Date".tr,
                                            ),
                                            validator: CardUtils.validateDate,
                                            keyboardType: TextInputType.number,
                                            onSaved: (value) {
                                              List<int> expiryDate =
                                              CardUtils.getExpiryDate(value!);
                                              _paymentCard.month = expiryDate[0];
                                              _paymentCard.year = expiryDate[1];
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.055),
                                    Container(
                                      alignment: Alignment.center,
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width,
                                        child: CupertinoButton(
                                          onPressed: () {
                                            _validateInputs();
                                          },
                                          color: const Color(0xff7D2AFF),
                                          child: Text(
                                            "Pay ${double.parse(walletController.text)}",
                                            style:  const TextStyle(fontSize: 17.0,color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.065),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            });
      },
    );
  }

  void _validateInputs() {
    final FormState form = _formKey.currentState!;
    if (!form.validate()) {
      setState(() {
        _autoValidateMode = AutovalidateMode.always;
      });

      Fluttertoast.showToast(msg:  "Please fix the errors in red before submitting.".tr,timeInSecForIosWeb: 4);
    }
    else {
      var username =  userdata['name'];
      var email =  userdata['email'];

      _paymentCard.name = username;
      _paymentCard.email = email;
      _paymentCard.amount = "${double.parse(walletController.text)}";
      form.save();
      print("........:--- ${_paymentCard.name}");
      print("........:--- ${_paymentCard.email}");
      print("........:--- ${_paymentCard.number}");
      print("........:--- ${_paymentCard.cvv}");
      print("........:--- ${_paymentCard.amount}");
      print("........:--- ${_paymentCard.month}");
      print("........:--- ${_paymentCard.year}");



      Navigator.push(context, MaterialPageRoute(
        builder: (context) => PaymentWebVIew(
          initialUrl: "${Config.baseurl}stripe/index.php?name=${_paymentCard.name}&email=${_paymentCard.email}&cardno=${_paymentCard.number}&cvc=${_paymentCard.cvv}&amt=${_paymentCard.amount}&mm=${_paymentCard.month}&yyyy=${_paymentCard.year}",
          navigationDelegate: (request) async {
            final uri = Uri.parse(request.url);
            print("Navigating to URL: ${request.url}");
            print("Parsed URI: $uri");

            // Check the status parameter instead of Result
            final status = uri.queryParameters["status"];
            final transaction_iddd = uri.queryParameters["Transaction_id"];
            print("........:--- $status");
            print("........:--- $transaction_iddd");
            if (status == null) {
              print("No status parameter found.");
            } else {
              print("Status parameter: $status");
              if (status == "success") {
                print("Purchase successful.");
                walletApiController.walletaddapi(wallet: walletController.text, uid: userdata['id'],context: context).then((value) {
                  walletReportApiController.walletreportApi(uid: userdata['id']);
                });
                return NavigationDecision.prevent;
              } else {
                print("Purchase failed with status: $status.");
                Navigator.pop(context);
                Fluttertoast.showToast(msg:status, timeInSecForIosWeb: 4);
                return NavigationDecision.prevent;
              }
            }
            return NavigationDecision.navigate;
          },
        ),
      ));

    }
  }


}


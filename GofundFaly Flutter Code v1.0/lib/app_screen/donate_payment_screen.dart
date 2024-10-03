// ignore_for_file: camel_case_types, prefer_final_fields, avoid_print, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gofunds/common/common_button.dart';
import 'package:gofunds/common/config.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../bootom_navigation_screen/home_screen.dart';
import '../common/light_dark_mode.dart';
import '../controller/login_controller.dart';
import '../payment_getway_screen/common_webview.dart';

import '../payment_getway_screen/inputformater.dart';


import '../payment_getway_screen/paymentcard.dart';
import '../payment_getway_screen/paypal.dart';
import '../payment_getway_screen/razorpay.dart';

class Donate_Payment_Screen extends StatefulWidget {
  final String id;
  final String title;
  final num remain_amt;
  final String walletamount;
  final String palteformfee;
  final String totalInvestment;
  final bool secoundcupon;
  const Donate_Payment_Screen({super.key, required this.id, required this.remain_amt, required this.title, required this.walletamount, required this.palteformfee, required this.totalInvestment, required this.secoundcupon});

  @override
  State<Donate_Payment_Screen> createState() => _Donate_Payment_ScreenState();
}

class _Donate_Payment_ScreenState extends State<Donate_Payment_Screen> {

  TextEditingController tipcontroller = TextEditingController();
  TextEditingController customtetfildecontroller = TextEditingController();
  double _currentSliderValue = 0.0;

  double _currentSliderValue1 = 0.0;
  double finaltotal = 0.0;
  double finaltotal2 = 0.0;
  double feeplateform = 0.0;
  double finaltipamount = 0.0;

  bool _ischeck = true;
  bool _custom = true;

  PaymentGetApiController paymentGetApiController = Get.put(PaymentGetApiController());
  DonatenowController donatenowController = Get.put(DonatenowController());
  PayStackPayMentApiController payStackPayMentApiController = Get.put(PayStackPayMentApiController());
  int payment = 0;
  String selectedOption = "";
  String selectBoring = "";

  @override
  void initState() {

    datagetfunction();
    paymentGetApiController.paymentlistApi(context);

    widget.remain_amt < 1 ?  _custom = widget.secoundcupon : true;


    razorPayClass.initiateRazorPay(handlePaymentSuccess: handlePaymentSuccess, handlePaymentError: handlePaymentError, handleExternalWallet: handleExternalWallet);


    super.initState();
  }

  double totalPayment = 0.0;

  double emoji = 0.0;

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



    emoji = widget.remain_amt / 5;


  }

  @override
  void dispose() {
    razorPayClass.desposRazorPay();
    super.dispose();
  }

  bool switchValue = false;
  double walletValue = 0;
  double mainpayment = 0.0;
  double walletMain = 0;


  double finaltotalpayment = 0;
  double afterpayment = 0;

  // Razorpay Code

  RazorPayClass razorPayClass = RazorPayClass();

  // Razorpay? _razorpay;

  void handlePaymentSuccess(PaymentSuccessResponse response){
    donatenowController.donateapi(platform_fees: feeplateform.toStringAsFixed(2),is_anonymous: isChecked == true ? "1" : "0" ,context: context,wall_amt: "$walletValue",fund_id: widget.id, uid: userData['id'], amt: "$finaltotalpayment", tip: "${_custom ? finaltotal2.toStringAsFixed(2) : finaltotal.toStringAsFixed(2)}", payment_method_id: paymentmethodId, transaction: "${response.paymentId}");
  }
  void handlePaymentError(PaymentFailureResponse response){
    Fluttertoast.showToast(msg: 'ERROR HERE: ${response.code} - ${response.message}',timeInSecForIosWeb: 4);
  }
  void handleExternalWallet(ExternalWalletResponse response){
    Fluttertoast.showToast(msg: 'EXTERNAL_WALLET IS: ${response.walletName}',timeInSecForIosWeb: 4);
  }

  String paymentmethodId = '1';

  ColorNotifier notifier = ColorNotifier();

  HomeApiController homeApiController = Get.put(HomeApiController());
  bool isChecked = false;
  int anonymus = 0;

  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return ClipRRect(
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: notifier.background,
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 80,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: notifier.background,
                  // color: Colors.red,
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10,top: 20),
                child: CommonButtonsmallround(containcolore: theamcolore, txt1: 'Donate Now'.tr, context: context,onPressed1: () {

                  homeApiController.isLoading = true;
                  switchValue = false;

                  mainpayment = _custom ? afterpayment : afterpayment;
                  finaltotalpayment = _custom ? _currentSliderValue1 : double.parse(customtetfildecontroller.text);


                  (_currentSliderValue1 == 0 && customtetfildecontroller.text.isEmpty) ? const SizedBox() : showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
                    ),
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(
                          builder: (context, setState)  {
                            return ClipRRect(
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
                              child: Scaffold(
                                backgroundColor: notifier.containercolore,
                                floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                                floatingActionButton: Padding(
                                  padding: const EdgeInsets.only(bottom: 10,left: 10,right: 10),
                                  child: mainpayment <= 0.0 ?
                                  Container(
                                    height: 42,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: theamcolore,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: ElevatedButton(
                                      style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(theamcolore),shape: const MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))))),
                                      onPressed: () async {
                                        SharedPreferences preferences = await SharedPreferences.getInstance();
                                        donatenowController.donateapi(platform_fees: feeplateform.toStringAsFixed(2),is_anonymous: isChecked == true ? "1" : "0" ,context: context,wall_amt: "$walletValue",fund_id: widget.id, uid: userData['id'], amt: "$finaltotalpayment", tip: "${_custom ? finaltotal2.toStringAsFixed(2) : finaltotal.toStringAsFixed(2)}", payment_method_id: paymentmethodId, transaction: "0");
                                      },
                                      child: Center(
                                        child: RichText(text:  TextSpan(
                                            children: [
                                              TextSpan(text: 'Wallet Pay'.tr,style: const TextStyle(fontSize: 15,fontFamily: "SofiaProBold")),
                                            ]
                                        )),
                                      ),
                                    ),
                                  )
                                      :
                                  Container(
                                    height: 42,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: theamcolore,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: ElevatedButton(
                                      style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(theamcolore),shape: const MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))))),
                                      onPressed: () {
                                        if(paymentGetApiController.paymentgetwayapi!.paymentdata[payment].title == "Razorpay"){
                                          Get.back();
                                          razorPayClass.openCheckout(key: paymentGetApiController.paymentgetwayapi!.paymentdata[0].attributes, amount: '$mainpayment', number: '${userData['mobile']}', name: '${userData['email']}');
                                        }
                                        else if(paymentGetApiController.paymentgetwayapi!.paymentdata[payment].title == "Paypal"){
                                          List ids = paymentGetApiController.paymentgetwayapi!.paymentdata[1].attributes.toString().split(",");
                                          print('++++++++++ids:------$ids');
                                          paypalPayment(
                                            context: context,
                                            function: (e){
                                              donatenowController.donateapi(platform_fees: feeplateform.toStringAsFixed(2),is_anonymous: isChecked == true ? "1" : "0" ,context: context,wall_amt: "$walletValue",fund_id: widget.id, uid: userData['id'], amt: "$finaltotalpayment", tip: "${_custom ? finaltotal2.toStringAsFixed(2) : finaltotal.toStringAsFixed(2)}", payment_method_id: paymentmethodId, transaction: "$e");
                                            },
                                            amt: "$mainpayment",
                                            clientId: ids[0],
                                            secretKey: ids[1],
                                          );
                                        }
                                        else if(paymentGetApiController.paymentgetwayapi!.paymentdata[payment].title == "Stripe"){
                                          stripePayment();
                                        }
                                        else if(paymentGetApiController.paymentgetwayapi!.paymentdata[payment].title == "PayStack"){

                                          payStackPayMentApiController.paystackApi(email: userData['email'], amount: "$mainpayment",context: context).then((value) {


                                            Navigator.push(context, MaterialPageRoute(
                                              builder: (context) => PaymentWebVIew(
                                                initialUrl: "$value",
                                                navigationDelegate: (request) async {
                                                  final uri = Uri.parse(request.url);


                                                  // Check the status parameter instead of Result
                                                  final status = uri.queryParameters["status"];


                                                  if (status == null) {
                                                    print("No status parameter found.");
                                                  } else {
                                                    print("Status parameter: $status");
                                                    if (status == "success") {
                                                      print("Purchase successful.");
                                                      donatenowController.donateapi(platform_fees: feeplateform.toStringAsFixed(2),is_anonymous: isChecked == true ? "1" : "0" ,context: context,wall_amt: "$walletValue",fund_id: widget.id, uid: userData['id'], amt: "$finaltotalpayment", tip: "${_custom ? finaltotal2.toStringAsFixed(2) : finaltotal.toStringAsFixed(2)}", payment_method_id: paymentmethodId, transaction: "");
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
                                              initialUrl: "${Config.baseurl}flutterwave/index.php?amt=$mainpayment&email=${userData['email']}",
                                              navigationDelegate: (request) async {
                                                final uri = Uri.parse(request.url);
                                                print("Navigating to URL: ${request.url}");
                                                print("Parsed URI: $uri");

                                                // Check the status parameter instead of Result
                                                final status = uri.queryParameters["status"];
                                                final transactionn_id = uri.queryParameters["transaction_id"];


                                                if (status == null) {
                                                  print("No status parameter found.");
                                                } else {
                                                  print("Status parameter: $status");
                                                  if (status == "successful") {
                                                    print("Purchase successful.");
                                                    donatenowController.donateapi(platform_fees: feeplateform.toStringAsFixed(2),is_anonymous: isChecked == true ? "1" : "0" ,context: context,wall_amt: "$walletValue",fund_id: widget.id, uid: userData['id'], amt: "$finaltotalpayment", tip: "${_custom ? finaltotal2.toStringAsFixed(2) : finaltotal.toStringAsFixed(2)}", payment_method_id: paymentmethodId, transaction: "$transactionn_id");
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
                                              initialUrl: "${Config.baseurl}paytm/index.php?amt=$mainpayment&uid=${userData['id']}",
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
                                                    donatenowController.donateapi(platform_fees: feeplateform.toStringAsFixed(2),is_anonymous: isChecked == true ? "1" : "0" ,context: context,wall_amt: "$walletValue",fund_id: widget.id, uid: userData['id'], amt: "$finaltotalpayment", tip: "${_custom ? finaltotal2.toStringAsFixed(2) : finaltotal.toStringAsFixed(2)}", payment_method_id: paymentmethodId, transaction: "$transaction_idddd");
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
                                              initialUrl: "${Config.baseurl}result.php?detail=Movers&amount=$mainpayment&order_id=$notificationId&name=${userData['name']}&email=${userData['email']}&phone=${userData['mobile']}",
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
                                                    donatenowController.donateapi(platform_fees: feeplateform.toStringAsFixed(2),is_anonymous: isChecked == true ? "1" : "0" ,context: context,wall_amt: "$walletValue",fund_id: widget.id, uid: userData['id'], amt: "$finaltotalpayment", tip: "${_custom ? finaltotal2.toStringAsFixed(2) : finaltotal.toStringAsFixed(2)}", payment_method_id: paymentmethodId, transaction: "$transactionn_id");
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
                                              initialUrl: "${Config.baseurl}merpago/index.php?amt=$mainpayment",
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
                                                    donatenowController.donateapi(platform_fees: feeplateform.toStringAsFixed(2),is_anonymous: isChecked == true ? "1" : "0" ,context: context,wall_amt: "$walletValue",fund_id: widget.id, uid: userData['id'], amt: "$finaltotalpayment", tip: "${_custom ? finaltotal2.toStringAsFixed(2) : finaltotal.toStringAsFixed(2)}", payment_method_id: paymentmethodId, transaction: "");
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
                                              initialUrl: "${Config.baseurl}Payfast/index.php?amt=$mainpayment",
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
                                                    donatenowController.donateapi(platform_fees: feeplateform.toStringAsFixed(2),is_anonymous: isChecked == true ? "1" : "0" ,context: context,wall_amt: "$walletValue",fund_id: widget.id, uid: userData['id'], amt: "$finaltotalpayment", tip: "${_custom ? finaltotal2.toStringAsFixed(2) : finaltotal.toStringAsFixed(2)}", payment_method_id: paymentmethodId, transaction: "$payment_iddd");
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
                                              initialUrl: "${Config.baseurl}Midtrans/index.php?name=${userData['name']}&email=${userData['email']}&phone=${userData['mobile']}&amt=$mainpayment",
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
                                                    donatenowController.donateapi(platform_fees: feeplateform.toStringAsFixed(2),is_anonymous: isChecked == true ? "1" : "0" ,context: context,wall_amt: "$walletValue",fund_id: widget.id, uid: userData['id'], amt: "$finaltotalpayment", tip: "${_custom ? finaltotal2.toStringAsFixed(2) : finaltotal.toStringAsFixed(2)}", payment_method_id: paymentmethodId, transaction: "$order_iddd");
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
                                              initialUrl: "${Config.baseurl}2checkout/index.php?amt=$mainpayment",
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
                                                    donatenowController.donateapi(platform_fees: feeplateform.toStringAsFixed(2),is_anonymous: isChecked == true ? "1" : "0" ,context: context,wall_amt: "$walletValue",fund_id: widget.id, uid: userData['id'], amt: "$finaltotalpayment", tip: "0", payment_method_id: paymentmethodId, transaction: "");
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
                                              initialUrl: "${Config.baseurl}Khalti/index.php?amt=$mainpayment",
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
                                                    donatenowController.donateapi(platform_fees: feeplateform.toStringAsFixed(2),is_anonymous: isChecked == true ? "1" : "0" ,context: context,wall_amt: "$walletValue",fund_id: widget.id, uid: userData['id'], amt: "$finaltotalpayment", tip: "${_custom ? finaltotal2.toStringAsFixed(2) : finaltotal.toStringAsFixed(2)}", payment_method_id: paymentmethodId, transaction: "$transactionn_id");
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
                                              content: Text('Not Valid'.tr),behavior: SnackBarBehavior.floating, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                            ),
                                          );
                                        }
                                      },
                                      child: Center(
                                        child: RichText(text:  TextSpan(
                                            children: [
                                              TextSpan(text: 'CONTINUE'.tr,style: const TextStyle(fontSize: 15,fontFamily: "SofiaProBold")),
                                            ]
                                        )),
                                      ),
                                    ),
                                  )
                                ),
                                body: Container(
                                  // height: 450,
                                  decoration: BoxDecoration(
                                    color: notifier.containercolore,
                                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
                                  ),
                                  child:  Padding(
                                    padding: const EdgeInsets.only(left: 10,right: 10,bottom: 50),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget> [

                                        const SizedBox(height: 13,),
                                        Text('Payment Getway Method'.tr,style:   TextStyle(fontFamily: "SofiaProBold",fontSize: 18,color: notifier.textcolore)),
                                        widget.walletamount == "0" ? const SizedBox() : const SizedBox(height: 10,),
                                        widget.walletamount == "0" ? const SizedBox() :  Row(
                                          children: [
                                            SvgPicture.asset("assets/icons/wallet.svg",height: 30,color: theamcolore,),
                                            const SizedBox(width: 10,),
                                            switchValue ?  Text("My Wallet ($currency1${walletMain.toStringAsFixed(2)})",style: TextStyle(color: notifier.textcolore),) : Text("My Wallet ($currency1${double.parse(widget.walletamount).toStringAsFixed(2)})",style: TextStyle(color: notifier.textcolore),),
                                            const Spacer(),
                                            Transform.scale(
                                              scale: 0.8,
                                              child: CupertinoSwitch(
                                                value: switchValue,
                                                activeColor: theamcolore,
                                                onChanged: (bool value) {

                                                  setState(() {
                                                    switchValue = value;
                                                    mainpayment = _custom ? afterpayment : afterpayment;
                                                    walletMain = double.parse(widget.walletamount);
                                                    print("+++ walletMain +++:-($walletValue)");
                                                    print("+++ mainpayment +++:-($mainpayment)");

                                                    if(switchValue) {
                                                      print("hello if$walletMain");

                                                      if (mainpayment > walletMain) {
                                                        walletValue = walletMain;
                                                        mainpayment -= walletValue;
                                                        walletMain = 0;
                                                        print("///////// $walletMain");
                                                      } else {
                                                        walletValue = mainpayment;
                                                        mainpayment -= mainpayment;
                                                        double good = double.parse(widget.walletamount);
                                                        walletMain = (good - walletValue);
                                                        print("++++++ good +++++ : --   $walletMain");
                                                        print("++++++ good +++++ : --   $walletValue");
                                                      }
                                                    }else{
                                                      print("hello else");
                                                      walletValue = 0;
                                                      walletMain = double.parse(widget.walletamount);
                                                      mainpayment = _custom ? afterpayment : afterpayment;
                                                    }
                                                    print("+++ mainpayment +++:-($mainpayment)");

                                                  });

                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 10,),
                                        Expanded(
                                          child: ListView.separated(
                                              separatorBuilder: (context, index) {
                                                return const SizedBox(width: 0);
                                              },
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount: paymentGetApiController.paymentgetwayapi!.paymentdata.length,
                                              itemBuilder: (BuildContext context, int index) {
                                                return  mainpayment <= 0.0 ? InkWell(
                                                  onTap: () {

                                                  },
                                                  child: paymentGetApiController.paymentgetwayapi!.paymentdata[index].status == "0" ? const SizedBox() : Container(
                                                    height: 90,
                                                    margin: const EdgeInsets.only(left: 10,right: 10,top: 6,bottom: 6),
                                                    padding: const EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                      // color: Colors.yellowAccent,
                                                      border: Border.all(color: Colors.grey.withOpacity(0.4)),
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
                                                          child: Text(paymentGetApiController.paymentgetwayapi!.paymentdata[index].title,style:   TextStyle(fontSize: 16,fontFamily: "SofiaProBold",color: notifier.textcolore),maxLines: 2,),
                                                        ),
                                                        subtitle: Padding(
                                                          padding: const EdgeInsets.only(bottom: 4),
                                                          child: Text(paymentGetApiController.paymentgetwayapi!.paymentdata[index].subtitle,style:   TextStyle(fontSize: 12,fontFamily: "SofiaProBold",color: notifier.textcolore),maxLines: 2,),
                                                        ),
                                                        trailing: Radio(
                                                          value:  false,
                                                          fillColor: MaterialStatePropertyAll(theamcolore),
                                                          groupValue: true,
                                                          onChanged: (value) {
                                                            print(value);
                                                            setState(() {
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ) : InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      payment = index;
                                                      paymentmethodId = paymentGetApiController.paymentgetwayapi!.paymentdata[index].id;
                                                    });
                                                  },
                                                  child: paymentGetApiController.paymentgetwayapi!.paymentdata[index].status == "0" ? const SizedBox() :  Container(
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
                                                          child: Text(paymentGetApiController.paymentgetwayapi!.paymentdata[index].title,style: TextStyle(fontSize: 16,fontFamily: "SofiaProBold",color: notifier.textcolore),maxLines: 2,),
                                                        ),
                                                        subtitle: Padding(
                                                          padding: const EdgeInsets.only(bottom: 4),
                                                          child: Text(paymentGetApiController.paymentgetwayapi!.paymentdata[index].subtitle,style: TextStyle(fontSize: 12,fontFamily: "SofiaProBold",color: notifier.textcolore),maxLines: 2,),
                                                        ),
                                                        trailing: Radio(
                                                          value: payment == index ? true : false,
                                                          fillColor: MaterialStatePropertyAll(theamcolore),
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
                              ),
                            );
                          }
                      );
                    },
                  );

                }),
              ),
            )
          ],
        ),
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 40,
          backgroundColor: notifier.background,
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(Icons.arrow_back,color: notifier.textcolore,size: 22),
          ),
          title: Transform.translate(offset: const Offset(-20, 0),child:  Text('GoFund'.tr,style: TextStyle(color: notifier.textcolore,fontSize: 18,fontWeight: FontWeight.bold))),
        ),
        body: GetBuilder<PaymentGetApiController>(builder: (paymentGetApiController) {
          return  paymentGetApiController.isLoading ? Center(child: CircularProgressIndicator(color: theamcolore,)) : Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _custom ? widget.remain_amt <1 ? const SizedBox() : Column(
                    children: [
                      Row(
                        children: [
                          const Spacer(),
                          const Spacer(),
                          Container(
                            // color: Colors.red,
                            alignment: Alignment.center,
                              width: 270,
                              child: Text('$currency1${_currentSliderValue1.toStringAsFixed(2)}',style: TextStyle(color: theamcolore,fontSize: 45,fontFamily: "SofiaProBold"),overflow: TextOverflow.ellipsis,)),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _custom =! _custom;
                                print("${_custom}");
                                _custom ? _currentSliderValue = 0.00 : _currentSliderValue = 0.00;
                                _custom ? _currentSliderValue1 = 0.00 : _currentSliderValue1 = 0.00;
                                feeplateform = 0.00;
                                afterpayment = 0.00;
                              });
                            },
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                border: Border.all(color: theamcolore),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Center(child: Text('Custom'.tr,style: TextStyle(color: theamcolore),)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            trackHeight: 10.0,
                            activeTrackColor: theamcolore,
                            thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 8,
                              pressedElevation: 8.0,
                            ),
                            trackShape: CustomTrackShape(),
                            activeTickMarkColor: Colors.transparent,
                            inactiveTickMarkColor: Colors.transparent,
                            inactiveTrackColor: theamcolore.withOpacity(0.1),
                          ),
                          child: Slider(
                            activeColor: theamcolore,
                            value: _currentSliderValue1,
                            max: widget.remain_amt.toDouble(),
                            divisions: widget.remain_amt.toInt(),
                            label: "$currency1${_currentSliderValue1.round().toString()}",
                            onChanged: (double value) {
                              setState(() {
                                _currentSliderValue1 = value;

                                afterpayment = double.parse(_currentSliderValue1.toStringAsFixed(2))/2;
                                _currentSliderValue = 0.00;
                                finaltotal = 0.00;
                                finaltotal2 = 0.00;
                                print("::::::-- ${feeplateform}");
                              });
                            },
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text('${currency1}0',style: const TextStyle(color: Colors.grey),),
                          const Spacer(),
                          Text('${_currentSliderValue1 < emoji *1 ? '🙂' : _currentSliderValue1 < emoji *2 ? '😃' : _currentSliderValue1 < emoji *3 ? '😊' : _currentSliderValue1 < emoji *4 ? '😉' : '😍' } $currency1${_currentSliderValue1.toStringAsFixed(2)}',style: TextStyle(color: notifier.textcolore,fontFamily: "SofiaProBold"),),
                          const Spacer(),
                          Text('$currency1${widget.remain_amt.toStringAsFixed(2)}',style: const TextStyle(color: Colors.grey),),
                        ],
                      ),
                    ],
                  ) : Column(
                    children: [
                      RichText(text: TextSpan(
                          children: [
                            TextSpan(text: 'You`re supporting '.tr,style: TextStyle(color: notifier.textcolore,fontSize: 16,fontFamily: 'SofiaRegular')),
                            TextSpan(text: 'Support ${widget.title}'.tr,style: TextStyle(color: notifier.textcolore,fontFamily: "SofiaProBold",fontSize: 16)),
                          ]
                      )),
                      const SizedBox(height: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Enter your donation'.tr,style: TextStyle(color: notifier.textcolore,fontFamily: "SofiaProBold",fontSize: 16)),
                          const SizedBox(height: 10,),
                          TextFormField(
                            onChanged: (value) {
                            setState(() {

                              if(double.parse(value) <= 0){
                                customtetfildecontroller.clear();
                                Fluttertoast.showToast(msg: "Enter an amount (${currency1}${widget.remain_amt.toStringAsFixed(2)}) equal to or less than the specified limit.");
                              }

                                if(widget.remain_amt < double.parse(value)){
                                  customtetfildecontroller.clear();
                                  Fluttertoast.showToast(msg: "Enter an amount (${currency1}${widget.remain_amt.toStringAsFixed(2)}) equal to or less than the specified limit.");
                                }

                              _currentSliderValue = 0.00;



                              afterpayment = double.parse(customtetfildecontroller.text)/2;
                            });
                              print("----:-- ${feeplateform}");
                            },
                            keyboardType: TextInputType.number,
                            controller: customtetfildecontroller,
                            textAlign: TextAlign.end,
                            style: TextStyle(fontFamily: "SofiaProBold",fontSize: 35,color: notifier.textcolore),
                            decoration:  InputDecoration(
                              // contentPadding: const EdgeInsets.only(left: 10,top: 10),
                              focusColor: Colors.red,
                              border: InputBorder.none,
                              hintStyle:  TextStyle(fontFamily: "SofiaProBold",fontSize: 35,color: notifier.textcolore),
                              hintText: '000.00',
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('$currency1',style: TextStyle(color: notifier.textcolore,fontFamily: "SofiaProBold",fontSize: 35)),
                                  ],
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.4)),
                                  borderRadius: const BorderRadius.all(Radius.circular(10))
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: theamcolore,width: 2),
                                  borderRadius: const BorderRadius.all(Radius.circular(10))
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5,),
                      widget.remain_amt <1 ? const SizedBox() :    InkWell(
                          onTap: () {
                            setState(() {
                              _custom =! _custom;
                              print("${_custom}");
                              _custom ? _currentSliderValue = 0.00 : _currentSliderValue = 0.00;
                              _custom ? _currentSliderValue1 = 0.00 : _currentSliderValue1 = 0.00;
                              feeplateform = 0.00;
                              afterpayment = 0.00;

                            });
                          },
                          child:  Text('Back to default'.tr,style: TextStyle(color: notifier.textcolore,decoration: TextDecoration.underline))
                      )
                    ],
                  ),

                  const SizedBox(height: 25,),
                  Text('Tip GoFund services'.tr,style: TextStyle(fontSize: 16,fontFamily: "GilroyBold",color: notifier.textcolore),),
                  // const SizedBox(height: 10,),
                  _ischeck ? Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 10.0,
                        activeTrackColor: theamcolore,
                        thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 8.0,
                          pressedElevation: 8.0,
                        ),
                        trackShape: CustomTrackShape(),
                        activeTickMarkColor: Colors.transparent,
                        inactiveTickMarkColor: Colors.transparent,
                        inactiveTrackColor: theamcolore.withOpacity(0.1),
                      ),
                      child: Slider(
                        activeColor: theamcolore,
                        value: _currentSliderValue,
                        max: 30,
                        divisions: 30,
                        label: "$currency1${_custom ? finaltotal2.toStringAsFixed(2) : finaltotal.toStringAsFixed(2)} (${_currentSliderValue.round().toString()})%",
                        onChanged: (double value) {
                          setState(() {

                            if(_custom == false){
                              if(customtetfildecontroller.text.isNotEmpty){
                                setState(() {
                                  _currentSliderValue = value;
                                  finaltotal =  (double.parse(customtetfildecontroller.text) * double.parse(_currentSliderValue.round().toString()) / 100);
                                  afterpayment = double.parse(customtetfildecontroller.text) + double.parse(feeplateform.toStringAsFixed(2)) + double.parse(finaltotal.toStringAsFixed(2));
                                  print("vvvvvvvv");
                                });
                              }
                              else{
                                setState(() {
                                  _currentSliderValue = value;
                                  print("qqqqqqq");
                                });
                              }
                            }
                            else{
                              if(_currentSliderValue1 == 0){
                                setState(() {
                                  _currentSliderValue = value;
                                  print("hhhhhh");
                                });
                              }
                              else{
                                setState(() {
                                  _currentSliderValue = value;
                                  finaltotal2 =  (_currentSliderValue1 * double.parse(_currentSliderValue.round().toString()) / 100);
                                  // afterpayment = finaltotal2;
                                  afterpayment = double.parse(_currentSliderValue1.toStringAsFixed(2)) + double.parse(feeplateform.toStringAsFixed(2)) + double.parse(finaltotal2.toStringAsFixed(2));
                                  print("ffffffff");
                                });
                              }
                            }

                          });
                        },
                      ),
                    ),
                  ) : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Tip amount'.tr,style: TextStyle(color: notifier.textcolore,fontFamily: "GilroyBold",fontSize: 16)),
                          const Spacer(),
                          InkWell(
                              onTap: () {
                                setState(() {
                                  _ischeck =! _ischeck;
                                  _ischeck ? _currentSliderValue = 0.00 : _currentSliderValue = 0.00;
                                  feeplateform = _currentSliderValue1 * double.parse(widget.palteformfee) / 100;
                                  afterpayment = double.parse(_currentSliderValue1.toStringAsFixed(2)) + double.parse(feeplateform.toStringAsFixed(2));
                                  tipcontroller.clear();
                                  print("object+++:-- ${_ischeck}");
                                  // afterpayment = afterpayment - _currentSliderValue;
                                });
                              },
                              child:  Text('Back to default'.tr,style: TextStyle(color: notifier.textcolore,decoration: TextDecoration.underline)))
                        ],
                      ),
                      const SizedBox(height: 10,),
                      TextFormField(
                        controller: tipcontroller,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {

                            if(_ischeck == false){
                              afterpayment = _custom ?
                              double.parse(_currentSliderValue1.toStringAsFixed(2)) + double.parse(feeplateform.toStringAsFixed(2)) + double.parse(tipcontroller.text)
                                      :
                                  double.parse(customtetfildecontroller.text) + double.parse(feeplateform.toStringAsFixed(2)) + double.parse(tipcontroller.text);

                              print("**iff**:--- ${afterpayment}");
                            }
                            else{
                              afterpayment = _custom ?
                              double.parse(_currentSliderValue1.toStringAsFixed(2)) + double.parse(feeplateform.toStringAsFixed(2)) + double.parse(tipcontroller.text)
                                  :
                              double.parse(customtetfildecontroller.text) + double.parse(feeplateform.toStringAsFixed(2)) + double.parse(tipcontroller.text);
                              print("**else**:--- ${afterpayment}");
                            }

                          });

                        },
                        style:  TextStyle(fontFamily: "GilroyBold",fontSize: 14,color: notifier.textcolore),
                        decoration:  InputDecoration(
                          focusColor: Colors.red,
                          border: InputBorder.none,
                          hintStyle:  TextStyle(fontFamily: "GilroyBold",fontSize: 14,color: notifier.textcolore),
                          hintText: 'Enter amount'.tr,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey.withOpacity(0.4)),
                              borderRadius: const BorderRadius.all(Radius.circular(10))
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: theamcolore),
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      )
                    ],
                  ),

                  Divider(color: Colors.grey.withOpacity(0.4),),
                  Row(
                    children: [
                      Transform.scale(
                        scale: 1.1,
                        child: Checkbox(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3),
                          ),
                          checkColor: Colors.white,
                          activeColor: theamcolore,
                          side: BorderSide(color: Colors.grey.withOpacity(0.4)),
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                              anonymus = 1;
                              print("**:-- ${isChecked}");
                            });
                          },
                        ),
                      ),
                      Flexible(child: InkWell(
                          onTap: () {
                            setState(() {
                              isChecked = !isChecked;
                              anonymus = 1;
                              print("**:-- ${isChecked}");
                            });
                          },
                          child: Text("Don`t display my name publicy on the campaign.".tr,style: TextStyle(fontSize: 14,color: notifier.textcolore,fontWeight: FontWeight.bold),maxLines: 2,)))
                    ],
                  ),
                  Divider(color: Colors.grey.withOpacity(0.4),),
                  const SizedBox(height: 10,),
                  Text("Your donation".tr,style: TextStyle(color: notifier.textcolore,fontSize: 18,fontWeight: FontWeight.bold),),
                  const SizedBox(height: 20,),
                  Row(
                    children: [
                      Text("Your donation".tr,style: TextStyle(color: notifier.textcolore,fontSize: 16),),
                      Spacer(),
                      Text("${currency1}${_custom ?  _currentSliderValue1.toStringAsFixed(2) : customtetfildecontroller.text.isEmpty ? "0.00" : customtetfildecontroller.text}",style: TextStyle(color: notifier.textcolore,fontSize: 16),),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      Text("Platform Fee(${widget.palteformfee}%)",style: TextStyle(color: notifier.textcolore,fontSize: 16),),
                      const Spacer(),
                      Text("${currency1}${_custom ? feeplateform.toStringAsFixed(2) : customtetfildecontroller.text.isEmpty ? "0.00" : feeplateform.toStringAsFixed(2)}",style: TextStyle(color: notifier.textcolore,fontSize: 16,),),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      Text("Tip (${_ischeck ? _currentSliderValue.round().toString() : 0}%)",style: TextStyle(color: notifier.textcolore,fontSize: 16),),
                      const Spacer(),
                      // Text(_ischeck ? _currentSliderValue == 0.00 ? "0.00" : finaltotal2.toStringAsFixed(2) : _custom ?  tipcontroller.text.isEmpty ? "0.00" : tipcontroller.text : finaltotal.toStringAsFixed(2),style: TextStyle(color: notifier.textcolore,fontSize: 16,),),
                      Text("${currency1}${_currentSliderValue == 0.00 ? "0.00" :  _custom ? finaltotal2.toStringAsFixed(2) : finaltotal.toStringAsFixed(2)}",style: TextStyle(color: notifier.textcolore,fontSize: 16,),),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    children: [
                      Text("Total due today".tr,style: TextStyle(color: notifier.textcolore,fontSize: 16),),
                      const Spacer(),
                      Text("${currency1}${_custom ? afterpayment.toStringAsFixed(2) : customtetfildecontroller.text.isEmpty ? "0.00" : afterpayment.toStringAsFixed(2)}",style: TextStyle(color: notifier.textcolore,fontSize: 16,),),
                    ],
                  ),



                ],
              ),
            ),
          );
        },),
      ),
    );
  }


  //Strip code


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
                                            "Pay $mainpayment",
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
      var username =  userData['name'];
      var email =  userData['email'];

      _paymentCard.name = username;
      _paymentCard.email = email;
      _paymentCard.amount = "$mainpayment";
      form.save();



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
                // Get.back();
                donatenowController.donateapi(platform_fees: feeplateform.toStringAsFixed(2),is_anonymous: isChecked == true ? "1" : "0" ,context: context,wall_amt: "$walletValue",fund_id: widget.id, uid: userData['id'], amt: "$finaltotalpayment", tip: "${_custom ? finaltotal2.toStringAsFixed(2) : finaltotal.toStringAsFixed(2)}", payment_method_id: paymentmethodId, transaction: "$transaction_iddd");
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

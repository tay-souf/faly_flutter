// ignore_for_file: camel_case_types, avoid_print, use_build_context_synchronously, empty_catches

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gofunds/auth_screen/login_screen.dart';
import 'package:gofunds/common/common_button.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common/light_dark_mode.dart';
import '../controller/login_controller.dart';

class Sign_Up extends StatefulWidget {
  final bool social;
  final String socialemail;
  const Sign_Up({super.key, required this.social, required this.socialemail});

  @override
  State<Sign_Up> createState() => _Sign_UpState();
}

class _Sign_UpState extends State<Sign_Up> {

  SignupController signupController = Get.put(SignupController());

  MobilCheckController mobilCheckController = Get.put(MobilCheckController());
  SocialController socialController = Get.put(SocialController());
  SmstypeApiController smstypeApiController = Get.put(SmstypeApiController());

  MasgapiController masgapiController = Get.put(MasgapiController());
  TwilioapiController twilioapiController = Get.put(TwilioapiController());

  bool _obscureText = true;
  OtpFieldController otpController = OtpFieldController();
  String smscode = '';
  int? otpvaraible;

  // api paramitor controller

  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController signupmobilecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();


  String ccode ="";
  int langth = 10;

  bool isLoading = false;
  String otpstatus = "";

  @override
  void initState() {
    emailcontroller.text = widget.socialemail;
    smstypeApiController.smsApi(context);
    super.initState();
  }



  int secondsRemaining = 30;
  bool enableResend = false;
  Timer? timer;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        if (secondsRemaining > 0) {
          secondsRemaining--;
        } else {
          enableResend = true;
          t.cancel(); // Cancel timer when done
        }
      });
    });
  }

  void _resendCode() {
    setState(() {
      secondsRemaining = 30;
      enableResend = false;
      startTimer();
    });
  }



  ColorNotifier notifier = ColorNotifier();

  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: notifier.background,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 35,),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child:  Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            shape: BoxShape.circle
                          ),
                          child: Icon(Icons.arrow_back,color: notifier.textcolore,size: 25,)),
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 40,),
                Text('Create an account'.tr,style: TextStyle(color: notifier.textcolore,fontSize: 22,fontFamily: "SofiaProBold"),),
                const SizedBox(height: 10,),
                RichText(text:  TextSpan(
                    children: [
                      TextSpan(text: 'Welcome back to your home for help. Please enter your account details below to sign in.'.tr,style:  TextStyle(color: Colors.grey,fontSize: 16,fontFamily: 'SofiaRegular')),
                    ]
                )),
                SizedBox(height: Get.height * 0.035,),
                CommonTextfiled10(context: context,txt: 'Full name'.tr,suffeximage: 'assets/user.png',controller: namecontroller),
                SizedBox(height: Get.height * 0.015,),
                widget.social == false ? CommonTextfiled10(context: context,txt: 'Email'.tr,suffeximage: 'assets/email.png',controller: emailcontroller):
                CommonTextfiledreadonly(context: context,txt: widget.socialemail,suffeximage: 'assets/email.png',controller: emailcontroller),
                SizedBox(height: Get.height * 0.015,),
                IntlPhoneField(
                  controller: signupmobilecontroller,
                  decoration:  InputDecoration(
                    counterText: "",
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.withOpacity(0.4)),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    labelText: 'Phone Number'.tr,
                    labelStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                    ),
                    border:  OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey,),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide:  BorderSide(color: theamcolore),
                        borderRadius: BorderRadius.circular(15)
                    ),

                  ),
                  style:  TextStyle(color: notifier.textcolore),
                  flagsButtonPadding: EdgeInsets.zero,
                  showCountryFlag: false,
                  showDropdownIcon: false,
                  initialCountryCode: 'IN',
                  dropdownTextStyle:   TextStyle(color: notifier.textcolore,fontSize: 15),
                  onCountryChanged: (value) {
                    setState(() {
                      langth = value.maxLength;
                    });
                  },
                  onChanged: (number) {
                    setState(() {
                      ccode = number.countryCode;
                    });
                  },
                ),
                SizedBox(height: Get.height * 0.015,),
                TextField(
                  controller: passwordcontroller,
                  obscureText: _obscureText,
                  style:  TextStyle(color: notifier.textcolore),
                  decoration: InputDecoration(
                    suffixIconColor: theamcolore,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText =! _obscureText;
                        });
                      },
                      child: Icon(_obscureText ? Icons.visibility_off : Icons.visibility,size: 20),
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Image.asset('assets/lock.png',height: 10,color: notifier.textcolore),
                    ),
                    border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15)),borderSide: BorderSide(color: Colors.red)),
                    enabledBorder:  OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(15)),borderSide: BorderSide(color: Colors.grey.withOpacity(0.4))),
                    labelText: "Enter Your Password".tr,labelStyle:  const TextStyle(color: Colors.grey,fontSize: 14),
                    focusedBorder:  OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(15)),borderSide: BorderSide(color: theamcolore)),
                  ),
                ),
                SizedBox(height: Get.height * 0.045,),
                const Spacer(),
                Container(
                  height: 50,
                  child: StatefulBuilder(builder: (context, setState) {
                  return  CommonButtonsmallround(containcolore: theamcolore, onPressed1: (){

                      if(signupmobilecontroller.text.isEmpty){
                        Fluttertoast.showToast(msg: "All fields are required.".tr);
                      }
                      else {

                        mobilCheckController.MobileCheckApi(context: context,ccode: ccode,mobile: signupmobilecontroller.text,).then((value) async {

                          print("////:-- $value");
                          SharedPreferences preferences = await SharedPreferences.getInstance();
                          preferences.setBool("guestlogin",false);

                          if(value['Result'] == "true") {
                            print("done condition");

                            startTimer();
                            if (smstypeApiController.smaApiModel!.smsType == "Msg91") {
                              print("******* Msg91 ******* ${ccode}");

                              masgapiController.msgApi(mobilenumber: ccode + signupmobilecontroller.text, context: context).then((value) {

                                Get.bottomSheet(
                                    StatefulBuilder(builder: (context, setState) {
                                      return Container(
                                        height: 260,
                                        decoration: BoxDecoration(
                                            color: notifier.containercolore,
                                            borderRadius: const BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15)),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15, right: 15),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [

                                              const SizedBox(height: 20,),
                                              Text('Awesome'.tr,
                                                style: TextStyle(
                                                    color: notifier.textcolore,
                                                    fontSize: 20),),
                                              const SizedBox(height: 5,),
                                              Text(
                                                'We have sent the OTP to $ccode ${signupmobilecontroller.text}', style: TextStyle(
                                                  color: notifier.textcolore,
                                                  fontFamily: "SofiaProBold"),),
                                              const SizedBox(height: 20,),
                                              Center(
                                                child: OTPTextField(
                                                  otpFieldStyle: OtpFieldStyle(
                                                    enabledBorderColor: Colors.grey.withOpacity(0.4),
                                                  ),
                                                  controller: otpController,
                                                  length: 6,
                                                  width: MediaQuery.of(context).size.width,
                                                  textFieldAlignment: MainAxisAlignment
                                                      .spaceAround,
                                                  fieldWidth: 45,
                                                  fieldStyle: FieldStyle.box,
                                                  outlineBorderRadius: 5,
                                                  contentPadding: const EdgeInsets
                                                      .all(15),
                                                  style: TextStyle(fontSize: 17,
                                                      color: notifier
                                                          .textcolore,
                                                      fontFamily: "SofiaProBold"),
                                                  onChanged: (pin) {
                                                    otpvaraible = int.parse(smscode);
                                                  },
                                                  onCompleted: (pin) {
                                                    setState(() {
                                                      smscode = pin;
                                                    });
                                                  },
                                                ),
                                              ),
                                              const SizedBox(height: 10,),



                                              CounterBottomSheet(ccode: ccode,mobilenumber: signupmobilecontroller.text,),
                                              const SizedBox(height: 10,),
                                              CommonButton(
                                                  txt1: 'VERIFY OTP'.tr,
                                                  containcolore: theamcolore,
                                                  context: context,
                                                  onPressed1: () async {
                                                    print("////////:-- $otpvaraible");



                                                    if (masgapiController.msgApiModel!.otp == otpvaraible) {
                                                      signupController.signupApi(name: namecontroller.text, email: emailcontroller.text, ccode: ccode, mobilenumber: signupmobilecontroller.text, password: passwordcontroller.text);
                                                    } else {
                                                      Fluttertoast.showToast(
                                                        msg: "Incorrect OTP. Please try again."
                                                            .tr,);
                                                    }
                                                  }),
                                              const SizedBox(height: 10,),

                                            ],
                                          ),
                                        ),
                                      );
                                    },)
                                );
                              },);

                            }
                            else if (smstypeApiController.smaApiModel!.smsType == "Twilio") {
                              print("******* Twilio *******");

                              twilioapiController.twilioApi(mobilenumber: ccode + signupmobilecontroller.text, context: context).then((value) {
                                Get.bottomSheet(
                                    Container(
                                      height: 260,
                                      color: notifier.containercolore,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 15),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [

                                            const SizedBox(height: 20,),
                                            Text('Awesome'.tr,
                                              style: TextStyle(
                                                  color: notifier.textcolore,
                                                  fontSize: 20),),
                                            const SizedBox(height: 5,),
                                            Text(
                                              'We have sent the OTP to $ccode ${signupmobilecontroller
                                                  .text}', style: TextStyle(
                                                color: notifier.textcolore,
                                                fontFamily: "SofiaProBold"),),
                                            const SizedBox(height: 20,),
                                            Center(
                                              child: OTPTextField(
                                                otpFieldStyle: OtpFieldStyle(
                                                  enabledBorderColor: Colors
                                                      .grey.withOpacity(0.4),
                                                ),
                                                controller: otpController,
                                                length: 6,
                                                width: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width,
                                                textFieldAlignment: MainAxisAlignment
                                                    .spaceAround,
                                                fieldWidth: 45,
                                                fieldStyle: FieldStyle.box,
                                                outlineBorderRadius: 5,
                                                contentPadding: const EdgeInsets
                                                    .all(15),
                                                style: TextStyle(fontSize: 17,
                                                    color: notifier
                                                        .textcolore,
                                                    fontFamily: "SofiaProBold"),
                                                onChanged: (pin) {
                                                  otpvaraible =
                                                      int.parse(smscode);
                                                },
                                                onCompleted: (pin) {
                                                  setState(() {
                                                    smscode = pin;
                                                  });
                                                },
                                              ),
                                            ),
                                            CounterBottomSheet(ccode: ccode,mobilenumber: signupmobilecontroller.text,),
                                            const SizedBox(height: 10,),
                                            CommonButton(
                                                txt1: 'VERIFY OTP'.tr,
                                                containcolore: theamcolore,
                                                context: context,
                                                onPressed1: () async {


                                                  if (twilioapiController.twilioApiModel!.otp == otpvaraible) {
                                                    signupController.signupApi(name: namecontroller.text, email: emailcontroller.text, ccode: ccode, mobilenumber: signupmobilecontroller.text, password: passwordcontroller.text);
                                                  } else {
                                                    Fluttertoast.showToast(
                                                      msg: "Incorrect OTP. Please try again."
                                                          .tr,);
                                                  }



                                                }),
                                            const SizedBox(height: 10,),

                                          ],
                                        ),
                                      ),
                                    )
                                );
                              },);

                            }
                            else {
                              Fluttertoast.showToast(msg: "No Service".tr);
                            }




                          }else{
                            print("not done condition");
                            Fluttertoast.showToast(msg: "${value['ResponseMsg']}".tr);
                          }

                          print(value);
                        });
                      }



                      // Extra Code



                    },txt1: 'Sign Up',context: context);
                  },),
                ),
                const SizedBox(height: 20,),
                Center(
                  child: InkWell(
                    onTap: () {
                      Get.to(const Login_Scrren());
                    },
                    child: RichText(text:  TextSpan(
                        children: [
                          TextSpan(text: 'Already have an account? '.tr,style: TextStyle(color: notifier.textcolore,fontSize: 15,fontFamily: 'SofiaRegular')),
                          TextSpan(text: 'Sign in'.tr,style: TextStyle(color: theamcolore,fontSize: 15,fontWeight: FontWeight.bold,fontFamily: 'SofiaRegular')),
                        ]
                    )),
                  ),
                ),
                SizedBox(height: 10,),
              ],
            ),
          ),
          isLoading ?  Center(child: CircularProgressIndicator(color: theamcolore)):const SizedBox(),
        ],
      ),
    );
  }
}


FirebaseAuth auth = FirebaseAuth.instance;



class CounterBottomSheet extends StatefulWidget {
  final String ccode;
  final String mobilenumber;
  const CounterBottomSheet({super.key, required this.ccode, required this.mobilenumber});

  @override
  State<CounterBottomSheet> createState() => _CounterBottomSheetState();
}

class _CounterBottomSheetState extends State<CounterBottomSheet> {

  MasgapiController masgapiController = Get.put(MasgapiController());
  SmstypeApiController smstypeApiController = Get.put(SmstypeApiController());
  TwilioapiController twilioapiController = Get.put(TwilioapiController());

  int secondsRemaining = 30;
  bool enableResend = false;
  Timer? timer;

  @override
  void initState() {
    startTimer();
    smstypeApiController.smsApi(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        if (secondsRemaining > 0) {
          secondsRemaining--;
        } else {
          enableResend = true;
          t.cancel(); // Cancel timer when done
        }
      });
    });
  }

  void _resendCode() {

    if (smstypeApiController.smaApiModel!.smsType == "Msg91") {
      print("******* Msg91 ******* ${widget.ccode}");

      masgapiController.msgApi(mobilenumber: widget.ccode + widget.mobilenumber, context: context);

    }
    else if (smstypeApiController.smaApiModel!.smsType == "Twilio") {
      print("******* Twilio *******");

      twilioapiController.twilioApi(mobilenumber: widget.ccode + widget.mobilenumber, context: context);

    }
    else{}



    setState(() {
      secondsRemaining = 30;
      enableResend = false;
      startTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Spacer(),
          enableResend
              ? InkWell(
            onTap: () {
              _resendCode();
              print("fffffffff");
            },
            child: Text(
              "Resend code?".tr,
              style: TextStyle(
                  fontFamily: "SofiaRegular", color: notifier.textcolore, fontSize: 16),
            ),
          ) : Text(
            " $secondsRemaining Seconds".tr,
            style: TextStyle(
              color: theamcolore,
              fontFamily: "SofiaRegular",
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}

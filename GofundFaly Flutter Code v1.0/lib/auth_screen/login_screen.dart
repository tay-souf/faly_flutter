// ignore_for_file: camel_case_types, non_constant_identifier_names, use_build_context_synchronously, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gofunds/auth_screen/onboarding_screen.dart';
import 'package:gofunds/auth_screen/sign_up_screen.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common/common_button.dart';
import '../common/light_dark_mode.dart';
import '../controller/login_controller.dart';

class Login_Scrren extends StatefulWidget {
  const Login_Scrren({super.key});

  @override
  State<Login_Scrren> createState() => _Login_ScrrenState();
}

class _Login_ScrrenState extends State<Login_Scrren> {
  bool isLoading = false;
  bool _obscureText = true;
  OtpFieldController otpController = OtpFieldController();

  // Getx Controller

  LoginController loginController = Get.put(LoginController());
  MobilCheckController mobilCheckController = Get.put(MobilCheckController());
  ForgotController forgotController = Get.put(ForgotController());
  SocialController socialController = Get.put(SocialController());
  SmstypeApiController smstypeApiController = Get.put(SmstypeApiController());
  MasgapiController masgapiController = Get.put(MasgapiController());
  TwilioapiController twilioapiController = Get.put(TwilioapiController());
  HomeApiController homeApiController = Get.put(HomeApiController());

  TextEditingController mobilcontroller = TextEditingController();
  TextEditingController passwodcontroller = TextEditingController();

  TextEditingController newpasswordController = TextEditingController();
  TextEditingController conformpasswordController = TextEditingController();


  @override
  void initState() {
    smstypeApiController.smsApi(context);
    // TODO: implement initState
    super.initState();
  }

  String ccode ="";
  int? otpvarable;

  bool Mobilcheck = false;
  String smscode = '';

  ColorNotifier notifier = ColorNotifier();

  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return PopScope(
     canPop: false,
      onPopInvoked: (didPop) {
         Get.offAll(BoardingPage());
      },
      child: Scaffold(
        backgroundColor: notifier.background,
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [

            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Expanded(flex: 8,child: Container(child:  Center(child: Image(image: AssetImage("assets/loginimage.png"),fit: BoxFit.cover,)))),

                Expanded(
                  flex: 7,
                  child: Container(
                      alignment: Alignment.bottomCenter,
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: notifier.containercolore,
                        borderRadius: const BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
                      ),
                      child: SingleChildScrollView(
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15,right: 15,bottom: 15,top: 15),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const   SizedBox(height: 10,),
                                    Text("Sign in to GoFund".tr,style: TextStyle(color: notifier.textcolore,fontSize: 22,fontWeight: FontWeight.bold,),),
                                    const SizedBox(height: 10,),
                                    Text("Securely access personalized features and manage your account with ease.".tr,style: const TextStyle(color: Colors.grey,fontSize: 15),),
                                    const SizedBox(height: 25,),
                                    IntlPhoneField(
                                      controller: mobilcontroller,
                                      decoration:  InputDecoration(
                                        counterText: "",
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey.withOpacity(0.4)),
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        // contentPadding: const EdgeInsets.only(top: 8),
                                        labelText: 'Phone Number'.tr,
                                        labelStyle: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(color: Colors.grey,),
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:  BorderSide(color: theamcolore),
                                          borderRadius: BorderRadius.circular(15),
                                        ),

                                      ),
                                      style: TextStyle(color: notifier.textcolore),
                                      flagsButtonPadding: EdgeInsets.zero,
                                      showCountryFlag: false,
                                      showDropdownIcon: false,
                                      initialCountryCode: 'IN',
                                      dropdownTextStyle:   TextStyle(color: notifier.textcolore,fontSize: 15),
                                      onCountryChanged: (value) {
                                      },
                                      onChanged: (number) {
                                        setState(() {
                                          ccode = number.countryCode;
                                        });
                                      },
                                    ),
                                    SizedBox(height: Get.height * 0.015,),
                                    TextField(
                                      controller: passwodcontroller,
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
                                    SizedBox(height: Get.height * 0.010,),
                                    Row(
                                      children: [
                                        const Spacer(),
                                        InkWell(
                                            onTap: () {

                                              Get.bottomSheet(
                                                  Container(
                                                    height: 220,
                                                    decoration:  BoxDecoration(
                                                        color: notifier.containercolore,
                                                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(left: 15,right: 15),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          const SizedBox(height: 20,),
                                                          Text("Forget Password ?".tr,style: TextStyle(color: notifier.textcolore,fontSize: 16,fontWeight: FontWeight.bold)),
                                                          const SizedBox(height: 10,),
                                                          IntlPhoneField(
                                                            controller: mobilcontroller,
                                                            decoration:  InputDecoration(
                                                              counterText: "",
                                                              enabledBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(color: Colors.grey.withOpacity(0.4)),
                                                                borderRadius: BorderRadius.circular(15),
                                                              ),
                                                              labelText: 'Phone Number'.tr,
                                                              labelStyle: const TextStyle(
                                                                color: Colors.grey,
                                                                fontSize: 14,
                                                              ),
                                                              border: OutlineInputBorder(
                                                                borderSide: const BorderSide(color: Colors.grey,),
                                                                borderRadius: BorderRadius.circular(15),
                                                              ),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderSide:  BorderSide(color: theamcolore),
                                                                borderRadius: BorderRadius.circular(15),
                                                              ),

                                                            ),
                                                            style: TextStyle(color: notifier.textcolore),
                                                            flagsButtonPadding: EdgeInsets.zero,
                                                            showCountryFlag: false,
                                                            showDropdownIcon: false,
                                                            initialCountryCode: 'IN',
                                                            dropdownTextStyle:   TextStyle(color: notifier.textcolore,fontSize: 15),
                                                            onCountryChanged: (value) {

                                                            },
                                                            onChanged: (number) {
                                                              setState(() {
                                                                ccode = number.countryCode;
                                                              });
                                                            },
                                                          ),
                                                          const SizedBox(height: 20,),
                                                          CommonButton(txt1: 'Continue'.tr,containcolore: theamcolore,context: context,onPressed1: () async{
                                                            if(mobilcontroller.text.isEmpty){
                                                              Fluttertoast.showToast(msg: 'Enter Mobile Number...!!!'.tr,);
                                                            }else{
                                                              mobilCheckController.MobileCheckApi(context: context, mobile: mobilcontroller.text,ccode: ccode).then((value) async {
                                                                if(value['Result'] == "false"){

                                                                  if(smstypeApiController.smaApiModel!.smsType == "Msg91"){
                                                                    print("----------:-- ${ccode}");

                                                                    masgapiController.msgApi(mobilenumber: ccode + mobilcontroller.text, context: context).then((value) {
                                                                      Get.bottomSheet(
                                                                          Container(
                                                                            height: 230,
                                                                            decoration: BoxDecoration(
                                                                                color: notifier.background,
                                                                              borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15))
                                                                            ),
                                                                            child: Padding(
                                                                              padding: const EdgeInsets.only(left: 15,right: 15),
                                                                              child: Column(
                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  const SizedBox(height: 20,),
                                                                                  Text('Awesome'.tr,style: TextStyle(color: notifier.textcolore,fontFamily: 'SofiaProBold',fontSize: 20),),
                                                                                  const SizedBox(height: 5,),
                                                                                  Text('We have sent the OTP to ${ccode}${mobilcontroller.text}'.tr,style:  TextStyle(color: notifier.textcolore,fontFamily: "SofiaProBold"),),
                                                                                  const SizedBox(height: 20,),
                                                                                  Center(
                                                                                    child: OTPTextField(
                                                                                      otpFieldStyle: OtpFieldStyle(
                                                                                        enabledBorderColor: Colors.grey.withOpacity(0.4),
                                                                                      ),
                                                                                      controller: otpController,
                                                                                      length: 6,
                                                                                      width: MediaQuery.of(context).size.width,
                                                                                      textFieldAlignment: MainAxisAlignment.spaceAround,
                                                                                      fieldWidth: 45,
                                                                                      fieldStyle: FieldStyle.box,
                                                                                      outlineBorderRadius: 5,
                                                                                      contentPadding: const EdgeInsets.all(15),
                                                                                      style:  TextStyle(fontSize: 17,color: notifier.textcolore,fontFamily: "SofiaProBold"),
                                                                                      onChanged: (pin) {
                                                                                        otpvarable = int.parse(smscode);
                                                                                      },
                                                                                      onCompleted: (pin) {
                                                                                        setState(() {
                                                                                          smscode = pin;
                                                                                        });
                                                                                      },
                                                                                    ),
                                                                                  ),
                                                                                  const SizedBox(height: 20,),
                                                                                  CommonButton(txt1: 'VERIFY OTP'.tr,containcolore: theamcolore,context: context,onPressed1: () async{



                                                                                    if(masgapiController.msgApiModel!.otp == otpvarable){
                                                                                      Get.bottomSheet(Container(
                                                                                        height: 250,
                                                                                        decoration: const BoxDecoration(
                                                                                          color: Colors.white,
                                                                                          borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15)),
                                                                                        ),
                                                                                        child: Padding(
                                                                                          padding: const EdgeInsets.only(left: 10,right: 10),
                                                                                          child: Column(
                                                                                            mainAxisSize: MainAxisSize.min,
                                                                                            children: <Widget>[
                                                                                              const SizedBox(height: 15,),
                                                                                              Text('Create A New Password'.tr,style: const TextStyle(fontSize: 18,fontFamily: "SofiaProBold",color: Colors.black)),
                                                                                              const SizedBox(height: 15,),
                                                                                              CommonTextfiled2(txt: 'New Password'.tr,controller: newpasswordController,context: context),
                                                                                              const SizedBox(height: 15,),
                                                                                              CommonTextfiled2(txt: 'Confirm Password'.tr,controller: conformpasswordController,context: context),
                                                                                              const SizedBox(height: 15,),
                                                                                              CommonButton(containcolore: theamcolore,txt1: 'Confirm'.tr,context: context,onPressed1: () {

                                                                                                if(newpasswordController.text.compareTo(conformpasswordController.text) == 0){
                                                                                                  forgotController.forgotApi(mobile: mobilcontroller.text, password: conformpasswordController.text, ccode: ccode).then((value) {
                                                                                                    print("++++++$value");
                                                                                                    if(value["ResponseCode"] == "200"){
                                                                                                      Get.back();
                                                                                                      Fluttertoast.showToast(
                                                                                                        msg: value["ResponseMsg"],
                                                                                                      );
                                                                                                    }else{

                                                                                                      Fluttertoast.showToast(
                                                                                                        msg: value["ResponseMsg"],
                                                                                                      );

                                                                                                    }
                                                                                                  });
                                                                                                }else{

                                                                                                  Fluttertoast.showToast(
                                                                                                    msg: "Please enter current password".tr,
                                                                                                  );
                                                                                                }
                                                                                              }),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ));
                                                                                    }else {
                                                                                      Fluttertoast.showToast(msg: "opt not valide".tr,);
                                                                                    }


                                                                                  }),
                                                                                  const SizedBox(height: 20,),

                                                                                ],
                                                                              ),
                                                                            ),
                                                                          )
                                                                      );
                                                                    },);

                                                                  }
                                                                  else if(smstypeApiController.smaApiModel!.smsType == "Twilio"){

                                                                    twilioapiController.twilioApi(mobilenumber: ccode + mobilcontroller.text, context: context).then((value) {
                                                                      Get.bottomSheet(
                                                                          Container(
                                                                            height: 230,
                                                                            decoration: BoxDecoration(
                                                                                color: notifier.background,
                                                                                borderRadius: const BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15))
                                                                            ),
                                                                            child: Padding(
                                                                              padding: const EdgeInsets.only(left: 15,right: 15),
                                                                              child: Column(
                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  const SizedBox(height: 20,),
                                                                                  Text('Awesome'.tr,style: TextStyle(color: notifier.textcolore,fontFamily: 'SofiaProBold',fontSize: 20),),
                                                                                  const SizedBox(height: 5,),
                                                                                  Text('We have sent the OTP to ${ccode}${mobilcontroller.text}'.tr,style:  TextStyle(color: notifier.textcolore,fontFamily: "SofiaProBold"),),
                                                                                  const SizedBox(height: 20,),
                                                                                  Center(
                                                                                    child: OTPTextField(
                                                                                      otpFieldStyle: OtpFieldStyle(
                                                                                        enabledBorderColor: Colors.grey.withOpacity(0.4),
                                                                                      ),
                                                                                      controller: otpController,
                                                                                      length: 6,
                                                                                      width: MediaQuery.of(context).size.width,
                                                                                      textFieldAlignment: MainAxisAlignment.spaceAround,
                                                                                      fieldWidth: 45,
                                                                                      fieldStyle: FieldStyle.box,
                                                                                      outlineBorderRadius: 5,
                                                                                      contentPadding: const EdgeInsets.all(15),
                                                                                      style:  TextStyle(fontSize: 17,color: notifier.textcolore,fontFamily: "SofiaProBold"),
                                                                                      onChanged: (pin) {
                                                                                        otpvarable = int.parse(smscode);
                                                                                      },
                                                                                      onCompleted: (pin) {
                                                                                        setState(() {
                                                                                          smscode = pin;
                                                                                        });
                                                                                      },
                                                                                    ),
                                                                                  ),
                                                                                  const SizedBox(height: 20,),
                                                                                  CommonButton(txt1: 'VERIFY OTP'.tr,containcolore: theamcolore,context: context,onPressed1: () async{
                                                                                    if(twilioapiController.twilioApiModel!.otp == otpvarable){
                                                                                      Get.bottomSheet(Container(
                                                                                        height: 250,
                                                                                        decoration: const BoxDecoration(
                                                                                          color: Colors.white,
                                                                                          borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15)),
                                                                                        ),
                                                                                        child: Padding(
                                                                                          padding: const EdgeInsets.only(left: 10,right: 10),
                                                                                          child: Column(
                                                                                            mainAxisSize: MainAxisSize.min,
                                                                                            children: <Widget>[
                                                                                              const SizedBox(height: 15,),
                                                                                              Text('Create A New Password'.tr,style: TextStyle(fontSize: 18,fontFamily: "SofiaProBold",color: Colors.black)),
                                                                                              const SizedBox(height: 15,),
                                                                                              CommonTextfiled2(txt: 'New Password'.tr,controller: newpasswordController,context: context),
                                                                                              const SizedBox(height: 15,),
                                                                                              CommonTextfiled2(txt: 'Confirm Password'.tr,controller: conformpasswordController,context: context),
                                                                                              const SizedBox(height: 15,),
                                                                                              CommonButton(containcolore: theamcolore,txt1: 'Confirm'.tr,context: context,onPressed1: () {
                                                                                                if(newpasswordController.text.compareTo(conformpasswordController.text) == 0){
                                                                                                  forgotController.forgotApi(mobile: mobilcontroller.text, password: conformpasswordController.text, ccode: ccode).then((value) {
                                                                                                    print("++++++$value");
                                                                                                    if(value["ResponseCode"] == "200"){
                                                                                                      Get.back();
                                                                                                      Fluttertoast.showToast(
                                                                                                        msg: value["ResponseMsg"],
                                                                                                      );
                                                                                                    }else{

                                                                                                      Fluttertoast.showToast(
                                                                                                        msg: value["ResponseMsg"],
                                                                                                      );

                                                                                                    }
                                                                                                  });
                                                                                                }else{

                                                                                                  Fluttertoast.showToast(
                                                                                                    msg: "Please enter current password".tr,
                                                                                                  );
                                                                                                }
                                                                                              }),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ));
                                                                                    }
                                                                                    else {
                                                                                      Fluttertoast.showToast(msg: "opt not valide".tr,);
                                                                                    }


                                                                                  }),
                                                                                  const SizedBox(height: 20,),

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
                                                                  Fluttertoast.showToast(msg: "${value['ResponseMsg']}".tr,);
                                                                }
                                                              });
                                                            }
                                                          }),
                                                          const SizedBox(height: 20,),

                                                        ],
                                                      ),
                                                    ),
                                                  )
                                              );

                                            },
                                            child:  Center(child: Text('Forgot Password ?'.tr,style: TextStyle(color: notifier.textcolore,fontFamily: "SofiaProBold",fontSize: 14)),)),
                                      ],
                                    ),

                                    SizedBox(height: Get.height * 0.025,),
                                    Container(
                                      height: 50,
                                      child: CommonButtonsmallround(containcolore: theamcolore, onPressed1: () async {

                                        SharedPreferences preferences = await SharedPreferences.getInstance();
                                        preferences.setBool("guestlogin",false);
                                        homeApiController.isLoading = true;

                                        if(mobilcontroller.text.isNotEmpty){
                                          mobilCheckController.MobileCheckApi(context: context, mobile: mobilcontroller.text,ccode: ccode).then((value) {
                                            if(mobilcontroller.text.isNotEmpty && passwodcontroller.text.isNotEmpty) {
                                              loginController.loginApi(context, mobilcontroller.text, passwodcontroller.text, ccode);
                                            }
                                            else {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content:  Text('Enter a valid phone number.'.tr),
                                                  behavior: SnackBarBehavior.floating,
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),),
                                              );
                                            }
                                            setState(() {});
                                          });
                                        }
                                        else{
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content:   Text('Enter your phone number.'.tr),behavior: SnackBarBehavior.floating, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),),
                                          );
                                        }

                                      },txt1: 'Sign In',context: context),
                                    ),

                                    SizedBox(height: Get.height * 0.030,),
                                    InkWell(
                                      onTap: () async {
                                        SharedPreferences preferences = await SharedPreferences.getInstance();
                                        preferences.setBool("guestlogin",false);
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Sign_Up(social: false,socialemail: ''),));
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('Already have an account? '.tr,style: TextStyle(color: Colors.grey,fontSize: 16,fontFamily: 'SofiaRegular')),
                                          Text('Sign Up'.tr,style: TextStyle(color: theamcolore,fontFamily: "SofiaProBold",fontSize: 16)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Center(child: CircularProgressIndicator(color: theamcolore))
                            isLoading ? Center(child: CircularProgressIndicator(color: theamcolore)) : const SizedBox(),
                          ],
                        ),
                      )
                  ),
                ),
              ],
            ),
            Positioned(
              left: 10,
              top: 50,
              child: Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Image(image: AssetImage("assets/arrow-left.png"),color: Colors.black,),
                  )),
            ),

          ],
        ),
      ),
    );
  }
}

// ignore_for_file: avoid_print, non_constant_identifier_names

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gofunds/bootom_navigation_screen/bottom_navigation_bar.dart';
import 'package:gofunds/common/config.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api_model/Social_Login_api_model.dart';
import '../api_model/account_delete_api_model.dart';
import '../api_model/activity_api_model.dart';
import '../api_model/catwise_fund_api_model.dart';
import '../api_model/charityy_api_model.dart';
import '../api_model/donate_now_api_model.dart';
import '../api_model/editprofile_api_model.dart';
import '../api_model/faq_api_model.dart';
import '../api_model/forgot_api_model.dart';
import '../api_model/found_raised_api_model.dart';
import '../api_model/fund_cancel_api_model.dart';
import '../api_model/fund_complete_api_model.dart';
import '../api_model/fund_list_api_model.dart';
import '../api_model/fund_update_api_model.dart';
import '../api_model/fundedit_api_model.dart';
import '../api_model/get_balace_api_model.dart';
import '../api_model/home_api_model.dart';
import '../api_model/login_api_model.dart';
import '../api_model/mobile_check_api_model.dart';
import '../api_model/msg_api_model.dart';
import '../api_model/my_donation_fundlist_api_model.dart';
import '../api_model/notification_api_model.dart';
import '../api_model/pagelist_api_model.dart';
import '../api_model/payment_getway_api_model.dart';
import '../api_model/payout_list_api_model.dart';
import '../api_model/paystack_api_model.dart';
import '../api_model/profileimageedit_api_model.dart';
import '../api_model/search_api_model.dart';
import '../api_model/signup_api_model.dart';
import '../api_model/smstype_api_model.dart';
import '../api_model/twilio_api_model.dart';
import '../api_model/wallet_add_api_model.dart';
import '../api_model/wallet_report_api_model.dart';
import '../api_model/withdraw_api_model.dart';
import '../app_screen/add_fundraiser_photo_screen.dart';
import '../app_screen/create_fundraiser.dart';
import '../app_screen/describe_fundraising.dart';
import '../app_screen/fundraiser_details.dart';
import '../app_screen/passenger_details.dart';
import '../app_screen/top_up_screen.dart';
import '../auth_screen/login_screen.dart';
import '../auth_screen/onboarding_screen.dart';
import '../auth_screen/push_notification.dart';
import '../auth_screen/sign_up_screen.dart';
import '../common/common_button.dart';
import '../common/home_controoler.dart';
import '../secound_bootom_navigation_screen/secound_bottom_navigation_screen.dart';

void loginSharedPreferencesSet(bool value) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setBool("UserLogin", value);
}

bool? boolValue;


HomeController homeController = Get.put(HomeController());

Future<bool> loginSharedPreferencesGet() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  bool value = preferences.getBool("UserLogin") ?? true;
  return value;
}

// Login Api

class LoginController extends GetxController implements GetxService {
  LoginModel? loginModel;

  loginApi(context, String mobile, password, ccode) async {
    Map body = {"mobile": mobile, "password": password, "ccode": ccode};

    Map<String, String> userHeader = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };

    var response = await http.post(Uri.parse(Config.api_path + Config.login),
        body: jsonEncode(body), headers: userHeader);

    print('+ + + + + + + + + + +$body');
    print('- - - - - - - - - - -${response.body}');

    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (data["Result"] == "true") {
        loginModel = loginModelFromJson(response.body);
        if (loginModel!.result == "true") {


          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setString("userLogin", jsonEncode(data["UserLogin"]));



          loginSharedPreferencesSet(false);
          Get.offAll(const Bottom_Navigation());

          OneSignal.shared.sendTag("user_id", data["UserLogin"]["id"]);
          initPlatformState(context: context);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("${data["ResponseMsg"]}"),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(loginModel!.responseMsg),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${data["ResponseMsg"]}"),
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Something went Wrong....!!!"),
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
  }
}

// Sign Up Api

class SignupController extends GetxController implements GetxService {
  SignupModel? signupModel;

  Future signupApi(
      {
        required String name,
      required String email,
      required String mobilenumber,
      required String ccode,
      required String password,
        context
      }) async {
    Map body = {
      "name": name,
      "email": email,
      "mobile": mobilenumber,
      "ccode": ccode,
      "password": password
    };

    Map<String, String> userHeader = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };

    var response = await http.post(Uri.parse(Config.api_path + Config.signup),
        body: jsonEncode(body), headers: userHeader);

    print('+ + + + + + + + + + + $body');
    print('- - - - - - - - - - - ${response.body}');

    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (data["Result"] == "true") {

        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString("userLogin", jsonEncode(data["UserLogin"]));
        initPlatformState(context: context);
        OneSignal.shared.sendTag("user_id", data["UserLogin"]["id"]);
        loginSharedPreferencesSet(false);
        signupModel = signupModelFromJson(response.body);
        update();
        homeController.setselectpage(0);
        Get.offAll(const Bottom_Navigation());
        // return response.body;
        Fluttertoast.showToast(
          msg: "${data["ResponseMsg"]}",
        );
      } else {
        Fluttertoast.showToast(
          msg: "${data["ResponseMsg"]}",
        );

      }
    } else {
      Fluttertoast.showToast(
        msg: "Somthing went wrong!.....",
      );

    }
  }
}

// Mobile Check Api

class MobilCheckController extends GetxController implements GetxService {
  MobilcheckModel? mobilecheckModel;

  Future MobileCheckApi({context,required String mobile, required String ccode}) async {
    Map body = {"mobile": mobile, "ccode": ccode};

    Map<String, String> userHeader = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };

    var response = await http.post(
        Uri.parse(Config.api_path + Config.mobilecheck),
        body: jsonEncode(body),
        headers: userHeader);

    print('0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 - - - - - - - $body');
    print('1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 + + + + + + + ${response.body}');

    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      mobilecheckModel = mobilcheckModelFromJson(response.body);
      return data;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Something went Wrong....!!!"),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
  }
}

// Forgot Api

class ForgotController extends GetxController implements GetxService {
  ForgotModel? forgotModel;

  forgotApi(
      {required String mobile,
      required String password,
      required String ccode}) async {
    Map body = {"mobile": mobile, "password": password, "ccode": ccode};

    Map<String, String> userHeader = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };

    var response = await http.post(Uri.parse(Config.api_path + Config.forgot),
        body: jsonEncode(body), headers: userHeader);

    print('+ + + + + + + + + + +$body');
    print('- - - - - - - - - - -${response.body}');

    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (data["Result"] == "true") {
        forgotModel = forgotModelFromJson(response.body);
        if (forgotModel!.result == "true") {
          Get.offAll(BoardingPage());
          update();
          Fluttertoast.showToast(
            msg: "${data["ResponseMsg"]}",
          );
        } else {
          Fluttertoast.showToast(
            msg: forgotModel!.responseMsg,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: "${data["ResponseMsg"]}",
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: "Somthing went wrong!.....",
      );
    }
  }
}

// Social Login Api

class SocialController extends GetxController implements GetxService {
  SocialLoginModel? SocialloginModel;

  socialloginApi({required String email}) async {
    Map body = {"email": email};

    Map<String, String> userHeader = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };

    var response = await http.post(
        Uri.parse(Config.api_path + Config.sociallogin),
        body: jsonEncode(body),
        headers: userHeader);

    print('+ + + + + + + + + + + $body');
    print('- - - - - - - - - - - ${response.body}');

    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (data["Result"] == "true") {
        SocialloginModel = socialLoginModelFromJson(response.body);
        if (SocialloginModel!.result == "true") {
          loginSharedPreferencesSet(false);
          update();
          Fluttertoast.showToast(
            msg: "${data["ResponseMsg"]}",
          );
          Get.offAll(const Bottom_Navigation());
        } else {
          Get.to(Sign_Up(
            social: true,
            socialemail: email,
          ));
          Fluttertoast.showToast(
            msg: SocialloginModel!.responseMsg,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: "${data["ResponseMsg"]}",
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: "Somthing went wrong!.....",
      );
    }
  }
}

// Home Api

class HomeApiController extends GetxController implements GetxService {
  HomeModel? homeapimodel;
  bool isLoading = true;


 Future homeApi({required String uid,required String latitude,required String logitude}) async {
    Map body = {
      "uid": uid,
      "lats":latitude,
      "longs":logitude
    };

    Map<String, String> userHeader = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };

    var response = await http.post(Uri.parse(Config.api_path + Config.home),
        body: jsonEncode(body), headers: userHeader);

    print('- - - - - - - - - - - ${response.body}');

    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (data["Result"] == "true") {
        homeapimodel = homeModelFromJson(response.body);
        if (homeapimodel!.result == "true") {

          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setString("currenci", jsonEncode(data["currency"]));
          preferences.setString("plateformfee", jsonEncode(data["plaform_free"]));

          isLoading = false;
          update();
        } else {
          Fluttertoast.showToast(
            msg: homeapimodel!.responseMsg,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: "${data["ResponseMsg"]}",
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: "Somthing went wrong!.....",
      );
    }
  }
}

// FundRaise Api

class FundRaiseApiController extends GetxController implements GetxService {

  FoundRaisedModel? foundRaisedModel;
  bool orederloader = false;
  bool isloadoing = true;


  funraisedapi({required String cat_id, required String title, required String fund_for, required String fund_amt, required String fund_story, required String exp_date, required String patient_title, required String patient_diagnosis, required String fund_plan, required String fundsize, required String petientsize, required String certicatesize, required String uid, required String status, required String charity_id, required String full_address, required String lats, required String longs, context}) async {


    if(orederloader){
      return;
    }else{
      orederloader = true;
    }


    var request = http.MultipartRequest('POST', Uri.parse(Config.api_path + Config.fundraised));
    request.fields.addAll({
      'cat_id': cat_id,
      'title': title,
      'fund_for': fund_for,
      'fund_amt': fund_amt,
      'fund_story': fund_story,
      'exp_date': exp_date,
      'patient_title': patient_title,
      'patient_diagnosis': patient_diagnosis,
      'fund_plan': fund_plan,
      'fundsize': fundsize,
      'petientsize': petientsize,
      'certicatesize': certicatesize,
      'uid': uid,
      'status': status,
      'charity_id': charity_id,
      'full_address': full_address,
      'lats': lats,
      'longs': longs,
    });


    for(int a=0; a<image.length; a++){
      request.files.add(await http.MultipartFile.fromPath('certpic$a', image[a]));
      print(" + + + + certpic image + + + + :---${image[a]}");
    }

    for(int b=0; b<passengerimage.length; b++){
      request.files.add(await http.MultipartFile.fromPath('petpic$b', passengerimage[b]));
      print(" + + + + petpic image + + + + :---${passengerimage[b]}");
    }

    for(int c=0; c<finalimage.length; c++){
      request.files.add(await http.MultipartFile.fromPath('fundpic$c', finalimage[c]));
      print(" + + + + fundpic image + + + + :---${finalimage[c]}");
    }

    http.StreamedResponse response = await request.send();
    var responsnessaj = jsonDecode(await response.stream.bytesToString());
    if (response.statusCode == 200) {
      isloadoing = false;
      orederloader = false;
      print(" + + + + fundraise api body + + + + ${request.fields}");

      Fluttertoast.showToast(msg: responsnessaj["ResponseMsg"],);
       showDialog<String>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => AlertDialog(
          backgroundColor: notifier.background,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/lottie/pendingapproval-donation.json',height: 200),
              // const SizedBox(height: 10,),
              Text('Submit Successful!'.tr,style: TextStyle(fontSize: 18,fontFamily: "SofiaProBold",color: theamcolore),),
              const SizedBox(height: 10,),
              RichText(text: TextSpan(
                  children: [
                    TextSpan(text: 'We are currently reviewing a fundraising proposal for your donations. We will tell you the result soon.'.tr,style: TextStyle(color: notifier.textcolore,fontSize: 14,fontFamily: 'SofiaRegular'))
                  ]
              )),
              const SizedBox(height: 20,),
              CommonButton(containcolore: theamcolore, onPressed1: () {
                homeController.setselectpage(2);
                Get.offAll(const Bottom_Navigation());
                emapty = "";
                emapty1 = "";
                titlecontroller.clear();
                select = -1;
                fundamountcontroller.clear();
                pincode = "";
                storycontroller.clear();
                patentnamecontroller.clear();
                patientdiagnosiscontroller.clear();
                fundplancontroller.clear();
                finalimage = [];
                passengerimage = [];
                image = [];
              },context: context,txt1: 'Ok')
            ],
          ),
        ),
      );
    }
    else{
      Fluttertoast.showToast(
        msg: responsnessaj["ResponseMsg"],
      );
    }
  }

}

// FundList Api

class FundListController extends GetxController implements GetxService {

  Fundlistapimodel? fundlistapimodel;
  Fundlistapimodel? fundlistapimodelcomplete;
  Fundlistapimodel? fundlistapimodelcancelled;

  bool isLoading = true;


  Future fundlistApi({required String uid, required String status}) async {
    Map body = {
      "uid": uid,
      "status": status,
    };

    Map<String, String> userHeader = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };

    var response = await http.post(Uri.parse(Config.api_path + Config.fundlist),
        body: jsonEncode(body), headers: userHeader);

    print('+ + + + + + + + + + + $body');
    print('- - - - - - - - - - - ${response.body}');

    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (data["Result"] == "true") {

        if(status == "Pending"){
          print("+++++ Pending +++++");
          fundlistapimodel = fundlistapimodelFromJson(response.body);
        }else if(status == "Completed"){
          print("+++++ Completed +++++");
          fundlistapimodelcomplete = fundlistapimodelFromJson(response.body);
        }else{
          print("+++++ Cancelled +++++");
          fundlistapimodelcancelled = fundlistapimodelFromJson(response.body);
        }

        update();

        if (fundlistapimodel!.result == "true") {
          isLoading = false;
          update();
        } else {
          Fluttertoast.showToast(
            msg: fundlistapimodel!.responseMsg,
          );
        }


      } else {
        Fluttertoast.showToast(msg: "${data["ResponseMsg"]}",);
      }
    }
    else {
      Fluttertoast.showToast(
        msg: "Somthing went wrong!.....",
      );
    }

  }


}

// FundEdit Api

class FundEditApiController extends GetxController implements GetxService {

  FundEditmodel? fundEditmodel;

  Future fundeditapi({
    required String cat_id,
    required String title,
    required String fund_for,
    required String fund_amt,
    required String fund_story,
    required String exp_date,
    required String patient_title,
    required String patient_diagnosis,
    required String fund_plan,
    required String fundsize,
    required String petientsize,
    required String certicatesize,
    required String uid,
    required String status,
    required String record_id,
    required String full_address,
    required String lats,
    required String longs,
    required List petpic0,
    required List certpic0,
    required List fundpic0,
    required String imlist ,
    required String imlists ,
    required String imlistss ,
    context
  }) async {
    var request = http.MultipartRequest('POST', Uri.parse(Config.api_path + Config.fundedit));
    request.fields.addAll({
      'cat_id': cat_id,
      'title': title,
      'fund_for': fund_for,
      'fund_amt': fund_amt,
      'fund_story': fund_story,
      'exp_date': exp_date,
      'patient_title': patient_title,
      'patient_diagnosis': patient_diagnosis,
      'fund_plan': fund_plan,
      'fundsize': fundsize,
      'petientsize': petientsize,
      'certicatesize': certicatesize,
      'uid': uid,
      'status': status,
      'record_id': record_id,
      'imlist' :imlist,
      'imlists':imlists,
      'imlistss' :imlistss,
      'lats' :lats,
      'full_address' :full_address,
      'longs' :longs,
    });


    print("   11    11     11    11   ${request.fields}");
    log("++++++++++++++ ${request.files}");

    for(int a=0; a<certpic0.length; a++){
      request.files.add(await http.MultipartFile.fromPath('certpic$a', certpic0[a]));
      print(" + + + + certpic image + + + + :---${certpic0[a]}");
    }

    for(int b=0; b<petpic0.length; b++){
      request.files.add(await http.MultipartFile.fromPath('petpic$b', petpic0[b]));
      print(" + + + + petpic image + + + + :---${petpic0[b]}");
    }

    for(int c=0; c<fundpic0.length; c++){
      request.files.add(await http.MultipartFile.fromPath('fundpic$c', fundpic0[c]));
      print(" + + + + fundpic image + + + + :---${fundpic0[c]}");
    }



    http.StreamedResponse response = await request.send();
    var responsnessaj = jsonDecode(await response.stream.bytesToString());



    if (response.statusCode == 200) {
      log(" + + + + fundraise api body + + + + ${request.fields}");
      Fluttertoast.showToast(
        msg: responsnessaj["ResponseMsg"],
      );

    }
    else{
      Fluttertoast.showToast(
        msg: responsnessaj["ResponseMsg"],
      );
    }

  }
}

// Edit Profile Api

class EditProfileController extends GetxController implements GetxService {
  EditProfileApi? editProfileApi;

  Future editeprofile(
      {required String uid,
        required String name,
        required String email,
        required String mobile,
        required String ccode,
        required String password,
      }) async {
    Map body = {
      "uid": uid,
      "name": name,
      "email": email,
      "mobile": mobile,
      "ccode": ccode,
      "password": password,
    };
    Map<String, String> userHeader = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };

    var response = await http.post(
        Uri.parse(Config.api_path + Config.editProfile),
        body: jsonEncode(body),
        headers: userHeader);

    print(body);
    print(response.body);

    var data = jsonDecode(response.body);
    if(response.statusCode == 200){
      if(data["Result"] == "true"){
        editProfileApi = editProfileApiFromJson(response.body);
        Fluttertoast.showToast(msg: editProfileApi!.responseMsg.toString());
        update();
        return jsonDecode(response.body);

      }
      else{
        Fluttertoast.showToast(msg: "${data["message"]}");
      }
    }
    else{
      Fluttertoast.showToast(msg: "Something went Wrong....!!!");
    }


  }
}

// Profile Image

class ProfileImageController extends GetxController implements GetxService {
  ProfileimageeditApi? profileimageeditApi;

  Future profileimageedit(
      {required String uid,
        required String image,
      }) async {
    Map body = {
      "uid": uid,
      "img": image,
    };
    Map<String, String> userHeader = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };

    var response = await http.post(
        Uri.parse(Config.api_path + Config.Profileedit),
        body: jsonEncode(body),
        headers: userHeader);

    print(body);
    print(response.body);

    var data = jsonDecode(response.body);
    if(response.statusCode == 200){
      if(data["Result"] == "true"){
        profileimageeditApi = profileimageeditApiFromJson(response.body);
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString("userLogin", jsonEncode(data["UserLogin"]));
        print(response.body);
        Fluttertoast.showToast(msg: profileimageeditApi!.responseMsg.toString());
        update();
        return jsonDecode(response.body);
      }
      else{
        Fluttertoast.showToast(msg: "${data["message"]}");
      }
    }
    else{
      Fluttertoast.showToast(msg: "Something went Wrong....!!!");
    }


  }
}

// CatWiseFund Api

class CatWiseFundController extends GetxController implements GetxService {
  CategryWiseFund? categryWiseFund;
  bool isLoading = true;

  Future catwise(
      {required String cat_id,
        required String uid,
      }) async {
    Map body = {
      "cat_id": cat_id,
      "uid": uid,
    };
    Map<String, String> userHeader = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };

    var response = await http.post(
        Uri.parse(Config.api_path + Config.catwisefund),
        body: jsonEncode(body),
        headers: userHeader);

    print(body);
    print(response.body);

    var data = jsonDecode(response.body);
    if(response.statusCode == 200){
      if(data["Result"] == "true"){
        print(response.body);
        categryWiseFund = categryWiseFundFromJson(response.body);
         isLoading = false;
        update();
        return jsonDecode(response.body);
      }
      else{
        Fluttertoast.showToast(msg: "${data["message"]}");
      }
    }
    else{
      Fluttertoast.showToast(msg: "Something went Wrong....!!!");
    }


  }
}

// Payment Getway // Get Api

class PaymentGetApiController extends GetxController implements GetxService {

  Paymentgetwayapi? paymentgetwayapi;
  bool isLoading = true;
  paymentlistApi(context) async{

    Map<String,String> userHeader = {"Content-type": "application/json", "Accept": "application/json"};
    var response = await http.get(Uri.parse(Config.api_path + Config.payment),headers: userHeader);

    print(response.body);

    var data = jsonDecode(response.body);
    if(response.statusCode == 200){
      if(data["Result"] == "true"){
        paymentgetwayapi = paymentgetwayapiFromJson(response.body);
        isLoading = false;
        update();
      }
      else{
        Get.back();
        Fluttertoast.showToast(msg: "${data["Result"]}");
      }
    }
    else{
      Get.back();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went Wrong....!!!")));
    }
  }
}

// Donate Api

class DonatenowController extends GetxController implements GetxService {
  DonateNowapi? donateNowapi;
  bool isLoading = true;

  Future donateapi(
      {
        required String fund_id,
        required String uid,
        required String amt,
        required String tip,
        required String payment_method_id,
        required String transaction,
        required String wall_amt,
        required String is_anonymous ,
        required String platform_fees ,
        required context
      }) async {
    Map body = {
      "fund_id": fund_id,
      "uid": uid,
      "amt": amt,
      "tip": tip,
      "payment_method_id": payment_method_id,
      "transaction_id": transaction,
      "wall_amt": wall_amt,
      "is_anonymous": is_anonymous,
      "platform_fees": platform_fees,
    };
    Map<String, String> userHeader = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };

    var response = await http.post(Uri.parse(Config.api_path + Config.donateapi), body: jsonEncode(body), headers: userHeader);

    print(" + + + + + press button + + + + + : -- - - - - - $body");
    print(" + + + + + + + + + + : -- - - - - - ${response.body}");

    var data = jsonDecode(response.body);
    if(response.statusCode == 200){
      if(data["Result"] == "true"){
        print(response.body);
        donateNowapi = donateNowapiFromJson(response.body);

        showDialog<String>(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) => AlertDialog(
            backgroundColor: notifier.background,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
            ),
            title: WillPopScope(
              onWillPop: () async {
                homeController.setselectpage(0);
                Get.offAll(const Bottom_Navigation());
                return Future(() => false);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/lottie/donate-succfully.json',height: 200),
                  Text('Donation Successfully Received'.tr,style: TextStyle(fontSize: 19,fontFamily: "SofiaProBold",color: theamcolore),textAlign: TextAlign.center,),
                  SizedBox(height: 10,),
                  Text('Thank you for your generous donation! Your support makes a huge impact!'.tr,style: TextStyle(fontSize: 14,color: theamcolore),textAlign: TextAlign.center,),
                  const SizedBox(height: 20,),
                  CommonButton(containcolore: theamcolore, onPressed1: () {
                    homeController.setselectpage(0);
                    Get.offAll(const Bottom_Navigation());
                  },context: context,txt1: 'Ok')
                ],
              ),
            ),
          ),
        );


        Fluttertoast.showToast(msg: donateNowapi!.responseMsg.toString());
        isLoading = false;
        update();
        return jsonDecode(response.body);
      }
      else{
        Fluttertoast.showToast(msg: "${data["message"]}");
      }
    }
    else{
      Fluttertoast.showToast(msg: "Something went Wrong....!!!");
    }


  }
}

// Fundupdate Api

class FundupdateApiController extends GetxController implements GetxService {

  FundUpdate? fundUpdate;

  Future funupdateapi({
    required String fund_id,
    required String description,
    required String uid,
    required String size,
    context
  }) async {
    var request = http.MultipartRequest('POST', Uri.parse(Config.api_path + Config.fundupdate));
    request.fields.addAll({
      'fund_id': fund_id,
      'description': description,
      'uid': uid,
      'size': size,
    });


    if(tab == 0){
      for(int a=0; a<fundupdateimage.length; a++){
        request.files.add(await http.MultipartFile.fromPath('fundupdate$a', fundupdateimage[a]));
        print(" + + + + certpic image + + + + :---${fundupdateimage[a]}");
      }
    }



    http.StreamedResponse response = await request.send();

    var responsnessaj = jsonDecode(await response.stream.bytesToString());
    if (response.statusCode == 200) {
      print(" + + + + fundraise api body + + + + ${request.fields}");

      Fluttertoast.showToast(
        msg: responsnessaj["ResponseMsg"],
      );
    }
    else{
      Fluttertoast.showToast(
        msg: responsnessaj["ResponseMsg"],
      );
    }
  }
}

// Activity Api

class ActivityApiController extends GetxController implements GetxService {
  ActivityModel? activityModel;

  Future Activityyyapi({required String uid,}) async {
    Map body = {
      "uid": uid,
    };
    Map<String, String> userHeader = {"Content-type": "application/json", "Accept": "application/json"};

    var response = await http.post(
        Uri.parse(Config.api_path + Config.activityapi),
        body: jsonEncode(body),
        headers: userHeader);

    print(body);
    print(response.body);

    var data = jsonDecode(response.body);
    if(response.statusCode == 200){
      activityModel = activityModelFromJson(response.body);
      if(data["Result"] == "true"){
        update();
        return jsonDecode(response.body);
      }
      else{
      }
    }
    else{
      Fluttertoast.showToast(msg: "Something went Wrong....!!!");
    }


  }
}

// My Donation FundList Api

class MyDonationFundlistApiController extends GetxController implements GetxService {
  DonationFundlistModel? donationFundlistModel;
  bool isLoading = true;

  Future MyDonationnapi({required String uid,}) async {
    Map body = {
      "uid": uid,
    };
    Map<String, String> userHeader = {"Content-type": "application/json", "Accept": "application/json"};

    var response = await http.post(
        Uri.parse(Config.api_path + Config.mydonatonapi),
        body: jsonEncode(body),
        headers: userHeader);

    print(body);
    print(response.body);

    var data = jsonDecode(response.body);
    if(response.statusCode == 200){
      donationFundlistModel = donationFundlistModelFromJson(response.body);
      if(data["Result"] == "true"){

        isLoading = false;
        update();
        return jsonDecode(response.body);
      }
      else{
      }
    }
    else{
      Fluttertoast.showToast(msg: "Something went Wrong....!!!");
    }


  }
}

// Request Withdraw Api

class RequestwithdreawApiController extends GetxController implements GetxService {
  RequestWithdraw? requestWithdraw;
  bool isLoading = true;

  Future Withdrawapi({
    required String uid,
    required String amt,
    required String r_type,
    required String acc_number,
    required String bank_name,
    required String acc_name,
    required String ifsc_code,
    required String upi_id,
    required String paypal_id
  }) async {
    Map body = {
      "uid": uid,
      "amt": amt,
      "r_type": r_type,
      "acc_number": acc_number,
      "bank_name": bank_name,
      "acc_name": acc_name,
      "ifsc_code": ifsc_code,
      "upi_id": upi_id,
      "paypal_id": paypal_id,
    };
    Map<String, String> userHeader = {"Content-type": "application/json", "Accept": "application/json"};

    var response = await http.post(
        Uri.parse(Config.api_path + Config.withdrawapi),
        body: jsonEncode(body),
        headers: userHeader);

    print(body);
    print(response.body);

    var data = jsonDecode(response.body);
    if(response.statusCode == 200){
      requestWithdraw = requestWithdrawFromJson(response.body);
      if(data["Result"] == "true"){

        Fluttertoast.showToast(msg: requestWithdraw!.responseMsg.toString());
        isLoading = false;
        update();
        return jsonDecode(response.body);
      }
      else{
        Fluttertoast.showToast(msg: "${data["message"]}");
      }
    }
    else{
      Fluttertoast.showToast(msg: "Something went Wrong....!!!");
    }


  }
}

// Fund Complete Api

class FundCompleteApiController extends GetxController implements GetxService {
  FundCompleteApiModel? fundCompleteApiModel;
  bool isLoading = true;

  Future fundcomplteapi({
    required String fund_id,
    required String uid,
  }) async {
    Map body = {
      "fund_id": fund_id,
      "uid": uid,
    };
    Map<String, String> userHeader = {"Content-type": "application/json", "Accept": "application/json"};

    var response = await http.post(
        Uri.parse(Config.api_path + Config.fundcompleteeeapi),
        body: jsonEncode(body),
        headers: userHeader);

    print(body);
    print(response.body);

    var data = jsonDecode(response.body);
    if(response.statusCode == 200){
      fundCompleteApiModel = fundCompleteApiModelFromJson(response.body);
      if(data["Result"] == "true"){

        homeController.setselectpage(0);
        Get.offAll(const Bottom_Navigation());
        Fluttertoast.showToast(msg: fundCompleteApiModel!.responseMsg.toString());
        isLoading = false;
        update();
        return jsonDecode(response.body);
      }
      else{
        Fluttertoast.showToast(msg: "${data["message"]}");
      }
    }
    else{
      Fluttertoast.showToast(msg: "Something went Wrong....!!!");
    }


  }
}

// GetBalance Api

class GetmonyApiController extends GetxController implements GetxService {
  GetBalance? getBalance;
  bool isLoading = true;

  Future getbalnceapi({
    required String uid,
  }) async {
    Map body = {
      "uid": uid,
    };
    Map<String, String> userHeader = {"Content-type": "application/json", "Accept": "application/json"};

    var response = await http.post(
        Uri.parse(Config.api_path + Config.getbalaceapi),
        body: jsonEncode(body),
        headers: userHeader);

    print(body);
    print(response.body);

    var data = jsonDecode(response.body);
    if(response.statusCode == 200){
      getBalance = getBalanceFromJson(response.body);
      if(data["Result"] == "true"){

        isLoading = false;
        update();
        return jsonDecode(response.body);
      }
      else{
      }
    }
    else{
    }


  }
}

// Payout List Api

class PayoutlistApiController extends GetxController implements GetxService {
  PayOutListApi? payOutListApi;
  bool isLoading = true;

  Future payoutlisttapi({
    required String uid,
  }) async {
    Map body = {
      "uid": uid,
    };
    Map<String, String> userHeader = {"Content-type": "application/json", "Accept": "application/json"};

    var response = await http.post(
        Uri.parse(Config.api_path + Config.payyoutlisttapi),
        body: jsonEncode(body),
        headers: userHeader);

    print(body);
    print(response.body);

    var data = jsonDecode(response.body);
    if(response.statusCode == 200){
      payOutListApi = payOutListApiFromJson(response.body);
      if(data["Result"] == "true"){

        isLoading = false;
        update();
        return jsonDecode(response.body);
      }
      else{
      }
    }
    else{
    }


  }
}

// Fund Cancel Api

class FundCacelApiController extends GetxController implements GetxService {
  FundCancelApi? fundCancelApi;
  bool isLoading = true;

  Future fundcancelapi({
    required String fund_id,
    required String uid,
    required String reject_comment,
  }) async {
    Map body = {
      "fund_id" : fund_id,
      "uid": uid,
      "reject_comment": reject_comment,
    };
    Map<String, String> userHeader = {"Content-type": "application/json", "Accept": "application/json"};

    var response = await http.post(
        Uri.parse(Config.api_path + Config.fundcancelapi),
        body: jsonEncode(body),
        headers: userHeader);

    print(body);
    print(response.body);

    var data = jsonDecode(response.body);
    if(response.statusCode == 200){
      fundCancelApi = fundCancelApiFromJson(response.body);
      if(data["Result"] == "true"){

        homeController.setselectpage(0);
        Get.offAll(const Bottom_Navigation());
        Fluttertoast.showToast(msg: fundCancelApi!.responseMsg.toString());
        isLoading = false;
        update();
        return jsonDecode(response.body);
      }
      else{
      }
    }
    else{
    }


  }
}

// CharityList Getway // Get Api

class charitylisttApiController extends GetxController implements GetxService {

  CharityyApi? charityyApi;
  bool isLoading = true;

  chartyselectApi(context) async{

    Map<String,String> userHeader = {"Content-type": "application/json", "Accept": "application/json"};
    var response = await http.get(Uri.parse(Config.api_path + Config.charityapi),headers: userHeader);

    print(response.body);

    var data = jsonDecode(response.body);
    if(response.statusCode == 200){
      if(data["Result"] == "true"){
        charityyApi = charityyApiFromJson(response.body);
        isLoading = false;
        update();
      }
      else{
        Get.back();
        Fluttertoast.showToast(msg: "${data["Result"]}");
      }
    }
    else{
      Get.back();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went Wrong....!!!")));
    }
  }
}

// Faq Api

class FaqApiController extends GetxController implements GetxService {
  FaqApiiimodel? faqApiiimodel;
  bool isLoading = true;

  Future faqlistapi({
    required String uid,
  }) async {
    Map body = {
      "uid": uid,
    };

    Map<String, String> userHeader = {"Content-type": "application/json", "Accept": "application/json"};

    var response = await http.post(Uri.parse(Config.api_path + Config.faqapi), body: jsonEncode(body), headers: userHeader);

    print(body);
    print(response.body);

    var data = jsonDecode(response.body);
    if(response.statusCode == 200){
      faqApiiimodel = faqApiiimodelFromJson(response.body);
      if(data["Result"] == "true"){

        isLoading = false;
        update();
        return jsonDecode(response.body);
      }
      else{
      }
    }
    else{
    }


  }
}

// PageList Getway // Get Api

class pagelistApiController extends GetxController implements GetxService {

  PageListApiiimodel? pageListApiiimodel;
  bool isLoading = true;

  pagelistttApi(context) async{

    Map<String,String> userHeader = {"Content-type": "application/json", "Accept": "application/json"};
    var response = await http.get(Uri.parse(Config.api_path + Config.pagelistapi),headers: userHeader);

    print(response.body);

    var data = jsonDecode(response.body);
    if(response.statusCode == 200){
      if(data["Result"] == "true"){
        pageListApiiimodel = pageListApiiimodelFromJson(response.body);
        isLoading = false;
        update();
      }
      else{
        Get.back();
        Fluttertoast.showToast(msg: "${data["Result"]}");
      }
    }
    else{
      Get.back();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went Wrong....!!!")));
    }
  }
}

// Account Api

class AccountDeleteApiController extends GetxController implements GetxService {
  AccountDeleteApiiimodel? accountDeleteApiiimodel;
  bool isLoading = true;

  Future accountdeleteapi({
    required String uid,
  }) async {
    Map body = {
      "uid": uid,
    };
    Map<String, String> userHeader = {"Content-type": "application/json", "Accept": "application/json"};

    var response = await http.post(
        Uri.parse(Config.api_path + Config.accountdeleteapi),
        body: jsonEncode(body),
        headers: userHeader);

    print(body);
    print(response.body);

    var data = jsonDecode(response.body);
    if(response.statusCode == 200){
      accountDeleteApiiimodel = accountDeleteApiiimodelFromJson(response.body);
      if(data["Result"] == "true"){

        homeController.setselectpage(0);
        Get.offAll(Login_Scrren());
        Fluttertoast.showToast(msg: accountDeleteApiiimodel!.responseMsg.toString());
        isLoading = false;
        update();
        return jsonDecode(response.body);
      }
      else{
        Fluttertoast.showToast(msg: "${data["message"]}");
      }
    }
    else{
      Fluttertoast.showToast(msg: "Something went Wrong....!!!");
    }


  }
}

// Wallet Up Api

class WalletApiController extends GetxController implements GetxService {
  WalletAddApiModel? walletAddApiModel;
  bool isLoading = true;

  Future walletaddapi({
    required String wallet,
    required String uid,
    context
  }) async {
    Map body = {
      "wallet": wallet,
      "uid": uid,
    };
    Map<String, String> userHeader = {"Content-type": "application/json", "Accept": "application/json"};

    var response = await http.post(
        Uri.parse(Config.api_path + Config.walletupapi),
        body: jsonEncode(body),
        headers: userHeader);

    print(body);
    print("///////////:---  ${response.body}");

    var data = jsonDecode(response.body);
    if(response.statusCode == 200){
      walletAddApiModel = walletAddApiModelFromJson(response.body);
      if(data["Result"] == "true"){

        Fluttertoast.showToast(msg: walletAddApiModel!.responseMsg.toString());
        showModalBottomSheet(
          isDismissible: false,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))
          ),
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: 330,
              decoration:  BoxDecoration(
                  color: notifier.background,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20,),
                  const CircleAvatar(radius: 35,backgroundColor: Color(0xff7D2AFF),child: Center(child: Icon(Icons.check,color: Colors.white,)),),
                  const SizedBox(height: 20,),
                  Text('Top up $currencybol${walletController.text}.00',style:  TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: notifier.textcolore),),
                  const SizedBox(height: 5,),
                  Text('Successfuly'.tr,style:  TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: notifier.textcolore),),
                  const SizedBox(height: 28,),
                  Text('$currencybol${walletController.text} has been added to your wallet',style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.grey),),
                  const SizedBox(height: 28,),
                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: const ButtonStyle(fixedSize: MaterialStatePropertyAll(Size(0, 50)),backgroundColor: MaterialStatePropertyAll(Colors.white),side: MaterialStatePropertyAll(BorderSide(color: Colors.black)),shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))))),
                            onPressed: () {
                              Get.back();
                              Get.back();
                            },
                            child:  Text('Done For Now'.tr,style:  TextStyle(color: Colors.black)),
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Expanded(
                          child: ElevatedButton(
                            style: const ButtonStyle(fixedSize: MaterialStatePropertyAll(Size(0, 50)),backgroundColor: MaterialStatePropertyAll(Colors.black),side: MaterialStatePropertyAll(BorderSide(color: Colors.black)),shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))))),
                            onPressed: () {
                              Get.back();
                              Get.back();
                            },
                            child:  Text('Another Top Up'.tr,style: const TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
        isLoading = false;
        update();
        return jsonDecode(response.body);
      }
      else{
        Fluttertoast.showToast(msg: "${data["message"]}");
      }
    }
    else{
      Fluttertoast.showToast(msg: "Something went Wrong....!!!");
    }


  }
}

// Wallet Report Api

class WalletReportApiController extends GetxController implements GetxService {
  WalletReportApiModel? walletReportApiModel;
  bool isLoading = true;


  Future walletreportApi({required String uid}) async {
    Map body = {
      "uid": uid,
    };

    Map<String, String> userHeader = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };

    var response = await http.post(Uri.parse(Config.api_path + Config.walletreportapi),
        body: jsonEncode(body), headers: userHeader);

    print('+ + + + + + + + + + + $body');
    print('- - - - - - - - - - - ${response.body}');

    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (data["Result"] == "true") {
        walletReportApiModel = walletReportApiModelFromJson(response.body);
        if (walletReportApiModel!.result == "true") {
          isLoading = false;
          update();
        } else {
          Fluttertoast.showToast(
            msg: walletReportApiModel!.responseMsg,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: "${data["ResponseMsg"]}",
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: "Somthing went wrong!.....",
      );
    }
  }
}

// searchfunde Api

class SearchFundeController extends GetxController implements GetxService {
  SearchApiModel? searchApiModel;
  bool isLoading = true;


  Future searchApi({required String uid,required String keyword}) async {
    Map body = {
      "uid": uid,
      "keyword": keyword,
    };

    Map<String, String> userHeader = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };

    var response = await http.post(Uri.parse(Config.api_path + Config.searchapi),
        body: jsonEncode(body), headers: userHeader);

    print('+ + + + + + + + + + + $body');
    print('- - - - - - - - - - - ${response.body}');

    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (data["Result"] == "true") {
        searchApiModel = searchApiModelFromJson(response.body);
        if (searchApiModel!.result == "true") {
          isLoading = false;
          update();
        } else {

        }
      } else {

      }
    } else {

    }
  }
}

// sms-type api // Get Api

class SmstypeApiController extends GetxController implements GetxService {

  SmaApiModel? smaApiModel;
  bool isLoading = true;
  smsApi(context) async{

    Map<String,String> userHeader = {"Content-type": "application/json", "Accept": "application/json"};
    var response = await http.get(Uri.parse(Config.api_path + Config.smstypeapi),headers: userHeader);

    print(response.body);

    var data = jsonDecode(response.body);
    if(response.statusCode == 200){
      if(data["Result"] == "true"){
        smaApiModel = smaApiModelFromJson(response.body);
        isLoading = false;
        update();
      }
      else{
        Get.back();
        Fluttertoast.showToast(msg: "${data["Result"]}");
      }
    }
    else{
      Get.back();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went Wrong....!!!")));
    }
  }
}

// Msg 91 Api

class MasgapiController extends GetxController implements GetxService {
  MsgApiModel? msgApiModel;

  Future msgApi(
      {
        required String mobilenumber,
        context
      }) async {
    Map body = {
      "mobile": mobilenumber,
    };

    Map<String, String> userHeader = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };

    var response = await http.post(Uri.parse(Config.api_path + Config.msgapi),
        body: jsonEncode(body), headers: userHeader);

    print('+ + + + + + + + + + + $body');
    print('- - - - - - - - - - - ${response.body}');

    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (data["Result"] == "true") {


        msgApiModel = msgApiModelFromJson(response.body);
        update();

        Fluttertoast.showToast(
          msg: "${data["ResponseMsg"]}",
        );
      } else {
        Fluttertoast.showToast(
          msg: "${data["ResponseMsg"]}",
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: "Somthing went wrong!.....",
      );
    }
  }
}

// Twilio Api

class TwilioapiController extends GetxController implements GetxService {
  TwilioApiModel? twilioApiModel;

  Future twilioApi(
      {
        required String mobilenumber,
        context
      }) async {
    Map body = {
      "mobile": mobilenumber,
    };

    Map<String, String> userHeader = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };

    var response = await http.post(Uri.parse(Config.api_path + Config.twilioapi),
        body: jsonEncode(body), headers: userHeader);

    print('+ + + + + + + + + + + $body');
    print('- - - - - - - - - - - ${response.body}');

    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (data["Result"] == "true") {


        twilioApiModel = twilioApiModelFromJson(response.body);
        update();

        Fluttertoast.showToast(
          msg: "${data["ResponseMsg"]}",
        );
      } else {
        Fluttertoast.showToast(
          msg: "${data["ResponseMsg"]}",
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: "Somthing went wrong!.....",
      );
    }
  }
}

// Notification Api

class NotificationApiController extends GetxController implements GetxService {
  NotificatonListAPiModel? notificatonListAPiModel;
  bool isLoading = true;

  Future notificationapi({
    required String uid,
  }) async {
    Map body = {
      "uid": uid,
    };

    Map<String, String> userHeader = {"Content-type": "application/json", "Accept": "application/json"};

    var response = await http.post(Uri.parse(Config.api_path + Config.notificationapi), body: jsonEncode(body), headers: userHeader);

    print(body);
    print(response.body);

    var data = jsonDecode(response.body);
    if(response.statusCode == 200) {
      notificatonListAPiModel = notificatonListAPiModelFromJson(response.body);
      if(data["Result"] == "true"){
        isLoading = false;
        update();
      }
      else{

      }
    }
    else{
    }


  }
}

// Paystack Payment Api

class PayStackPayMentApiController extends GetxController implements GetxService {
  late PayStackApiApiModel payStackApiApiModel;
  String refrenceee = "";

  Future paystackApi({context,required String email,required String amount}) async{
    Map body = {
      "email" : email,
      "amount" : amount,
    };

    Map<String, String> userHeader = {"Content-type": "application/json", "Accept": "application/json"};

    var response = await http.post(Uri.parse(Config.baseurl + Config.paystckapi), body: jsonEncode(body), headers: userHeader);
     print("+++++:---  ${response.body}");
    try{
      if(response.statusCode == 200){
        payStackApiApiModel = payStackApiApiModelFromJson(response.body);
        update();
        refrenceee = payStackApiApiModel.data.reference;
        print("+++++:-  (${refrenceee})");
        return payStackApiApiModel.data.authorizationUrl;
      }
    }catch(e){
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}

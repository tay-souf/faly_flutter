// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gofunds/app_screen/page_list_description.dart';
import 'package:gofunds/app_screen/withdraw_screen.dart';
import 'package:gofunds/common/common_button.dart';
import 'package:gofunds/common/config.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../auth_screen/onboarding_screen.dart';
import '../common/home_controoler.dart';
import '../common/light_dark_mode.dart';
import '../controller/language_controller.dart';
import '../controller/login_controller.dart';
import 'faq_screen.dart';
import 'my_donation_screen.dart';


bool rtl = false;

class Account_Scrrn extends StatefulWidget {
  const Account_Scrrn({super.key});

  @override
  State<Account_Scrrn> createState() => _Account_ScrrnState();
}

class _Account_ScrrnState extends State<Account_Scrrn> {

  List totletext = [
    'Edit Profile'.tr,
    'My donation'.tr,
    'Withdraw'.tr,
    'Faq'.tr,
    'Dark Mode'.tr,
    'Language'.tr,
    'Invite Friends'.tr,
  ];

  List secoundtext = [
    'Help & Support'.tr,
    'Rate Our App'.tr,
    'Tear Of Service'.tr,
  ];

  List image = [
    'assets/p1.svg',
    'assets/p2.svg',
    'assets/p3.svg',
    'assets/p4.svg',
    'assets/p5.svg',
    'assets/p6.svg',
    'assets/p7.svg',
  ];

  @override
  void initState() {
    super.initState();
    getPackage();
    datagetfunction();
  }

  pagelistApiController pagelistcontroller = Get.put(pagelistApiController());
  AccountDeleteApiController accountDeleteApiController = Get.put(AccountDeleteApiController());

  var userData;

  datagetfunction() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var uid = preferences.getString("userLogin");
    userData = jsonDecode(uid!);

    print("1 1 1 1 1 1 1 1 $userData");
    isloading = false;
    pagelistcontroller.pagelistttApi(context);
    fun();
    setState(() {
    });
  }

  EditProfileController editProfileController = Get.put(EditProfileController());
  ProfileImageController profileImageController = Get.put(ProfileImageController());

  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController mobilecontroller = TextEditingController();

  HomeController homeController = Get.put(HomeController());

  bool isloading = true;
  String ccode ="";

  String networkImage = "";
  XFile? selectImageprofile;
  ImagePicker picker = ImagePicker();
  String? base64String;

  ColorNotifier notifier = ColorNotifier();
  int value = 0;
  List languageimage = [
    'assets/L-English.png',
    'assets/L-Spanish.png',
    'assets/L-Arabic.png',
    'assets/L-Hindi-Gujarati.png',
    'assets/L-Hindi-Gujarati.png',
    'assets/L-Afrikaans.png',
    'assets/L-Bengali.png',
    'assets/L-Indonesion.png',
  ];

  List languagetext = [
    'English',
    'Spanish',
    'Arabic',
    'Hindi',
    'Gujarati',
    'Afrikaans',
    'Bengali',
    'Indonesian',
  ];
  List languagetext1 = [
    'en_English',
    'en_spanse',
    'ur_arabic',
    'en_Hindi',
    'en_Gujarati',
    'en_African',
    'en_Bangali',
    'en_Indonesiya',
  ];

  fun(){
    for(int a= 0 ;a<languagetext1.length;a++){
      print(languagetext1[a]);
      print(Get.locale);
      if(languagetext1[a].toString().compareTo(Get.locale.toString()) == 0){
        setState(() {
          value = a;
        });

      }else{
      }
    }
  }

  language1 language11 = Get.put(language1());

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

  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return Scaffold(
      backgroundColor: notifier.background,
      appBar: AppBar(
        backgroundColor: notifier.background,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text('My Account'.tr,style: TextStyle(color: notifier.textcolore,fontFamily: "SofiaProBold",fontSize: 18)),
      ),
      body: GetBuilder<EditProfileController>(
          builder: (editProfileController) {
            return isloading ? Center(child: CircularProgressIndicator(color: theamcolore,)) : Padding(
              padding: const EdgeInsets.only(left: 15,right: 15,top: 0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: DottedBorder(
                        borderType: BorderType.Circle,
                        radius: const Radius.circular(65),
                        padding: const EdgeInsets.all(5),
                        strokeWidth: 1,
                        strokeCap: StrokeCap.butt,
                        child: InkWell(
                          onTap: () {
                            Get.bottomSheet(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Text("From where do you want to take the photo?".tr, style: const TextStyle(fontSize: 20, color: Colors.black),),
                                          const SizedBox(height: 15),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: OutlinedButton(
                                                  style: OutlinedButton.styleFrom(fixedSize: const Size(100, 50), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
                                                  onPressed: () async {
                                                    final picked=await picker.pickImage(source: ImageSource.gallery);
                                                    if(picked!= null){
                                                      setState(() {
                                                        selectImageprofile = picked;
                                                      });

                                                      List<int> imageByte = File(selectImageprofile!.path).readAsBytesSync();
                                                      base64String =base64Encode(imageByte);
                                                      profileImageController.profileimageedit(uid: userData["id"], image: base64String.toString()).then((value) {
                                                        Get.back();
                                                        datagetfunction();
                                                      });
                                                    } else{
                                                      print("did not pick an image!!".tr);
                                                    }
                                                  },
                                                  child:  Text("Gallery".tr, style: const TextStyle(fontSize: 15, color: Colors.black),),
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Expanded(
                                                child: OutlinedButton(
                                                  style: OutlinedButton.styleFrom(fixedSize: const Size(100, 50), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
                                                  onPressed: () async {
                                                    final picked=await picker.pickImage(source: ImageSource.camera);
                                                    if(picked!= null){
                                                      setState(() {
                                                        selectImageprofile = picked;
                                                      });

                                                      List<int> imageByte =File(selectImageprofile!.path).readAsBytesSync();
                                                      base64String =base64Encode(imageByte);
                                                      profileImageController.profileimageedit(uid: userData["id"], image: base64String.toString()).then((value) {
                                                        Get.back();
                                                        datagetfunction();
                                                      });
                                                    } else{
                                                      print("did not pick an image!!".tr);
                                                    }
                                                  },
                                                  child:  Text("Camera".tr, style: const TextStyle( fontSize: 15, color: Colors.black),),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 15),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              SizedBox(
                                height: 100,
                                width: 100,
                                child:  userData['profile_pic'] != null ? Container(
                                    decoration:  BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(image:  NetworkImage("${Config.baseurl}${userData['profile_pic']}"), fit: BoxFit.cover),
                                    )) : selectImageprofile == null ?   CircleAvatar(
                                  backgroundColor: Colors.grey.withOpacity(0.2),
                                  maxRadius: 50,
                                  child: Center(child: Text(userData['name'][0],style: TextStyle(fontFamily: "SofiaProBold",fontSize: 16,color: theamcolore))),
                                ) : Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      // image: DecorationImage(image:  NetworkImage('${Config.imagebaseurl}${profileImageController.profileimageeditApi!.userLogin.profilePic}'), fit: BoxFit.cover),
                                      image: DecorationImage(image:  FileImage(File(selectImageprofile!.path)), fit: BoxFit.cover),
                                    )),
                              ),

                              Positioned(
                                right: 0,
                                bottom: -20,
                                left: 0,
                                child: Container(
                                  height: 35,
                                  width: 35,
                                  decoration:  BoxDecoration(
                                    color: Colors.black,
                                    border: Border.all(color: Colors.white),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Image.asset("assets/editicon.png",color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25,),
                    Center(child: Text('${userData['name']}'.tr,style: TextStyle(color: notifier.textcolore,fontFamily: "SofiaProBold",fontSize: 18))),
                    const SizedBox(height: 5,),
                    Center(child: Text('${userData['mobile']}'.tr,style: const TextStyle(color: Colors.grey,fontFamily: "SofiaProBold"))),
                    const SizedBox(height: 30,),

                    Text('General'.tr,style: TextStyle(color: notifier.textcolore,fontFamily: "SofiaProBold")),
                    const SizedBox(height: 10,),
                    ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: totletext.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            onTap: () {
                              switch(index){
                                case  0:
                                  namecontroller.text = userData["name"];
                                  emailcontroller.text = userData["email"];
                                  passwordcontroller.text = userData["password"];
                                  mobilecontroller.text = userData["mobile"];
                                  ccode = userData["ccode"];
                                  Get.bottomSheet(
                                      isScrollControlled: true,
                                      Container(
                                        // height: 420,
                                        decoration: BoxDecoration(
                                          color: notifier.containercolore,
                                          borderRadius: const BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15)),
                                        ),
                                        child:  Padding(
                                          padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              const SizedBox(height: 10,),
                                              Text('Profile Edit'.tr,style: TextStyle(color: notifier.textcolore,fontSize: 20,fontFamily: "SofiaProBold"),),
                                              const SizedBox(height: 10,),
                                              CommonTextfiled200(txt: '${userData["name"]}',controller: namecontroller,context: context),
                                              const SizedBox(height: 10,),
                                              CommonTextfiled200(txt: '${userData["email"]}',controller: emailcontroller,context: context),
                                              const SizedBox(height: 10,),
                                              CommonTextfiled11(txt: '${userData["password"]}',controller: passwordcontroller,context: context),
                                              const SizedBox(height: 10,),
                                              IntlPhoneField(
                                                controller: mobilecontroller,
                                                readOnly: true,
                                                style: TextStyle(color: notifier.textcolore),
                                                decoration:  InputDecoration(
                                                  counterText: "",
                                                  enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(color: Colors.grey.withOpacity(0.4)),
                                                      borderRadius: BorderRadius.circular(10)
                                                  ),
                                                  contentPadding: const EdgeInsets.only(top: 8),
                                                  hintText: '${userData["mobile"]}',
                                                  hintStyle: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 14,fontFamily: "SofiaProBold"
                                                  ),
                                                  border: OutlineInputBorder(
                                                      borderSide: const BorderSide(color: Colors.grey,),
                                                      borderRadius: BorderRadius.circular(10)
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderSide: const BorderSide(color: Color(0xff7D2AFF)),
                                                      borderRadius: BorderRadius.circular(10),
                                                  ),
                                                ),
                                                flagsButtonPadding: EdgeInsets.zero,
                                                showCountryFlag: false,
                                                showDropdownIcon: false,
                                                initialCountryCode: 'IN',
                                                dropdownTextStyle:  TextStyle(color: notifier.textcolore,fontSize: 15),
                                                // style: const TextStyle(color: Colors.black,fontSize: 16),
                                                onChanged: (number) {
                                                  setState(() {
                                                    ccode = number.countryCode;
                                                  });
                                                },
                                              ),
                                              const SizedBox(height: 10,),
                                              CommonButton(txt1: 'Confirm'.tr,containcolore: theamcolore,context: context,onPressed1: () {
                                                Get.back();
                                                if(namecontroller.text.isNotEmpty && emailcontroller.text.isNotEmpty && passwordcontroller.text.isNotEmpty){
                                                  editProfileController.editeprofile(uid: userData["id"], name: namecontroller.text, email: emailcontroller.text, mobile: mobilecontroller.text, ccode: ccode, password: passwordcontroller.text).then((value) async {

                                                    print(' + + + + + +  ++ :----$userData');
                                                    print(' - - - - - - - - :--$value');

                                                    SharedPreferences pre = await SharedPreferences.getInstance();
                                                    pre.setString("userLogin", jsonEncode(value["UserLogin"]));
                                                    datagetfunction();
                                                  });
                                                }else {
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(content: Text('Enter Input'.tr),behavior: SnackBarBehavior.floating, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),),
                                                  );
                                                }

                                              }),

                                              const SizedBox(height: 20,),
                                            ],
                                          ),
                                        ),
                                      )
                                  );
                                case  1:
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  const My_Dontaion_Screen(),));
                                case 2:
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const payout_screen(),));
                                case 3:
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Faq_Screeen(),));
                                case 4:
                                  return;
                                case 5:
                                  Get.bottomSheet(
                                      isScrollControlled: true,
                                      Container(
                                        height: 610,
                                        decoration:  BoxDecoration(
                                          color: notifier.background,
                                          borderRadius: const BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15)),
                                        ),
                                        child:  Padding(
                                          padding: const EdgeInsets.only(left: 15,right: 15,top: 10),
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.vertical,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                ListView.builder(
                                                  shrinkWrap: true,
                                                  scrollDirection: Axis.vertical,
                                                  physics: const NeverScrollableScrollPhysics(),
                                                  itemCount: 8,
                                                  itemBuilder: (context, index) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          value = index;
                                                        });


                                                        if(index == 2){
                                                          setState(() {
                                                            rtl = true;
                                                            print("++++++++++if+++++++++++${rtl}");
                                                          });

                                                        }
                                                        else{
                                                         setState(() {
                                                           rtl = false;
                                                           print("+++++++++++else++++++++++${rtl}");
                                                         });
                                                        }


                                                        switch (index) {
                                                          case 0:
                                                            Get.updateLocale(const Locale('en', 'English'));
                                                            Get.back();
                                                            homeController.setselectpage(0);
                                                            break;
                                                          case 1:
                                                            Get.updateLocale(const Locale('en', 'spanse'));
                                                            Get.back();
                                                            homeController.setselectpage(0);
                                                            break;
                                                          case 2:
                                                            Get.updateLocale(const Locale('ur', 'arabic'));
                                                            Get.back();
                                                            homeController.setselectpage(0);
                                                            break;
                                                          case 3:
                                                            Get.updateLocale(const Locale('en', 'Hindi'));
                                                            Get.back();
                                                            homeController.setselectpage(0);
                                                            break;
                                                          case 4:
                                                            Get.updateLocale(const Locale('en', 'Gujarati'));
                                                            Get.back();
                                                            homeController.setselectpage(0);
                                                            break;
                                                          case 5:
                                                            Get.updateLocale(const Locale('en', 'African'));
                                                            Get.back();
                                                            homeController.setselectpage(0);
                                                            break;
                                                          case 6:
                                                            language11.fun(demo: () {
                                                              Get.updateLocale(const Locale('en', 'Bangali'));
                                                              Get.back();
                                                              homeController.setselectpage(0);
                                                            });
                                                            break;
                                                          case 7:
                                                            language11.fun(demo: (){
                                                              Get.updateLocale(const Locale('en', 'Indonesiya'));
                                                              Get.back();
                                                              homeController.setselectpage(0);
                                                            });
                                                            break;
                                                        }
                                                      },
                                                      child: Container(
                                                        height: 60,
                                                        width: Get.width,
                                                        margin: const EdgeInsets.symmetric(vertical: 7),
                                                        decoration: BoxDecoration(
                                                            border: Border.all(color: value == index ? theamcolore : Colors.transparent,),
                                                            color:  notifier.containercolore,
                                                            borderRadius: BorderRadius.circular(10)),
                                                        child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    height: 45,
                                                                    width: 60,
                                                                    margin: const EdgeInsets.symmetric(
                                                                        horizontal: 10),
                                                                    decoration: BoxDecoration(
                                                                      color: Colors.transparent,
                                                                      borderRadius: BorderRadius.circular(100),
                                                                    ),
                                                                    child: Center(
                                                                      child: Container(
                                                                        height: 32,
                                                                        width: 32,
                                                                        decoration: BoxDecoration(image: DecorationImage(image: AssetImage(languageimage[index]),)),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(height: 10),
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment.start,
                                                                    children: [
                                                                      Text(languagetext[index],
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.w600,
                                                                              fontSize: 14,
                                                                              color: notifier.textcolore)),
                                                                    ],
                                                                  ),
                                                                  const Spacer(),
                                                                  CheckboxListTile(index),
                                                                  const SizedBox(width: 15,),
                                                                ],
                                                              ),
                                                            ]),
                                                      ),
                                                    );
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ));
                                  return;
                                case 6:
                                  Share.share(
                                    "Hey! 👋've found this awesome dating app called ${appName} and thought you might be interested too! 😊.Check it out:${Platform.isAndroid
                                        ? 'https://play.google.com/store/apps/details?id=${packageName}'
                                        : Platform.isIOS
                                        ? 'https://apps.apple.com/us/app/${appName}/id${packageName}'
                                        : ""}",
                                  );
                                  return;
                                case 7:
                                  return;
                                case 8:
                                  return;
                                case 9:
                                  return;
                              }
                            },
                            contentPadding: EdgeInsets.zero,
                            leading: Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Container(
                                  height: 40,
                                  width: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.grey.withOpacity(0.4))
                                  ),
                                child: Padding(
                                  padding: const EdgeInsets.all(9),
                                  child: SvgPicture.asset("${image[index]}",color: notifier.textcolore,),
                                )),
                            ),
                            title: Text('${totletext[index]}',style: TextStyle(color: notifier.textcolore)),
                            trailing: index == 4 ?  rtl ?  SizedBox(
                              height: 20,
                              width: 40,
                              child: Transform.scale(
                                scale: 0.7,
                                child: CupertinoSwitch(
                                  value: notifier.isDark,
                                  activeColor: theamcolore,
                                  onChanged: (bool value) {
                                    notifier.isAvailable(value);
                                  },
                                ),
                              ),
                            ) :
                            Transform.translate(
                              offset: const Offset(-5, 0),
                              child: SizedBox(
                                height: 20,
                                width: 30,
                                child: Transform.scale(
                                  scale: 0.7,
                                  child: CupertinoSwitch(
                                    value: notifier.isDark,
                                    activeColor: theamcolore,
                                    onChanged: (bool value) {
                                      notifier.isAvailable(value);
                                    },
                                  ),
                                ),
                              ),
                            )
                                :  Icon(Icons.arrow_forward_ios,size: 20,color: notifier.textcolore),
                          );
                        }),
                    const SizedBox(height: 5,),
                    Text('Support'.tr,style: TextStyle(color: notifier.textcolore,fontFamily: "SofiaProBold"),),
                    const SizedBox(height: 10,),
                    GetBuilder<pagelistApiController>(builder: (pagelistcontroller) {
                      return pagelistcontroller.isLoading ? const SizedBox() : ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          separatorBuilder: (context, index) {
                            return const SizedBox(width: 5);
                          },
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: pagelistcontroller.pageListApiiimodel!.pagelist.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Page_List_description(title: pagelistcontroller.pageListApiiimodel!.pagelist[index].title,description: pagelistcontroller.pageListApiiimodel!.pagelist[index].description),));
                              },
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: Container(
                                      height: 40,
                                      width: 40,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(color: Colors.grey.withOpacity(0.4))
                                      ),
                                      // child: Image(image: AssetImage('assets/pagesicon2.png'),height: 20,width: 20,color: notifier.textcolore,)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(9),
                                        child: SvgPicture.asset("assets/f10.svg",color: notifier.textcolore),
                                      )),
                                ),
                                title: Text('${pagelistcontroller.pageListApiiimodel!.pagelist[index].title}',style:  TextStyle(fontSize: 15,color: notifier.textcolore)),
                                trailing: Icon(Icons.chevron_right,color: notifier.textcolore),
                              ),
                            );
                          });
                    },),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet<void>(
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15))),
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 200,
                              decoration:  BoxDecoration(
                                  color: notifier.containercolore,
                                  borderRadius: const BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15))
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15, right: 15),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    const SizedBox(height: 25,),
                                    Text('Delete Account'.tr,style:  TextStyle(color: theamcolore,fontWeight: FontWeight.bold,fontSize: 20)),
                                    const SizedBox(height: 12.5),
                                    const Divider(color: Colors.grey,),
                                    const SizedBox(height: 12.5,),
                                    Text('Are you sure you want to delete account?'.tr,style: TextStyle(color: notifier.textcolore,fontSize: 16,fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 25,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          style: ButtonStyle(fixedSize: const MaterialStatePropertyAll(Size(130, 40)),elevation: const MaterialStatePropertyAll(0),shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),backgroundColor: const MaterialStatePropertyAll(Colors.white)),
                                          onPressed: () => Navigator.pop(context),
                                          child: Text('Cancel'.tr,style: const TextStyle(color: Colors.black)),
                                        ),
                                        const SizedBox(width: 10,),
                                        ElevatedButton(
                                          style: ButtonStyle(fixedSize: const MaterialStatePropertyAll(Size(130, 40)),elevation: const MaterialStatePropertyAll(0),shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),backgroundColor:  MaterialStatePropertyAll(theamcolore)),
                                          onPressed: () => {
                                            accountDeleteApiController.accountdeleteapi(uid: userData['id'])
                                          },
                                          child:  Text('Yes,Remove'.tr,style: const TextStyle(color: Colors.white)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Container(
                              height: 40,
                              width: 40,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.grey.withOpacity(0.4))
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(9),
                                child: SvgPicture.asset("assets/p8.svg",color: notifier.textcolore),
                              )),
                        ),
                        title: Text('Delete Account'.tr,style:  TextStyle(fontSize: 15,color: notifier.textcolore)),
                        trailing: Icon(Icons.chevron_right,color: notifier.textcolore),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    CommonButtonwithboarder(bordercolore: theamcolore, onPressed1: () {

                      loginSharedPreferencesSet(true);
                      homeController.setselectpage(0);
                      Get.offAll(BoardingPage());

                    },context: context,txt2: 'Log Out'.tr,clore: theamcolore),
                    const SizedBox(height: 100,),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }


  Widget CheckboxListTile(int index) {
    return SizedBox(
      height: 24,
      width: 24,
      child: ElevatedButton(
        onPressed: () {
          value = index;
          setState(() {
            value = index;

            switch (index) {
              case 0:
                Get.updateLocale(
                    const Locale('en', 'English'));

                Get.back();
                break;
              case 1:
                Get.updateLocale(
                    const Locale('en', 'spanse'));

                Get.back();
                break;
              case 2:
                Get.updateLocale(
                    const Locale('en', 'arabic'));

                Get.back();
                break;
              case 3:
                Get.updateLocale(
                    const Locale('en', 'Hindi'));

                Get.back();
                break;
              case 4:
                Get.updateLocale(
                    const Locale('en', 'Gujarati'));

                Get.back();
                break;
              case 5:
                Get.updateLocale(
                    const Locale('en', 'African'));

                Get.back();
                break;
              case 6:
                Get.updateLocale(
                    const Locale('en', 'Bangali'));

                Get.back();
                break;
              case 7:
                Get.updateLocale(
                    const Locale('en', 'Indonesiya'));

                Get.back();

            }

          });
        },
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: const Color(0xffEEEEEE),
          side: BorderSide(
            color: (value == index)
                ? Colors.transparent
                : Colors.transparent,
            width: (value == index) ? 2 : 2,
          ),
          padding: const EdgeInsets.all(0),
        ),
        child: Center(
            child: Icon(
              Icons.check,
              color: value == index ? Colors.black : Colors.transparent,
              size: 18,
            )),
      ),
    );
  }


}

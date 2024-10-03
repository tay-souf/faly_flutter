// ignore_for_file: camel_case_types, use_key_in_widget_constructors, annotate_overrides, prefer_const_literals_to_create_immutables, file_names, unused_element, prefer_const_constructors, prefer_typing_uninitialized_variables, sort_child_properties_last, prefer_interpolation_to_compose_strings, unused_local_variable, curly_braces_in_flow_control_structures, library_private_types_in_public_api


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gofunds/auth_screen/push_notification.dart';
import 'package:gofunds/auth_screen/sign_up_screen.dart';
import 'package:gofunds/common/common_button.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bootom_navigation_screen/bottom_navigation_bar.dart';
import '../common/home_controoler.dart';
import '../common/light_dark_mode.dart';
import '../controller/login_controller.dart';
import 'login_screen.dart';

var lat;
var long;
var address;

class BoardingPage extends StatefulWidget {

  @override
  _BoardingScreenState createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingPage> {

  void initState() {
    super.initState();
    camerapermission();


    _currentPage = 0;

    _slides = [
      Slide("assets/on1.png", provider.discover, provider.healthy),
      Slide("assets/on2.png", provider.order, provider.orderthe),
      Slide("assets/on3.png", provider.lets, provider.cooking),
    ];

    _pageController = PageController(initialPage: _currentPage);

    super.initState();
  }



  Future camerapermission() async {
    final camerastatus = await Permission.camera.request();
    print("+++canmera+++:--- ($camerastatus)");
  }


  int _currentPage = 0;

  List<Slide> _slides = [];

  PageController _pageController = PageController();

  List<Widget> _buildSlides() {
    return _slides.map(_buildSlide).toList();
  }

  Widget _buildSlide(Slide slide) {
    return Scaffold(
      backgroundColor: notifier.background,
      body: Container(
        height: 600,
        width: Get.width,
        child: Image(image: AssetImage(slide.image),fit: BoxFit.cover,height: 300,),
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
      ),
    );
  }

  //! handling the on page changed
  void _handlingOnPageChanged(int page) {
    setState(() => _currentPage = page);
  }

  //! building page indicator
  Widget _buildPageIndicator() {
    Row row = Row(mainAxisAlignment: MainAxisAlignment.center, children: []);
    for (int i = 0; i < _slides.length; i++) {
      row.children.add(_buildPageIndicatorItem(i));
      if (i != _slides.length - 1)
        row.children.add(const SizedBox(
          width: 10,
        ));
    }
    return row;
  }

  Widget _buildPageIndicatorItem(int index) {
    return Container(
      width: index == _currentPage ? 30 : 8,
      height: index == _currentPage ? 6 : 8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color:
          index == _currentPage ? Colors.grey : Colors.grey.withOpacity(0.5)),
    );
  }

  sliderText() {
    return Padding(
      padding: const EdgeInsets.only(left: 30,right: 30),
      child: Column(
        children: [
          SizedBox(height: 20),
          SizedBox(
            width: Get.width ,
            child: Text(
              _currentPage == 0
                  // ? "Empower Change, One Donation at a Time".tr
                  ? "Empower Change, One Donation".tr
                  : _currentPage == 1
                  ? "Sharing Hope, Changing Lives".tr
                  : _currentPage == 2
                  ? "Where Giving Meets Purpose".tr
                  : "",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 22,
                  color: notifier.textcolore,
                fontFamily: 'SofiaProBold'
              ), //heding Text
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            width: Get.width * 0.90,
            child: Text(
              _currentPage == 0
                  ? "Our charity and donation app connects hearts and causes, making giving back effortless and impactful".tr
                  .tr
                  : _currentPage == 1
                  ? "With our charity and donation app, every act of kindness becomes a beacon of hope Join a community".tr
                  .tr
                  : _currentPage == 2
                  ? "Elevate your impact with our charity and donation app, where every donation is a step towards a greater purpose".tr
                  .tr
                  : "",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 13,
                  color: notifier.textcolore,
                  height: 1.6,
              ), //subtext
            ),
          ),
        ],
      ),
    );
  }

  ColorNotifier notifier = ColorNotifier();
  HomeController homeController = Get.put(HomeController());
  HomeApiController homeApiController = Get.put(HomeApiController());

  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          PageView(
            controller: _pageController,
            onPageChanged: _handlingOnPageChanged,
            physics: const BouncingScrollPhysics(),
            children: _buildSlides(),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              width: Get.size.width,
              decoration: BoxDecoration(
                color: notifier.containercolore,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  _buildPageIndicator(),
                  sliderText(),
                  SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                    child: CommonButton(containcolore: theamcolore, onPressed1: () async {
                      SharedPreferences preferences = await SharedPreferences.getInstance();
                      preferences.setBool("guestlogin",true);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Bottom_Navigation(),));
                    },txt1: 'Continue as guest'.tr,context: context),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                    child: CommonButtonwithboarder(bordercolore: Colors.grey.withOpacity(0.4), onPressed1: () async {
                      SharedPreferences preferences = await SharedPreferences.getInstance();
                      preferences.setBool("guestlogin",false);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Login_Scrren(),));
                    },context: context,txt1: 'Log In'.tr)
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () async {
                      SharedPreferences preferences = await SharedPreferences.getInstance();
                      preferences.setBool("guestlogin",false);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Sign_Up(social: false,socialemail: ''),));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account? '.tr,style: TextStyle(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.w500,fontFamily: 'SofiaRegular')),
                        Text('Sign Up'.tr,style: TextStyle(color: Colors.blueAccent,fontFamily: "SofiaProBold",fontSize: 16)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.012,
                  ),
                  const SizedBox(height: 20)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}







class Slide {
  String image;
  String heading;
  String subtext;

  Slide(this.image, this.heading, this.subtext);
}



class provider {
  static String discover = "Milk made modern!".tr;
  static String healthy =
      "Our app combines the convenience of technology with the tradition of the milkman"
          .tr;
  static String order = "Never miss a delivery again!".tr;
  static String orderthe =
      "With our app, you'll receive real-time notifications about your milk deliveries"
          .tr;
  static String lets = "Milk at your fingertips!".tr;
  static String cooking =
      "order fresh milk and dairy products for delivery straight to your doorstep"
          .tr;
  static String getstart = "Get Started".tr;
  static String skip = "Skip".tr;
  static String next = "Next".tr;
}
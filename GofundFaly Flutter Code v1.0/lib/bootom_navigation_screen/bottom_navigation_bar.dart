import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gofunds/auth_screen/login_screen.dart';
import 'package:gofunds/common/common_button.dart';
import 'package:provider/provider.dart';

import '../app_screen/account_screen.dart';
import '../app_screen/notification_screen.dart';
import '../common/home_controoler.dart';
import '../common/light_dark_mode.dart';
import 'home_screen.dart';
import 'manage_screen.dart';

class Bottom_Navigation extends StatefulWidget {
  const Bottom_Navigation({super.key});

  @override
  State<Bottom_Navigation> createState() => _Bottom_NavigationState();
}

class _Bottom_NavigationState extends State<Bottom_Navigation> {


  static  final List _widgetOptions = [
    const home_screen(),
    const Notification_Screen(),
    const Manage_screen(),
    const Account_Scrrn(),
  ];

  HomeController homeController = Get.put(HomeController());

  void _onItemTapped(int index) {
    if(boolValue!){
      if(index>0){
        Get.offAll(const Login_Scrren());
      }else{
        setState(() {
          homeController.selectpage = index;
        });
      }
    }else{
      setState(() {
        homeController.selectpage = index;
      });
    }
  }

  ColorNotifier notifier = ColorNotifier();

  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return GetBuilder<HomeController>(
        builder: (homeController) {
          return Scaffold(
            extendBody: true,
            backgroundColor: Colors.transparent,
            bottomNavigationBar: Container(
              alignment: Alignment.center,
              height: 80,
              margin: const EdgeInsets.only(left: 50,right: 50,top: 10,bottom: 20),
              decoration: BoxDecoration(
                color: const Color(0xff27262B),
                borderRadius: BorderRadius.circular(50),
              ),
              child: BottomNavigationBar(
                unselectedItemColor: notifier.textcolore,
                type: BottomNavigationBarType.fixed,
                // selectedFontSize: 12,
                // unselectedFontSize: 12,
                unselectedFontSize: 0,
                selectedFontSize: 0,
                backgroundColor: Colors.transparent,
                elevation: 0,
                unselectedLabelStyle: const TextStyle(fontSize: 0,height: 0),
                selectedLabelStyle: const TextStyle(fontSize: 0,height: 0),
                items:  <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: homeController.selectpage == 0 ?  Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(image: const AssetImage('assets/a1homebold.png'),height: 20,width: 20,color: theamcolore),
                          const SizedBox(height: 5,),
                          Container(
                            height: 5,
                            width: 5,
                            decoration: BoxDecoration(
                              color: theamcolore,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                    ) : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(image: const AssetImage('assets/home.png'),height: 20,width: 20,color: Colors.white),
                        const SizedBox(height: 5,),
                        Container(
                          height: 5,
                          width: 5,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: homeController.selectpage == 1 ?   Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                        // color: theamcolore.withOpacity(0.1),
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(image: const AssetImage('assets/a2bellbold.png'),height: 22,width: 22,color: theamcolore),
                          const SizedBox(height: 5,),
                          Container(
                            height: 5,
                            width: 5,
                            decoration: BoxDecoration(
                              color: theamcolore,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                    ) :  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(image: const AssetImage('assets/bell.png'),height: 22,width: 22,color: Colors.white),
                        const SizedBox(height: 5,),
                        Container(
                          height: 5,
                          width: 5,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                    label: ''.tr,
                  ),
                  BottomNavigationBarItem(
                    icon: homeController.selectpage == 2 ?   Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(image: const AssetImage('assets/a3sticky-note-text-squarebold.png'),height: 24,width: 24,color: theamcolore),
                          const SizedBox(height: 5,),
                          Container(
                            height: 5,
                            width: 5,
                            decoration: BoxDecoration(
                              color: theamcolore,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                    ) :  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(image: const AssetImage('assets/sticky-note-text-square.png'),height: 24,width: 24,color: Colors.white),
                        const SizedBox(height: 5,),
                        Container(
                          height: 5,
                          width: 5,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                    label: ''.tr,
                  ),
                  BottomNavigationBarItem(
                    icon: homeController.selectpage == 3 ?   Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(image: const AssetImage('assets/a4user-circlebold.png'),height: 22,width: 22,color: theamcolore),
                          const SizedBox(height: 5,),
                          Container(
                            height: 5,
                            width: 5,
                            decoration: BoxDecoration(
                              color: theamcolore,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                    ) :  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(image: const AssetImage('assets/user-circle.png'),height: 22,width: 22,color: Colors.white),
                        const SizedBox(height: 5,),
                        Container(
                          height: 5,
                          width: 5,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                    label: ''.tr,
                  ),
                ],
                currentIndex: homeController.selectpage,
                selectedItemColor: theamcolore,
                onTap: _onItemTapped,
              ),
            ),
            body: Center(
              child: _widgetOptions.elementAt(homeController.selectpage),
            ),

          );
        }
    );
  }
}


















// // ignore_for_file: camel_case_types, file_names
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:gofunds/auth_screen/login_screen.dart';
// import 'package:gofunds/common/common_button.dart';
// import 'package:provider/provider.dart';
//
// import '../app_screen/account_screen.dart';
// import '../common/home_controoler.dart';
// import '../common/light_dark_mode.dart';
// import 'home_screen.dart';
// import 'manage_screen.dart';
//
// class Bottom_Navigation extends StatefulWidget {
//   const Bottom_Navigation({super.key});
//
//   @override
//   State<Bottom_Navigation> createState() => _Bottom_NavigationState();
// }
//
// class _Bottom_NavigationState extends State<Bottom_Navigation> {
//
//   // int _selectedIndex = 0;
//
//   static  final List _widgetOptions = [
//     const home_screen(),
//     const home_screen(),
//     const Manage_screen(),
//     const Account_Scrrn(),
//   ];
//
//   HomeController homeController = Get.put(HomeController());
//
//   void _onItemTapped(int index) {
//     if(boolValue!){
//       if(index>0){
//         Get.offAll(const Login_Scrren());
//       }else{
//         setState(() {
//           homeController.selectpage = index;
//         });
//       }
//     }else{
//       setState(() {
//         homeController.selectpage = index;
//       });
//     }
//   }
//
//
//   ColorNotifier notifier = ColorNotifier();
//
//   @override
//   Widget build(BuildContext context) {
//     notifier = Provider.of<ColorNotifier>(context, listen: true);
//     return GetBuilder<HomeController>(
//         builder: (homeController) {
//           return Scaffold(
//             bottomNavigationBar: BottomNavigationBar(
//               unselectedItemColor: notifier.textcolore,
//               type: BottomNavigationBarType.fixed,
//               selectedFontSize: 12,
//               unselectedFontSize: 12,
//               backgroundColor: notifier.background,
//               elevation: 0,
//               items:  <BottomNavigationBarItem>[
//                 BottomNavigationBarItem(
//                   icon: homeController.selectpage == 0 ?  Padding(
//                     padding: const EdgeInsets.only(bottom: 5),
//                     child: Image(image: const AssetImage('assets/home.png'),height: 20,width: 20,color: theamcolore),
//                   ) : Padding(
//                     padding: const EdgeInsets.only(bottom: 5),
//                     child: Image(image: const AssetImage('assets/home.png'),height: 20,width: 20,color: notifier.textcolore),
//                   ),
//                   label: 'Discover'.tr,
//                 ),
//                 BottomNavigationBarItem(
//                   icon: homeController.selectpage == 1 ?  Padding(
//                     padding: const EdgeInsets.only(bottom: 5),
//                     child: Image(image: const AssetImage('assets/bell.png'),height: 22,width: 22,color: theamcolore),
//                   ) :  Padding(
//                     padding: const EdgeInsets.only(bottom: 5),
//                     child: Image(image: const AssetImage('assets/bell.png'),height: 22,width: 22,color: notifier.textcolore),
//                   ),
//                   label: 'Notifications'.tr,
//                 ),
//                 BottomNavigationBarItem(
//                   icon: homeController.selectpage == 2 ?  Padding(
//                     padding: const EdgeInsets.only(bottom: 5),
//                     child: Image(image: const AssetImage('assets/sticky-note-text-square.png'),height: 24,width: 24,color: theamcolore),
//                   ) :  Padding(
//                     padding: const EdgeInsets.only(bottom: 5),
//                     child: Image(image: const AssetImage('assets/sticky-note-text-square.png'),height: 24,width: 24,color: notifier.textcolore),
//                   ),
//                   label: 'Manage'.tr,
//                 ),
//                 BottomNavigationBarItem(
//                   icon: homeController.selectpage == 3 ?  Padding(
//                     padding: const EdgeInsets.only(bottom: 5),
//                     child: Image(image: const AssetImage('assets/user-circle.png'),height: 22,width: 22,color: theamcolore),
//                   ) :  Padding(
//                     padding: const EdgeInsets.only(bottom: 5),
//                     child: Image(image: const AssetImage('assets/user-circle.png'),height: 22,width: 22,color: notifier.textcolore),
//                   ),
//                   label: 'Me'.tr,
//                 ),
//               ],
//               currentIndex: homeController.selectpage,
//               selectedItemColor: theamcolore,
//               onTap: _onItemTapped,
//             ),
//             body: Center(
//               child: _widgetOptions.elementAt(homeController.selectpage),
//             ),
//
//           );
//         }
//     );
//   }
// }
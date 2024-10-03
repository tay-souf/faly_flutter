// ignore_for_file: camel_case_types, avoid_print, prefer_typing_uninitialized_variables, unnecessary_null_comparison, prefer_collection_literals

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:gofunds/common/config.dart';
import 'package:gofunds/secound_bootom_navigation_screen/your_funder_screen.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app_screen/add_fundraiser_photo_screen.dart';
import '../app_screen/create_fundraiser.dart';
import '../app_screen/describe_fundraising.dart';
import '../app_screen/fundraiser_details.dart';
import '../app_screen/passenger_details.dart';
import '../bootom_navigation_screen/bottom_navigation_bar.dart';
import '../bootom_navigation_screen/home_screen.dart';
import '../common/common_button.dart';
import '../common/home_controoler.dart';
import '../common/light_dark_mode.dart';
import '../controller/getapi_controller.dart';
import '../controller/login_controller.dart';
import 'dart:ui' as ui;


XFile? selectImage;
List<String> fundupdateimage=[];
int tab = 0;
TextEditingController photoscreencontroller = TextEditingController();
TextEditingController textscreencontroller = TextEditingController();


class secound_bottombar extends StatefulWidget {
  final String id;
  final bool isComplete;
  final bool ordercomplete;
  final bool ordercancel;
  const secound_bottombar({super.key, required this.id, required this.isComplete, required this.ordercomplete, required this.ordercancel});

  @override
  State<secound_bottombar> createState() => _secound_bottombarState();
}

class _secound_bottombarState extends State<secound_bottombar> {

  HomeController homeController = Get.put(HomeController());

  List textlist = [
    'Edit'.tr,
    'Donations'.tr,
    'Update'.tr,
  ];

  List textlistcomplete = [
    'Donations'.tr,
  ];


  List imagelist = [
    'assets/editicon2.png',
    'assets/donateicon.png',
    'assets/upadateicon.png',
  ];


  List imagelistcomplete = [
    'assets/editicon2.png',
    'assets/donateicon.png',
    'assets/upadateicon.png',
  ];

  int selectPageIndex = -1;

  setSelectPage(int value) {
    setState(() {
      selectPageIndex = value;
    });
  }

  bool light = true;
  bool light1 = true;
  bool light2 = true;


  String googleApikey = "AIzaSyCRF9Q1ttrleh04hqRlP_CqsFCPU815jJk";
  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  LatLng startLocation = const LatLng(27.6602292, 85.308027);
  String location = "Search for your postcode".tr;

  ImagePicker picker = ImagePicker();

  FundDidWiseController fundDidWiseController = Get.put(FundDidWiseController());
  HomeApiController homeApiController = Get.put(HomeApiController());
  FundEditApiController fundEditApiController = Get.put(FundEditApiController());

  @override
  void initState() {
    super.initState();

    datagetfunction();

    setState(() {
      print("bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb");
      fun().then((value) {
        setState(() {
        });
      },);
    });

  }

  var userdata;
  var currency1;

 Future datagetfunction() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var uid = preferences.getString("userLogin");
    var curr = currency1 = preferences.getString("currenci");
    userdata = jsonDecode(uid!);
    currency1 = jsonDecode(curr!);
    fundDidWiseController.funddidApi(uid: userdata['id'], fundid: widget.id,status: "My_Fund").then((value) {
      emapty = fundDidWiseController.fundidimodel!.funddata[0].id;
      if(fundDidWiseController.fundidimodel!.funddata[0].fundFor == "Self"){
        select = 0;
      } else if(fundDidWiseController.fundidimodel!.funddata[0].fundFor == "Other"){
        select = 1;
      }else{
        select = 2;
      }
      setState(() {
      });
      lat = fundDidWiseController.fundidimodel!.funddata[0].lats;
      long = fundDidWiseController.fundidimodel!.funddata[0].longs;
      print("----INITSTATE----:--- ${lat}");
      print("----INITSTATE----:--- ${long}");
    });
    fun();
    print(" + + + + + + + + + - - - - - - - - - : - - - - -    ${widget.id}");
    homeApiController.homeApi(uid: userdata['id'],latitude: lathome.toString(),logitude: longhome.toString());
  }


  ImagePicker fundspicker = ImagePicker();
  ImagePicker fundspicker1 = ImagePicker();

  Future fundcamera() async {
    XFile? file = await fundspicker.pickImage(source: ImageSource.camera);
    if(file!=null){
      setState(() {
        finalimage.add(file.path);
      });
    } else{
      Fluttertoast.showToast(msg: 'image pick in not Camera!!'.tr);
    }
  }
  Future fundgallery() async {
    XFile? file = await fundspicker1.pickImage(source: ImageSource.gallery);
    if(file!=null){
      setState(() {
        finalimage.add(file.path);
      });
    }else{
      Fluttertoast.showToast(msg: 'image not selected!!'.tr);
    }
  }



  // Patient Pic

  ImagePicker patientpicker = ImagePicker();
  ImagePicker patientpicker1 = ImagePicker();

  Future patientcamera() async {
    XFile? file = await patientpicker.pickImage(source: ImageSource.camera);
    if(file!=null){
      setState(() {
        passengerimage.add(file.path);
      });
    } else{
      Fluttertoast.showToast(msg: 'image pick in not Camera!!'.tr);
    }
  }

  Future patientgallery() async {
    XFile? file = await patientpicker1.pickImage(source: ImageSource.gallery);
    if(file!=null){
      setState(() {
        passengerimage.add(file.path);
      });
    }else{
      Fluttertoast.showToast(msg: 'image not selected!!'.tr);
    }
  }



  // Certification Pic

  ImagePicker certificationpicker = ImagePicker();
  ImagePicker certificationpicker1 = ImagePicker();

  Future certificationcamera() async {
    XFile? file = await certificationpicker.pickImage(source: ImageSource.camera);
    if(file!=null){
      setState(() {
        image.add(file.path);
      });
    } else{
      Fluttertoast.showToast(msg: 'image pick in not Camera!!'.tr);
    }
  }

  Future certificationgallery() async {
    XFile? file = await certificationpicker1.pickImage(source: ImageSource.gallery);
    if(file!=null){
      setState(() {
        image.add(file.path);
      });
    }else{
      Fluttertoast.showToast(msg: 'image not selected!!'.tr);
    }
  }

  TextEditingController controller = TextEditingController();

  FundupdateApiController fundupdateApiController = Get.put(FundupdateApiController());

  // Patient Pic

  ImagePicker fundupdate = ImagePicker();
  ImagePicker fundupdate1 = ImagePicker();

  Future fundupdatecamera() async {
    XFile? file = await fundupdate.pickImage(source: ImageSource.camera);
    if(file!=null){
      setState(() {
        fundupdateimage.add(file.path);
      });
    } else{
      Fluttertoast.showToast(msg: 'image pick in not Camera!!'.tr);
    }
  }

  Future fundupdategallery() async {
    XFile? file = await fundupdate1.pickImage(source: ImageSource.gallery);
    if(file!=null){
      setState(() {
        fundupdateimage.add(file.path);
      });
    }else{
      Fluttertoast.showToast(msg: 'image not selected!!'.tr);
    }
  }

  ColorNotifier notifier = ColorNotifier();

  late GoogleMapController mapController1;
  Set<Marker> markers = Set();

  Future<Uint8List> getImages(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<void> _onAddMarkerButtonPressed(double? lat, long) async {
    final Uint8List markIcon = await getImages("assets/location_pin.png", 80);
      markers.add(Marker(
        markerId: const MarkerId("1"),
        position: LatLng(double.parse(lat.toString()),double.parse(long.toString())),
        icon: BitmapDescriptor.fromBytes(markIcon),
      ));
    setState(() {});
  }


  getCurrentLatAndLong(double latitude, double longitude) async {

    setState(()  {
      lat = latitude;
      long = longitude;
    });


    await placemarkFromCoordinates(lat, long).then((List<Placemark> placemarks) {
      address = '${placemarks.first.name}, ${placemarks.first.locality}, ${placemarks.first.country}';
    });

  }



  fun() async {

    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {}
    var currentLocation = await locateUser();
    debugPrint('location 11111: ${lat}');
    getCurrentLatAndLong(
      double.parse(lat.toString()),
      double.parse(long.toString()),
    );
    _onAddMarkerButtonPressed(lat, long);
    print("????????????${long}");
    print("USER CURRENT LOCATION : --  $address");

  }


  Future<Position> locateUser() async {
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high
    );
  }


  String titlexyz = "";

  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      bottomNavigationBar:  widget.ordercancel == true ? const SizedBox() : fundDidWiseController.isLoading ? Container(
        margin: const EdgeInsets.only(left: 50,right: 50,top: 10,bottom: 20),
        decoration: BoxDecoration(
            color: theamcolore,
            borderRadius: BorderRadius.circular(50)
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          ],
        ),
      ) : widget.ordercomplete == true ? Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.only(left: 120,right: 120,top: 20,bottom: 20),
        decoration: BoxDecoration(
          color: theamcolore,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListView.builder(
                    clipBehavior: Clip.none,
                    itemCount: textlistcomplete.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {
                            datagetfunction();
                            setState(() {
                              fun().then((value) {
                                setState(() {
                                });
                              },);
                            });


                            homeController.photocontroller.clear();
                            homeController.Storycontroller.clear();
                            selectImage = null;
                            setSelectPage(index);

                            emapty = fundDidWiseController.fundidimodel!.funddata[0].id;
                            titlecontroller.text = fundDidWiseController.fundidimodel!.funddata[0].title;

                            if(fundDidWiseController.fundidimodel!.funddata[0].fundFor == "Self"){
                              select = 0;
                            }else if(fundDidWiseController.fundidimodel!.funddata[0].fundFor == "Other"){
                              select = 1;
                            }else{
                              select = 2;
                            }

                            fundamountcontroller.text = fundDidWiseController.fundidimodel!.funddata[0].fundAmt;
                            address = fundDidWiseController.fundidimodel!.funddata[0].fullAddress;
                            lat = fundDidWiseController.fundidimodel!.funddata[0].lats;
                            long = fundDidWiseController.fundidimodel!.funddata[0].longs;

                            print("******:---  $address");
                            print("++++++:--- $lat");
                            print("------:--- $long");
                            print("------:--- ${fundDidWiseController.fundidimodel!.funddata[0].lats}");
                            print("------:--- ${fundDidWiseController.fundidimodel!.funddata[0].longs}");
                            print("------:--- ${fundDidWiseController.fundidimodel!.funddata[0].fundStatus}");


                            storycontroller.text = fundDidWiseController.fundidimodel!.funddata[0].fundStory;
                            patentnamecontroller.text = fundDidWiseController.fundidimodel!.funddata[0].patientTitle;
                            patientdiagnosiscontroller.text = fundDidWiseController.fundidimodel!.funddata[0].patientDiagnosis;
                            fundplancontroller.text = fundDidWiseController.fundidimodel!.funddata[0].fundPlan;

                            Get.bottomSheet(
                                StatefulBuilder(
                                    builder: (context, setState)  {
                                      return Scaffold(
                                        resizeToAvoidBottomInset: false,
                                        backgroundColor: notifier.background,
                                        appBar: AppBar(
                                          elevation: 0,
                                          toolbarHeight: 90,
                                          backgroundColor: notifier.background,
                                          leading: InkWell(
                                            onTap: () {
                                              Get.back();
                                              markers.clear();
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(top: 50),
                                              child:  Icon(Icons.close,color: notifier.textcolore),
                                            ),
                                          ),
                                          title: Padding(
                                            padding: const EdgeInsets.only(top: 50),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Transform.translate(offset: const Offset(-15, 0),child : Text(fundDidWiseController.fundidimodel!.funddata[0].title,style: TextStyle(color: notifier.textcolore,fontSize: 16,fontFamily: "SofiaProBold"),overflow: TextOverflow.ellipsis,)),
                                                const SizedBox(height: 5,),
                                                Transform.translate(offset: const Offset(-15, 0),child : Text('$currency1${double.parse(fundDidWiseController.fundidimodel!.funddata[0].totalInvestment.toString()).toStringAsFixed(2)} raised of $currency1${double.parse(fundDidWiseController.fundidimodel!.funddata[0].remainAmt.toString()).toStringAsFixed(2)}',style: TextStyle(color: Colors.grey,fontSize: 12)))
                                              ],
                                            ),
                                          ),
                                        ),
                                        body: StatefulBuilder(builder: (context, setState) {
                                          return Container(
                                            height: Get.height,
                                            width: Get.width,
                                            decoration:  BoxDecoration(
                                                color: notifier.background,
                                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
                                            ),
                                            child: SingleChildScrollView(
                                              child: Padding(
                                                padding: const EdgeInsets.all(15),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Donaters (${fundDidWiseController.fundidimodel!.funddata[0].donaterlist.length})',style: TextStyle(color: notifier.textcolore,fontSize: 18,fontFamily: "SofiaProBold"),),
                                                    const SizedBox(height: 10,),
                                                    SizedBox(
                                                      height: Get.height,
                                                      width: Get.width,
                                                      child: ListView.separated(
                                                        physics: const NeverScrollableScrollPhysics(),
                                                        itemCount: fundDidWiseController.fundidimodel!.funddata[0].donaterlist.length,
                                                        scrollDirection: Axis.vertical,
                                                        separatorBuilder: (context, index) {
                                                          return const SizedBox(width: 10,);
                                                        },
                                                        itemBuilder: (context, index) {
                                                          return ListTile(
                                                            contentPadding: EdgeInsets.zero,
                                                            leading: Container(
                                                              height: 40,
                                                              width: 40,
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(65),
                                                                  image: fundDidWiseController.fundidimodel!.funddata[0].donaterlist[index].profilePic == null ? const DecorationImage(image: AssetImage("")) :    DecorationImage(image: NetworkImage(Config.baseurl + fundDidWiseController.fundidimodel!.funddata[0].donaterlist[index].profilePic),fit: BoxFit.fill)
                                                              ),
                                                            ),
                                                            title: Transform.translate(offset: const Offset(-5, 0),child :  Text('${ fundDidWiseController.fundidimodel!.funddata[0].donaterlist[index].name == null ? "" :   fundDidWiseController.fundidimodel!.funddata[0].donaterlist[index].name}',style: TextStyle(color: notifier.textcolore,fontSize: 16,fontFamily: "SofiaProBold"),overflow: TextOverflow.ellipsis,)),
                                                            subtitle: Transform.translate(offset: const Offset(-5, 0),child:  Text('$currency1 ${fundDidWiseController.fundidimodel!.funddata[0].donaterlist[index].amt}',style: const TextStyle(color: Colors.grey,fontSize: 12))),
                                                          );
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },),
                                      );
                                    }
                                ),
                                isScrollControlled: true
                            ) ;

                            selectPageIndex = -1;

                          },
                          child: SizedBox(
                            width: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  imagelistcomplete[index],
                                  width: 22,
                                  height: 22,
                                  color: selectPageIndex == index ? theamcolore : Colors.white,
                                ),
                                const SizedBox(height: 3),
                                Flexible(
                                  child: Text(
                                      textlistcomplete[index].toString(),
                                      style: TextStyle(
                                          fontSize: 12,
                                          color:
                                          selectPageIndex == index
                                              ? theamcolore
                                              : Colors.white,
                                          fontWeight: FontWeight.w400
                                      ),
                                      overflow: TextOverflow.ellipsis
                                  ),
                                ),
                              ],
                            ),
                          ));
                    },
                  ) ,
                ],
              ),
            ),
          ],
        ),
      ) : Container(
        margin: const EdgeInsets.only(left: 45,right: 45,top: 10,bottom: 20),
        decoration: BoxDecoration(
          color: theamcolore,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                ListView.builder(
                    clipBehavior: Clip.none,
                    itemCount: textlist.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {
                            datagetfunction();
                            setState(() {
                              fun().then((value) {
                                setState(() {
                                });
                              },);
                            });


                            homeController.photocontroller.clear();
                            homeController.Storycontroller.clear();
                            selectImage = null;
                            setSelectPage(index);

                            emapty = fundDidWiseController.fundidimodel!.funddata[0].id;
                            titlecontroller.text = fundDidWiseController.fundidimodel!.funddata[0].title;

                            if(fundDidWiseController.fundidimodel!.funddata[0].fundFor == "Self"){
                              select = 0;
                            }else if(fundDidWiseController.fundidimodel!.funddata[0].fundFor == "Other"){
                              select = 1;
                            }else{
                              select = 2;
                            }

                            fundamountcontroller.text = fundDidWiseController.fundidimodel!.funddata[0].fundAmt;
                            address = fundDidWiseController.fundidimodel!.funddata[0].fullAddress;
                            lat = fundDidWiseController.fundidimodel!.funddata[0].lats;
                            long = fundDidWiseController.fundidimodel!.funddata[0].longs;
                            emapty = fundDidWiseController.fundidimodel!.funddata[0].catId;

                            for(int i = 0; i< homeApiController.homeapimodel!.category.length; i++){
                              if(emapty == homeApiController.homeapimodel!.category[i].id){
                                titlexyz = homeApiController.homeapimodel!.category[i].title;
                                setState(() {});
                                print("<><><><><><> CATEGORY TITLE <><><><><><> $titlexyz");
                              }
                            }



                            print("******:---  $address");
                            print("++++++:--- $lat");
                            print("------:--- $long");
                            print("---- emapty1 --:--- $emapty1");
                            print("------:--- ${fundDidWiseController.fundidimodel!.funddata[0].lats}");
                            print("------:--- ${fundDidWiseController.fundidimodel!.funddata[0].longs}");
                            print("---fundStatus---:--- ${fundDidWiseController.fundidimodel!.funddata[0].fundStatus}");
                            print("***********************************************************:--- ${fundDidWiseController.fundidimodel!.funddata[0].status}");
                            print("***********************************************************:--- ${fundDidWiseController.fundidimodel!.funddata[0].expDate.toString().split(" ").first}");


                            // String dateString = fundDidWiseController.fundidimodel!.funddata[0].expDate.toString().split(" ").first;
                            // List<String> dateParts = dateString.split('-');
                            // int year = int.parse(dateParts[0]);
                            // int month = int.parse(dateParts[1]);
                            // int day = int.parse(dateParts[2]);
                            // selectedDateAndTime = DateTime(year,month,day);
                            // print("************************selectedDateAndTime***********************************:--- ${selectedDateAndTime}");

                            storycontroller.text = fundDidWiseController.fundidimodel!.funddata[0].fundStory.replaceAll("\\n", "\n");
                            patentnamecontroller.text = fundDidWiseController.fundidimodel!.funddata[0].patientTitle;
                            patientdiagnosiscontroller.text = fundDidWiseController.fundidimodel!.funddata[0].patientDiagnosis;
                            fundplancontroller.text = fundDidWiseController.fundidimodel!.funddata[0].fundPlan.replaceAll("\\n", "\n");

                             selectPageIndex == 0 ?  Get.bottomSheet(
                                StatefulBuilder(
                                    builder: (context, setState)  {
                                      return Scaffold(
                                        bottomNavigationBar: Padding(
                                          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                                          child: CommonButton(containcolore: theamcolore, txt1: 'Update'.tr, context: context,onPressed1: () {
                                            Get.back();
                                          fundEditApiController.fundeditapi(
                                            context: context,
                                              cat_id: emapty,
                                              title: titlecontroller.text,
                                              fund_for: select == 0 ? "Self" : select == 1 ? "Other" : "Charity",
                                              fund_amt: fundamountcontroller.text,
                                              fund_story: storycontroller.text,
                                              exp_date: selectedDateAndTime.toString().split(" ").first,
                                              patient_title: patentnamecontroller.text,
                                              patient_diagnosis: patientdiagnosiscontroller.text,
                                              fund_plan: fundplancontroller.text,
                                              fundsize: '${finalimage.length}',
                                              petientsize: '${passengerimage.length}',
                                              certicatesize: '${image.length}',
                                              uid: '${userdata['id']}',
                                              status: sender == "Publish" ? '0' : '1',
                                              record_id: widget.id,
                                              certpic0: image,
                                              fundpic0: finalimage,
                                              petpic0: passengerimage,
                                              imlist: fundDidWiseController.fundidimodel!.funddata[0].fundPhotos.isEmpty ? "0" : fundDidWiseController.fundidimodel!.funddata[0].fundPhotos.join("\$;"),
                                              imlists: fundDidWiseController.fundidimodel!.funddata[0].patientPhoto.isEmpty ? "0" : fundDidWiseController.fundidimodel!.funddata[0].patientPhoto.join("\$;"),
                                              imlistss: fundDidWiseController.fundidimodel!.funddata[0].medicalCertificate.isEmpty ? "0" : fundDidWiseController.fundidimodel!.funddata[0].medicalCertificate.join("\$;"),
                                              full_address: address,
                                              lats: lat.toString(),
                                              longs: long.toString()
                                          ).then((value) {
                                            finalimage.clear();
                                            image.clear();
                                            passengerimage.clear();
                                            setState((){});
                                          },);



                                          }),
                                        ),
                                        resizeToAvoidBottomInset: false,
                                        backgroundColor: notifier.background,
                                        appBar: AppBar(
                                          elevation: 0,
                                          toolbarHeight: 90,
                                          backgroundColor: notifier.background,
                                          leading: InkWell(
                                              onTap: () {
                                                Get.back();
                                                markers.clear();
                                              },
                                              child:  Padding(
                                                padding: const EdgeInsets.only(top: 40),
                                                child: Icon(Icons.arrow_back_ios_sharp,color: notifier.textcolore,size: 20,),
                                              ),
                                          ),
                                        ),
                                        body: StatefulBuilder(builder: (context, setState) {
                                          return Container(
                                            height: Get.height,
                                            width: Get.width,
                                            decoration:  BoxDecoration(
                                              color: notifier.background,
                                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
                                            ),
                                            child: SingleChildScrollView(
                                              child: Padding(
                                                padding: const EdgeInsets.all(15),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Select Beneficiary Pictures'.tr,style: TextStyle(color: notifier.textcolore,fontSize: 14,fontWeight: FontWeight.bold),),
                                                    const SizedBox(height: 10,),
                                                    InkWell(
                                                      onTap: () {
                                                        showModalBottomSheet(
                                                          backgroundColor: notifier.containercolore,
                                                          isDismissible: false,
                                                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(13))),
                                                          context: context,
                                                          builder: (context) {
                                                            return SingleChildScrollView(
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(10),
                                                                child: Column(
                                                                  children: [
                                                                    Text("From where do you want to take the photo?".tr, style: TextStyle(fontSize: 20, color: notifier.textcolore),),
                                                                    const SizedBox(height: 15),
                                                                    Row(
                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                      children: [
                                                                        Expanded(
                                                                          child: OutlinedButton(
                                                                            style: OutlinedButton.styleFrom(side: BorderSide(color: notifier.textcolore),fixedSize: const Size(100, 50), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
                                                                            onPressed: () {
                                                                              patientgallery().then((value) => {setState((){})});
                                                                              Get.back();
                                                                            },
                                                                            child:  Text("Gallery".tr, style: TextStyle( fontSize: 15, color: notifier.textcolore),),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(width: 13),
                                                                        Expanded(
                                                                          child: OutlinedButton(
                                                                            style: OutlinedButton.styleFrom(side: BorderSide(color: notifier.textcolore),fixedSize: const Size(100, 50), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
                                                                            onPressed: ()  {
                                                                              patientcamera().then((value) => {setState((){})});
                                                                              Get.back();
                                                                            },
                                                                            child:  Text("Camera".tr, style: TextStyle(fontSize: 15, color: notifier.textcolore),),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    const SizedBox(height: 15),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: Container(
                                                        width: 190,
                                                        padding: const EdgeInsets.all(10),
                                                        decoration: BoxDecoration(
                                                            border: Border.all(color: theamcolore),
                                                            borderRadius: BorderRadius.circular(10)
                                                        ),
                                                        child:  Center(child: Text('Upload Photos (Multiple)'.tr,style: TextStyle(color: notifier.textcolore),)),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10,),

                                                    SizedBox(
                                                      width: Get.width,
                                                      child: SingleChildScrollView(
                                                        scrollDirection: Axis.horizontal,
                                                        child: Row(
                                                          children: [
                                                            for(int a =0;a< fundDidWiseController.fundidimodel!.funddata[0].patientPhoto.length;a++) fundDidWiseController.fundidimodel!.funddata[0].patientPhoto[a] =="0" ? const SizedBox() : Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: Stack(
                                                                clipBehavior: Clip.none,
                                                                children: [
                                                                  Container(
                                                                    height: 150,
                                                                    width: 150,
                                                                    decoration: BoxDecoration(
                                                                        color: greaycolore,
                                                                        borderRadius: BorderRadius.circular(10),
                                                                    ),
                                                                    child: ClipRRect(
                                                                      borderRadius: BorderRadius.circular(10),
                                                                      child: FadeInImage.assetNetwork(
                                                                        placeholder: "assets/gfimage.png",
                                                                        placeholderCacheWidth: 290,
                                                                        placeholderCacheHeight: 270,
                                                                        image:
                                                                        Config.baseurl + fundDidWiseController.fundidimodel!.funddata[0].patientPhoto[a],
                                                                        fit: BoxFit.cover,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Positioned(
                                                                    right: -10,
                                                                    top: -8,
                                                                    child: GestureDetector(
                                                                      onTap: () {
                                                                        setState(() {
                                                                          fundDidWiseController.fundidimodel!.funddata[0].patientPhoto.removeAt(a);
                                                                        });
                                                                      },
                                                                      child: Container(
                                                                        height: 26,
                                                                        width: 26,
                                                                        decoration: const BoxDecoration(
                                                                          color: Colors.blue,
                                                                          shape: BoxShape.circle,
                                                                        ),
                                                                        child: const Center(child: Icon(Icons.close, color: Colors.white, size: 18,)),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),

                                                            for(int a =0;a< passengerimage.length;a++) Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: Stack(
                                                                clipBehavior: Clip.none,
                                                                children: [
                                                                  Container(
                                                                    height: 150,
                                                                    width: 150,
                                                                    decoration: BoxDecoration(
                                                                        color: greaycolore,
                                                                        borderRadius: BorderRadius.circular(10),
                                                                        image: DecorationImage(image: FileImage(File(passengerimage[a])),fit: BoxFit.fill)
                                                                    ),
                                                                  ),
                                                                  Positioned(
                                                                    right: -10,
                                                                    top: -8,
                                                                    child: GestureDetector(
                                                                      onTap: () {
                                                                        setState(() {
                                                                          passengerimage.removeAt(a);
                                                                        });
                                                                      },
                                                                      child: Container(
                                                                        height: 26,
                                                                        width: 26,
                                                                        decoration: const BoxDecoration(
                                                                          color: Colors.blue,
                                                                          shape: BoxShape.circle,
                                                                        ),
                                                                        child: const Center(child: Icon(Icons.close, color: Colors.white, size: 18,)),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),


                                                    const SizedBox(height: 10,),
                                                    Text('Recipient Name'.tr,style: TextStyle(color: notifier.textcolore,fontSize: 14,fontWeight: FontWeight.bold)),
                                                    const SizedBox(height: 10,),
                                                    CommonTextfiled200(txt: fundDidWiseController.fundidimodel!.funddata[0].patientTitle,context: context,controller: patentnamecontroller),

                                                    const SizedBox(height: 10,),
                                                    Text('Medical Condition'.tr,style: TextStyle(color: notifier.textcolore,fontSize: 14,fontWeight: FontWeight.bold)),
                                                    const SizedBox(height: 10,),
                                                    CommonTextfiled200(txt: fundDidWiseController.fundidimodel!.funddata[0].patientDiagnosis,context: context,controller: patientdiagnosiscontroller),

                                                    const SizedBox(height: 10,),

                                                    Text('Cover Photos'.tr,style: TextStyle(color: notifier.textcolore,fontSize: 14,fontWeight: FontWeight.bold),),
                                                    const SizedBox(height: 10,),
                                                    InkWell(
                                                      onTap: () {
                                                        showModalBottomSheet(
                                                          backgroundColor: notifier.containercolore,
                                                          isDismissible: false,
                                                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(13))),
                                                          context: context,
                                                          builder: (context) {
                                                            return SingleChildScrollView(
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(10),
                                                                child: Column(
                                                                  children: [
                                                                    Text("From where do you want to take the photo?".tr, style: TextStyle(fontSize: 20, color: notifier.textcolore),),
                                                                    const SizedBox(height: 15),
                                                                    Row(
                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                      children: [
                                                                        Expanded(
                                                                          child: OutlinedButton(
                                                                            style: OutlinedButton.styleFrom(side: BorderSide(color: notifier.textcolore),fixedSize: const Size(100, 50), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
                                                                            onPressed: () {
                                                                              fundgallery().then((value) => {setState((){})});
                                                                              Get.back();
                                                                            },
                                                                            child:  Text("Gallery".tr, style: TextStyle(fontSize: 15, color: notifier.textcolore),),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(width: 13),
                                                                        Expanded(
                                                                          child: OutlinedButton(
                                                                            style: OutlinedButton.styleFrom(side: BorderSide(color: notifier.textcolore),fixedSize: const Size(100, 50), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
                                                                            onPressed: () {
                                                                              fundcamera().then((value) => {setState((){})});
                                                                              Get.back();
                                                                            },
                                                                            child:  Text("Camera".tr, style: TextStyle(fontSize: 15, color: notifier.textcolore),),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    const SizedBox(height: 15),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: Container(
                                                        width: 190,
                                                        padding: const EdgeInsets.all(10),
                                                        decoration: BoxDecoration(
                                                            border: Border.all(color: theamcolore),
                                                            borderRadius: BorderRadius.circular(10)
                                                        ),
                                                        child:  Center(child: Text('Upload Photos (Multiple)'.tr,style: TextStyle(color: notifier.textcolore),)),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10,),



                                                    SizedBox(
                                                      width: Get.width,
                                                      child: SingleChildScrollView(
                                                        scrollDirection: Axis.horizontal,
                                                        child: Row(
                                                          children: [
                                                            for(int a =0;a< fundDidWiseController.fundidimodel!.funddata[0].fundPhotos.length;a++) fundDidWiseController.fundidimodel!.funddata[0].fundPhotos[a] =="0" ? const SizedBox() : Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: Stack(
                                                                clipBehavior: Clip.none,
                                                                children: [
                                                                  Container(
                                                                    height: 150,
                                                                    width: 150,
                                                                    decoration: BoxDecoration(
                                                                        color: greaycolore,
                                                                        borderRadius: BorderRadius.circular(10),
                                                                    ),
                                                                    child: ClipRRect(
                                                                      borderRadius: BorderRadius.circular(10),
                                                                      child: FadeInImage.assetNetwork(
                                                                        placeholder: "assets/gfimage.png",
                                                                        placeholderCacheWidth: 290,
                                                                        placeholderCacheHeight: 270,
                                                                        image:
                                                                        Config.baseurl + fundDidWiseController.fundidimodel!.funddata[0].fundPhotos[a],
                                                                        fit: BoxFit.cover,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Positioned(
                                                                    right: -10,
                                                                    top: -8,
                                                                    child: GestureDetector(
                                                                      onTap: () {
                                                                        setState(() {
                                                                          fundDidWiseController.fundidimodel!.funddata[0].fundPhotos.removeAt(a);
                                                                        });
                                                                      },
                                                                      child: Container(
                                                                        height: 26,
                                                                        width: 26,
                                                                        decoration: const BoxDecoration(
                                                                          color: Colors.blue,
                                                                          shape: BoxShape.circle,
                                                                        ),
                                                                        child: const Center(child: Icon(Icons.close, color: Colors.white, size: 18,)),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),

                                                            for(int a =0; a<finalimage.length; a++) Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: Stack(
                                                                clipBehavior: Clip.none,
                                                                children: [
                                                                  Container(
                                                                    height: 150,
                                                                    width: 150,
                                                                    decoration: BoxDecoration(
                                                                        color: greaycolore,
                                                                        borderRadius: BorderRadius.circular(10),
                                                                        image: DecorationImage(image: FileImage(File(finalimage[a])),fit: BoxFit.fill)
                                                                    ),
                                                                  ),
                                                                  Positioned(
                                                                    right: -10,
                                                                    top: -8,
                                                                    child: GestureDetector(
                                                                      onTap: () {
                                                                        setState(() {
                                                                          finalimage.removeAt(a);
                                                                        });
                                                                      },
                                                                      child: Container(
                                                                        height: 26,
                                                                        width: 26,
                                                                        decoration: const BoxDecoration(
                                                                          color: Colors.blue,
                                                                          shape: BoxShape.circle,
                                                                        ),
                                                                        child: const Center(child: Icon(Icons.close, color: Colors.white, size: 18,)),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),

                                                    const SizedBox(height: 10,),
                                                    StatefulBuilder(builder: (context, setState) {
                                                      return Container(
                                                        height: 200,
                                                        width: MediaQuery.of(context).size.width,
                                                        decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius: BorderRadius.circular(15),
                                                        ),
                                                        child: ClipRRect(
                                                          borderRadius: BorderRadius.circular(15),
                                                          child: GoogleMap(
                                                            gestureRecognizers: {
                                                              Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer())
                                                            },
                                                            initialCameraPosition: CameraPosition(target: LatLng(double.parse(lat.toString()),double.parse(long.toString())), zoom: 13),
                                                            mapType: MapType.normal,
                                                            markers: Set<Marker>.of(markers),
                                                            onTap: (argument) {
                                                              setState((){
                                                                _onAddMarkerButtonPressed(argument.latitude, argument.longitude);
                                                                lat = argument.latitude;
                                                                long = argument.longitude;
                                                                print("******:--- ${argument.latitude}");
                                                                print("**lato****:--- $lat");
                                                                print("--------------------------------------");
                                                                print("++++++:--- ${argument.longitude}");
                                                                print("+++longo+++:--- $long");
                                                                print("hfgjhvhjwfvhjuyfvf:-=---  $address");
                                                              });
                                                            },
                                                            myLocationEnabled: false,
                                                            zoomGesturesEnabled: true,
                                                            tiltGesturesEnabled: true,
                                                            zoomControlsEnabled: true,
                                                            onMapCreated: (controller) {
                                                              setState(() {
                                                                mapController1 = controller;
                                                              });
                                                            },
                                                          ),
                                                        ),

                                                      );
                                                    },),
                                                    SizedBox(height: Get.height * 0.01),
                                                    StatefulBuilder(builder: (context, setState) {
                                                      return Container(
                                                        width: MediaQuery.of(context).size.width,
                                                        decoration: BoxDecoration(
                                                            color: notifier.background,
                                                            borderRadius: BorderRadius.circular(15),
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text("Location".tr,style: TextStyle(fontSize: 14,color: notifier.textcolore,fontWeight: FontWeight.bold),),
                                                              SizedBox(height: Get.height * 0.01),
                                                              GestButton(
                                                                  Width: Get.size.width,
                                                                  height: 50,
                                                                  buttoncolor: theamcolore,
                                                                  buttontext: "Put a point on the map".tr,
                                                                  style: const TextStyle(
                                                                    color: Colors.white,
                                                                    fontSize: 14,
                                                                    fontWeight: FontWeight.bold,
                                                                  ),
                                                                  onclick: () async {
                                                                    LocationPermission permission;
                                                                    permission = await Geolocator.checkPermission();
                                                                    permission = await Geolocator.requestPermission();
                                                                    if (permission == LocationPermission.denied) {}
                                                                    var currentLocation = await locateUser();
                                                                    debugPrint('location: ${currentLocation.latitude}');
                                                                    getCurrentLatAndLong(
                                                                      currentLocation.latitude,
                                                                      currentLocation.longitude,
                                                                    );
                                                                    _onAddMarkerButtonPressed(currentLocation.latitude, currentLocation.longitude);
                                                                    print("????????????${currentLocation.latitude}");
                                                                  }),
                                                              SizedBox(height: Get.height * 0.01),
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Expanded(
                                                                    child: Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        Container(
                                                                          height: 50,
                                                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                                          alignment: Alignment.center,
                                                                          decoration: BoxDecoration(
                                                                            color: greaycolore,
                                                                            borderRadius: BorderRadius.circular(15),
                                                                          ),
                                                                          child: Text(
                                                                            lat != null ? lat.toString() : "Latitude",
                                                                            maxLines: 1,
                                                                            style: const TextStyle(
                                                                              color: Colors.black,
                                                                              fontSize: 15,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  const SizedBox(width: 10,),
                                                                  Expanded(
                                                                    child: Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        Container(
                                                                          height: 50,
                                                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                                          alignment: Alignment.center,
                                                                          decoration: BoxDecoration(
                                                                            color: greaycolore,
                                                                            borderRadius: BorderRadius.circular(15),
                                                                          ),
                                                                          child: Text(
                                                                            long != null ? long.toString() : "Longitude",
                                                                            maxLines: 1,
                                                                            style: const TextStyle(
                                                                              color: Colors.black,
                                                                              fontSize: 15,
                                                                            ),
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
                                                    },),

                                                    InkWell(
                                                      onTap: () {
                                                        Get.bottomSheet(
                                                            StatefulBuilder(
                                                                builder: (context, setState)  {
                                                                  return  Container(
                                                                    height: 700,
                                                                    width: Get.width,
                                                                    decoration:  BoxDecoration(
                                                                        color: notifier.background,
                                                                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))
                                                                    ),
                                                                    child:  Padding(
                                                                      padding: const EdgeInsets.all(15),
                                                                      child: Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          Row(
                                                                            children: [
                                                                              InkWell(
                                                                                  onTap: () {
                                                                                    Get.back();
                                                                                  },
                                                                                  child:  Icon(Icons.close,color: notifier.textcolore,)),
                                                                              const Spacer(),
                                                                              Text('Select a category'.tr,style: TextStyle(color: notifier.textcolore,fontFamily: "SofiaProBold",fontSize: 18),),
                                                                              const Spacer(),
                                                                            ],
                                                                          ),
                                                                          const SizedBox(height: 30,),
                                                                          Text('Pick the category that best represents your fundraiser.'.tr,style: TextStyle(fontSize: 16,color: Colors.grey),maxLines: 2,overflow: TextOverflow.ellipsis,),
                                                                          const SizedBox(height: 30,),
                                                                          Wrap(
                                                                            spacing: 13,
                                                                            runSpacing: 13,
                                                                            alignment: WrapAlignment.start,
                                                                            clipBehavior: Clip.none,
                                                                            crossAxisAlignment: WrapCrossAlignment.start,
                                                                            runAlignment: WrapAlignment.start,
                                                                            children: [
                                                                              for (int a = 0; a < homeApiController.homeapimodel!.category.length; a++)
                                                                                Builder(builder: (context) {
                                                                                  return InkWell(
                                                                                    onTap: () {
                                                                                      setState(() {
                                                                                        emapty = homeApiController.homeapimodel!.category[a].id;
                                                                                        emapty1 = homeApiController.homeapimodel!.category[a].title;
                                                                                        titlexyz = homeApiController.homeapimodel!.category[a].title;
                                                                                        print(" + + + +  + + + $emapty");
                                                                                      });
                                                                                      Get.back();
                                                                                    },
                                                                                    child: Container(
                                                                                      height: 40,
                                                                                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                                                                                      decoration: BoxDecoration(
                                                                                          color: titlexyz == homeApiController.homeapimodel!.category[a].title ?  theamcolore : notifier.background,
                                                                                          borderRadius: BorderRadius.circular(18),
                                                                                          border: Border.all(color: Colors.grey.withOpacity(0.4))),
                                                                                      child: Row(
                                                                                        mainAxisSize: MainAxisSize.min,
                                                                                        children: [
                                                                                          Text(homeApiController.homeapimodel!.category[a].title.toString(),style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 15,color: emapty == homeApiController.homeapimodel!.category[a].id ?  Colors.white : notifier.textcolore)),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  );
                                                                                })
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  );
                                                                }
                                                            ),
                                                            isScrollControlled: true
                                                        ).then((value) {
                                                          setState(() {
                                                          });
                                                        });
                                                      },
                                                      child: ListTile(
                                                        contentPadding: EdgeInsets.zero,
                                                        leading: const Padding(
                                                          padding: EdgeInsets.only(top: 12),
                                                          child: Image(image: AssetImage('assets/categoryicon.png'),height: 25,width: 25),
                                                        ),
                                                        title: Transform.translate(
                                                            offset: const Offset(-20, 0),
                                                            child:   Text('Creative'.tr,style: TextStyle(color: notifier.textcolore,fontSize: 16,fontWeight: FontWeight.bold),)
                                                        ),
                                                        subtitle: Transform.translate(
                                                            offset: const Offset(-20, 0),
                                                            child: titlexyz.isEmpty ?  Text('Business'.tr,style: TextStyle(color: notifier.textcolore,fontSize: 14)): Text(titlexyz,style: TextStyle(color: notifier.textcolore,fontSize: 14))
                                                        ),
                                                        trailing: const Icon(Icons.arrow_forward_ios,color: Colors.grey,size: 16),
                                                      ),
                                                    ),

                                                    const SizedBox(height: 10,),
                                                    DropdownButtonFormField(
                                                      validator: (value) {
                                                        if(value == null){
                                                          return 'Choose your Customer';
                                                        }
                                                        return null;
                                                      },
                                                      decoration: InputDecoration(
                                                        contentPadding: const EdgeInsets.all(12),
                                                        hintStyle: TextStyle(fontSize: 14,color: notifier.textcolore),
                                                        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.withOpacity(0.4)),borderRadius: BorderRadius.circular(10)),
                                                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.withOpacity(0.4)),borderRadius: BorderRadius.circular(10)),
                                                        disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.withOpacity(0.4)),borderRadius: BorderRadius.circular(10)),
                                                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: theamcolore),borderRadius: BorderRadius.circular(10)),
                                                      ),
                                                      hint: Text(fundDidWiseController.fundidimodel!.funddata[0].status == "0" ? "Publish" : "Unpublish",style: TextStyle(fontSize: 14,color: notifier.textcolore),),
                                                      dropdownColor: notifier.containercolore,
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          sender = newValue;
                                                          print(' + + + +$newValue');
                                                        });
                                                      },
                                                      value: sender,
                                                      items: list.map<DropdownMenuItem>((item) {
                                                        return DropdownMenuItem(
                                                          value: item,
                                                          child: Text(item,style: TextStyle(color: notifier.textcolore)),
                                                        );

                                                      }).toList(),
                                                    ),
                                                    const SizedBox(height: 10,),

                                                    Container(
                                                      decoration: BoxDecoration(
                                                          border: Border.all(color: Colors.grey.withOpacity(0.4)),
                                                          borderRadius: BorderRadius.circular(10)
                                                      ),
                                                      child: ListTileTheme(
                                                        contentPadding: EdgeInsets.zero,
                                                        minVerticalPadding: 0,
                                                        dense: true,
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                                          child: ExpansionTile(
                                                            textColor: theamcolore,
                                                            tilePadding: EdgeInsets.zero,
                                                            childrenPadding: EdgeInsets.zero,
                                                            expandedCrossAxisAlignment: CrossAxisAlignment.start,
                                                            title: Text('Found For'.tr,style: TextStyle(color: notifier.textcolore)),
                                                            children: <Widget>[
                                                              ListView.separated(
                                                                  separatorBuilder: (context, index) {
                                                                    return const SizedBox(height: 10);
                                                                  },
                                                                  shrinkWrap: true,
                                                                  scrollDirection: Axis.vertical,
                                                                  physics: const NeverScrollableScrollPhysics(),
                                                                  itemCount: 3,
                                                                  itemBuilder: (BuildContext context, int index) {
                                                                    return InkWell(
                                                                      onTap: () {
                                                                        setState(() {
                                                                          select = index;
                                                                        });
                                                                      },
                                                                      child: Container(
                                                                        height: 40,
                                                                        width: Get.width,
                                                                        margin: const EdgeInsets.only(bottom: 5),
                                                                        decoration: BoxDecoration(
                                                                          color: notifier.containercolore,
                                                                          border: Border.all(color: select == index ? theamcolore : Colors.grey.withOpacity(0.4),width: 1),
                                                                          borderRadius: BorderRadius.circular(10),
                                                                        ),
                                                                        child: Padding(
                                                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                                                          child: Column(
                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                            children: [
                                                                              Text('${listtiletitle[index]}',style:  TextStyle(color: notifier.textcolore,fontFamily: "SofiaProBold",fontSize: 14)),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10,),



                                                    const SizedBox(height: 10,),
                                                    Text('Upload Medical Certificate or Other Documentation'.tr,style: TextStyle(color: notifier.textcolore,fontSize: 14,fontWeight: FontWeight.bold),),
                                                    const SizedBox(height: 10,),
                                                    InkWell(
                                                      onTap: () {
                                                        showModalBottomSheet(
                                                          backgroundColor: notifier.containercolore,
                                                          isDismissible: false,
                                                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(13))),
                                                          context: context,
                                                          builder: (context) {
                                                            return SingleChildScrollView(
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(10),
                                                                child: Column(
                                                                  children: [
                                                                    Text("From where do you want to take the photo?".tr, style: TextStyle(fontSize: 20, color: notifier.textcolore),),
                                                                    const SizedBox(height: 15),
                                                                    Row(
                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                      children: [
                                                                        Expanded(
                                                                          child: OutlinedButton(
                                                                            style: OutlinedButton.styleFrom(side: BorderSide(color: notifier.textcolore),fixedSize: const Size(100, 50), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
                                                                            onPressed: () {
                                                                              certificationgallery().then((value) => {setState((){})});
                                                                              Get.back();
                                                                            },
                                                                            child:  Text("Gallery".tr, style: TextStyle( fontSize: 15, color: notifier.textcolore),),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(width: 13),
                                                                        Expanded(
                                                                          child: OutlinedButton(
                                                                            style: OutlinedButton.styleFrom(side: BorderSide(color: notifier.textcolore),fixedSize: const Size(100, 50), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
                                                                            onPressed: ()  {
                                                                              certificationcamera().then((value) => {setState((){})});
                                                                              Get.back();
                                                                            },
                                                                            child:  Text("Camera".tr, style: TextStyle(fontSize: 15, color: notifier.textcolore),),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    const SizedBox(height: 15),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: Container(
                                                        width: 190,
                                                        padding: const EdgeInsets.all(10),
                                                        decoration: BoxDecoration(
                                                            border: Border.all(color: theamcolore),
                                                            borderRadius: BorderRadius.circular(10)
                                                        ),
                                                        child:  Center(child: Text('Upload Photos (Multiple)'.tr,style: TextStyle(color: notifier.textcolore),)),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10,),



                                                    SizedBox(
                                                      width: Get.width,
                                                      child: SingleChildScrollView(
                                                        scrollDirection: Axis.horizontal,
                                                        child: Row(
                                                          children: [
                                                            for(int a =0;a< fundDidWiseController.fundidimodel!.funddata[0].medicalCertificate.length;a++) fundDidWiseController.fundidimodel!.funddata[0].medicalCertificate[a] =="0" ? const SizedBox() : Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: Stack(
                                                                clipBehavior: Clip.none,
                                                                children: [
                                                                  Container(
                                                                    height: 150,
                                                                    width: 150,
                                                                    decoration: BoxDecoration(
                                                                        color: greaycolore,
                                                                        borderRadius: BorderRadius.circular(10),
                                                                    ),
                                                                    child: ClipRRect(
                                                                      borderRadius: BorderRadius.circular(10),
                                                                      child: FadeInImage.assetNetwork(
                                                                        placeholder: "assets/gfimage.png",
                                                                        placeholderCacheWidth: 290,
                                                                        placeholderCacheHeight: 270,
                                                                        image:
                                                                        Config.baseurl + fundDidWiseController.fundidimodel!.funddata[0].medicalCertificate[a],
                                                                        fit: BoxFit.cover,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Positioned(
                                                                    right: -10,
                                                                    top: -8,
                                                                    child: GestureDetector(
                                                                      onTap: () {
                                                                        setState(() {
                                                                          fundDidWiseController.fundidimodel!.funddata[0].medicalCertificate.removeAt(a);
                                                                        });
                                                                      },
                                                                      child: Container(
                                                                        height: 26,
                                                                        width: 26,
                                                                        decoration: const BoxDecoration(
                                                                          color: Colors.blue,
                                                                          shape: BoxShape.circle,
                                                                        ),
                                                                        child: const Center(child: Icon(Icons.close, color: Colors.white, size: 18,)),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),

                                                            for(int a =0; a<image.length; a++) Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: Stack(
                                                                clipBehavior: Clip.none,
                                                                children: [
                                                                  Container(
                                                                    height: 150,
                                                                    width: 150,
                                                                    decoration: BoxDecoration(
                                                                        color: greaycolore,
                                                                        borderRadius: BorderRadius.circular(10),
                                                                        image: DecorationImage(image: FileImage(File(image[a])),fit: BoxFit.fill)
                                                                    ),
                                                                  ),
                                                                  Positioned(
                                                                    right: -10,
                                                                    top: -8,
                                                                    child: GestureDetector(
                                                                      onTap: () {
                                                                        setState(() {
                                                                          image.removeAt(a);
                                                                        });
                                                                      },
                                                                      child: Container(
                                                                        height: 26,
                                                                        width: 26,
                                                                        decoration: const BoxDecoration(
                                                                          color: Colors.blue,
                                                                          shape: BoxShape.circle,
                                                                        ),
                                                                        child: const Center(child: Icon(Icons.close, color: Colors.white, size: 18,)),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 20,),



                                                    Text('Fundraiser Title'.tr,style: TextStyle(color: notifier.textcolore,fontSize: 14,fontWeight: FontWeight.bold)),
                                                    const SizedBox(height: 10,),
                                                    CommonTextfiled200(txt: fundDidWiseController.fundidimodel!.funddata[0].title,context: context,controller: titlecontroller),

                                                    const SizedBox(height: 10,),
                                                    Text('Fund Amount'.tr,style: TextStyle(color: notifier.textcolore,fontSize: 14,fontWeight: FontWeight.bold)),
                                                    const SizedBox(height: 10,),
                                                    CommonTextfiled200(txt: fundDidWiseController.fundidimodel!.funddata[0].fundAmt,context: context,controller: fundamountcontroller),


                                                    const SizedBox(height: 10,),
                                                    Text('Fund Description'.tr,style: TextStyle(color: notifier.textcolore,fontSize: 14,fontWeight: FontWeight.bold)),
                                                    const SizedBox(height: 10,),
                                                    ConstrainedBox(
                                                      constraints: const BoxConstraints(
                                                        maxHeight: 300
                                                      ),
                                                      child: TextField(
                                                        controller: storycontroller,
                                                        maxLines: null,
                                                        style: TextStyle(color: notifier.textcolore),
                                                        decoration: InputDecoration(
                                                          contentPadding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                                                          border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)),borderSide: BorderSide(color: Colors.red)),
                                                          enabledBorder:  OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(10)),borderSide: BorderSide(color: Colors.grey.withOpacity(0.4))),
                                                          hintText: fundDidWiseController.fundidimodel!.funddata[0].fundStory.replaceAll("\\n", "\n"),hintStyle:  const TextStyle(color: Colors.grey,fontFamily: "SofiaProBold",fontSize: 14),
                                                          // hintText: fundDidWiseController.fundidimodel!.funddata[0].fundStory,hintStyle:  const TextStyle(color: Colors.grey,fontFamily: "SofiaProBold",fontSize: 14),
                                                          focusedBorder:  OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(10)),borderSide: BorderSide(color: theamcolore)),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10,),
                                                    Text('Select Fund Expiration Date'.tr,style: TextStyle(color: notifier.textcolore,fontSize: 14,fontWeight: FontWeight.bold),),
                                                    const SizedBox(height: 10,),
                                                    InkWell(
                                                      onTap: () => selectDateAndTime(context),
                                                      child: Container(
                                                        height: 45,
                                                        width: Get.width,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(color: Colors.grey.withOpacity(0.4)),
                                                            borderRadius: BorderRadius.circular(10)
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Row(
                                                            children: [
                                                              Text(selectedDateAndTime.toString().split(" ").first,style: TextStyle(color: notifier.textcolore),),
                                                              const Spacer(),
                                                              GestureDetector(
                                                                  onTap: () => selectDateAndTime(context),
                                                                  child: Icon(Icons.calendar_month,size: 26,color: theamcolore)),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10,),
                                                    Text('Fund Plan'.tr,style: TextStyle(color: notifier.textcolore,fontSize: 14,fontWeight: FontWeight.bold)),
                                                    const SizedBox(height: 10,),
                                                    ConstrainedBox(
                                                      constraints: const BoxConstraints(
                                                          maxHeight: 300
                                                      ),
                                                      child: TextField(
                                                        controller: fundplancontroller,
                                                        maxLines: null,
                                                        style: TextStyle(color: notifier.textcolore),
                                                        decoration: InputDecoration(
                                                          contentPadding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                                                          border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)),borderSide: BorderSide(color: Colors.red)),
                                                          enabledBorder:  OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(10)),borderSide: BorderSide(color: Colors.grey.withOpacity(0.4))),
                                                          hintText: fundDidWiseController.fundidimodel!.funddata[0].fundPlan.replaceAll("\\n", "\n"),hintStyle:  const TextStyle(color: Colors.grey,fontFamily: "SofiaProBold",fontSize: 14),
                                                          focusedBorder:  OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(10)),borderSide: BorderSide(color: theamcolore)),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },),
                                      );
                                    }
                                ),
                                isScrollControlled: true
                            ) :  selectPageIndex == 1 ? Get.bottomSheet(
                                StatefulBuilder(
                                    builder: (context, setState)  {
                                      return Scaffold(
                                        resizeToAvoidBottomInset: false,
                                        backgroundColor: notifier.background,
                                        appBar: AppBar(
                                          elevation: 0,
                                          toolbarHeight: 90,
                                          backgroundColor: notifier.background,
                                          leading: InkWell(
                                            onTap: () {
                                              Get.back();
                                              markers.clear();
                                            },
                                            child:  Padding(
                                              padding: const EdgeInsets.only(top: 50),
                                              child: Icon(Icons.close,color: notifier.textcolore),
                                            ),
                                          ),
                                          title: Padding(
                                            padding: const EdgeInsets.only(top: 50),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Transform.translate(offset: const Offset(-15, 0),child :  Text('${fundDidWiseController.fundidimodel!.funddata[0].title}',style: TextStyle(color: notifier.textcolore,fontSize: 16,fontFamily: "SofiaProBold"),overflow: TextOverflow.ellipsis,)),
                                                const SizedBox(height: 5,),
                                                Transform.translate(offset: const Offset(-15, 0),child: Text('${currency1}${double.parse(fundDidWiseController.fundidimodel!.funddata[0].totalInvestment.toString()).toStringAsFixed(2)} raised of ${currency1}${double.parse(fundDidWiseController.fundidimodel!.funddata[0].remainAmt.toString()).toStringAsFixed(2)}',style: TextStyle(color: Colors.grey,fontSize: 12)))
                                              ],
                                            ),
                                          ),
                                        ),
                                        body: StatefulBuilder(builder: (context, setState) {
                                          return Container(
                                            height: Get.height,
                                            width: Get.width,
                                            decoration:  BoxDecoration(
                                                color: notifier.background,
                                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
                                            ),
                                            child: SingleChildScrollView(
                                              child: Padding(
                                                padding: const EdgeInsets.all(15),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Donaters (${fundDidWiseController.fundidimodel!.funddata[0].donaterlist.length})',style: TextStyle(color: notifier.textcolore,fontSize: 18,fontFamily: "SofiaProBold"),),
                                                    const SizedBox(height: 10,),
                                                    SizedBox(
                                                      height: Get.height,
                                                      width: Get.width,
                                                      child: ListView.separated(
                                                        physics: const NeverScrollableScrollPhysics(),
                                                        itemCount: fundDidWiseController.fundidimodel!.funddata[0].donaterlist.length,
                                                        scrollDirection: Axis.vertical,
                                                        separatorBuilder: (context, index) {
                                                          return const SizedBox(width: 10,);
                                                        },
                                                        itemBuilder: (context, index) {
                                                          return ListTile(
                                                            contentPadding: EdgeInsets.zero,
                                                            leading: Container(
                                                              height: 40,
                                                              width: 40,
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(65),
                                                                  image: fundDidWiseController.fundidimodel!.funddata[0].donaterlist[index].profilePic == null ? const DecorationImage(image: AssetImage("")) :  DecorationImage(image: NetworkImage(Config.baseurl + fundDidWiseController.fundidimodel!.funddata[0].donaterlist[index].profilePic),fit: BoxFit.cover)
                                                              ),
                                                            ),
                                                            title: Transform.translate(offset: const Offset(-5, 0),child :  Text('${ fundDidWiseController.fundidimodel!.funddata[0].donaterlist[index].name == null ? "" :   fundDidWiseController.fundidimodel!.funddata[0].donaterlist[index].name}',style: TextStyle(color: notifier.textcolore,fontSize: 16,fontFamily: "SofiaProBold"),overflow: TextOverflow.ellipsis,)),
                                                            subtitle: Transform.translate(offset: const Offset(-5, 0),child:  Text('$currency1 ${fundDidWiseController.fundidimodel!.funddata[0].donaterlist[index].amt}',style: const TextStyle(color: Colors.grey,fontSize: 12))),
                                                          );
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },),
                                      );
                                    }
                                ),
                                isScrollControlled: true
                            ) : selectPageIndex == 2 ? Get.bottomSheet(
                                StatefulBuilder(
                                    builder: (context, setState) {
                                      return DefaultTabController(
                                        length: 2,
                                        child: Scaffold(
                                          resizeToAvoidBottomInset: false,
                                          bottomNavigationBar: menu(),
                                          backgroundColor: notifier.background,
                                          appBar: AppBar(
                                            toolbarHeight: 80,
                                            elevation: 0,
                                            backgroundColor: notifier.background,
                                            leading: Padding(
                                              padding: const EdgeInsets.only(top: 45),
                                              child: InkWell(
                                                onTap: () {
                                                  Get.back();
                                                },
                                                child: Icon(Icons.close,color: notifier.textcolore,),
                                              ),
                                            ),
                                            title:  Padding(
                                              padding: const EdgeInsets.only(top: 45),
                                              child: Text('New Update'.tr,style: TextStyle(fontSize: 18,color: notifier.textcolore),),
                                            ),
                                            actions: [
                                              Padding(
                                                padding: const EdgeInsets.only(top: 55,right: 10),
                                                child: InkWell(
                                                    onTap: () {
                                                      setState((){
                                                        tab == 0 ?

                                                        (fundupdateimage.isEmpty && photoscreencontroller.text.isEmpty)  ? Fluttertoast.showToast(msg: "Please Fill Data") :   fundupdateApiController.funupdateapi(fund_id: widget.id, description: photoscreencontroller.text, uid: userdata['id'], size: "${fundupdateimage.length}").then((value) {
                                                          Get.back();
                                                          homeController.setselectpage(2);
                                                          Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  const Bottom_Navigation(),));
                                                        },)

                                                            :

                                                        textscreencontroller.text.isEmpty ? Fluttertoast.showToast(msg: "Please Fill Data")  :  fundupdateApiController.funupdateapi(fund_id: widget.id, description: textscreencontroller.text, uid: userdata['id'], size: "0").then((value) {
                                                          Get.back();
                                                          homeController.setselectpage(2);
                                                          Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  const Bottom_Navigation(),));
                                                        },);


                                                      });
                                                    },
                                                    child:  Text('Done'.tr,style: TextStyle(fontSize: 16,color: notifier.textcolore,fontFamily: "SofiaProBold"),)),
                                              ),
                                            ],
                                          ),
                                          body: Container(
                                            height: Get.height,
                                            width: Get.width,
                                            decoration:  BoxDecoration(
                                                color: notifier.background,
                                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
                                            ),
                                            child: SingleChildScrollView(
                                              physics: const NeverScrollableScrollPhysics(),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(height: 5,),
                                                   Padding(
                                                    padding: const EdgeInsets.all(15),
                                                    child: Text('Share a new progress update about your beneficiary (include image, text, or text only)'.tr,style: TextStyle(color: notifier.textcolore,fontSize: 16),overflow: TextOverflow.ellipsis,maxLines: 2,),
                                                  ),
                                                  const SizedBox(height: 5,),
                                                  SizedBox(
                                                    height: Get.height,
                                                    child: Column(
                                                      children: [
                                                        const SizedBox(height: 5,),
                                                        Expanded(
                                                          child: TabBarView(
                                                            physics: const NeverScrollableScrollPhysics(),
                                                            children: <Widget>[
                                                              Padding(
                                                                padding: const EdgeInsets.only(left: 15,right: 15),
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    InkWell(
                                                                      onTap: () {
                                                                        showModalBottomSheet(
                                                                          backgroundColor: notifier.containercolore,
                                                                          isDismissible: false,
                                                                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(13))),
                                                                          context: context,
                                                                          builder: (context) {
                                                                            return SingleChildScrollView(
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(10),
                                                                                child: Column(
                                                                                  children: [
                                                                                     Text("From where do you want to take the photo?".tr, style: TextStyle(fontSize: 20, color: notifier.textcolore),),
                                                                                    const SizedBox(height: 15),
                                                                                    Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        Expanded(
                                                                                          child: OutlinedButton(
                                                                                            style: OutlinedButton.styleFrom(side: BorderSide(color: notifier.textcolore),fixedSize: const Size(100, 50), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
                                                                                            onPressed: () {
                                                                                              fundupdategallery().then((value) => {setState((){})});
                                                                                              Get.back();
                                                                                            },
                                                                                            child:  Text("Gallery".tr, style: TextStyle( fontSize: 15, color: notifier.textcolore),),
                                                                                          ),
                                                                                        ),
                                                                                        const SizedBox(width: 13),
                                                                                        Expanded(
                                                                                          child: OutlinedButton(
                                                                                            style: OutlinedButton.styleFrom(side: BorderSide(color: notifier.textcolore),fixedSize: const Size(100, 50), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
                                                                                            onPressed: ()  {
                                                                                              fundupdatecamera().then((value) => {setState((){})});
                                                                                              Get.back();
                                                                                            },
                                                                                            child:  Text("Camera".tr, style: TextStyle(fontSize: 15, color: notifier.textcolore),),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    const SizedBox(height: 15),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            );
                                                                          },
                                                                        );
                                                                      },
                                                                      child: Container(
                                                                        width: 190,
                                                                        padding: const EdgeInsets.all(10),
                                                                        decoration: BoxDecoration(
                                                                            border: Border.all(color: theamcolore),
                                                                            borderRadius: BorderRadius.circular(10)
                                                                        ),
                                                                        child:  Center(child: Text('Upload Photos (Multiple)'.tr,style: TextStyle(color: notifier.textcolore),)),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(height: 10,),
                                                                    fundupdateimage.isEmpty ? const SizedBox() : SizedBox(
                                                                      height:  170,
                                                                      child: ListView.builder(
                                                                        clipBehavior: Clip.none,
                                                                        shrinkWrap: true,
                                                                        scrollDirection: Axis.horizontal,
                                                                        padding: const EdgeInsets.only(bottom: 10),
                                                                        itemCount: fundupdateimage.length,
                                                                        itemBuilder: (context, index) {
                                                                          return Stack(
                                                                            clipBehavior: Clip.none,
                                                                            children: [
                                                                              Container(
                                                                                height: 300,
                                                                                width: 150,
                                                                                margin: const EdgeInsets.only(right: 15),
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(10),
                                                                                  image: DecorationImage(image: FileImage(File(fundupdateimage[index])),fit: BoxFit.cover),
                                                                                ),
                                                                              ),
                                                                              Positioned(
                                                                                right: 5,
                                                                                top: -8,
                                                                                child: GestureDetector(
                                                                                  onTap: () {
                                                                                    setState(() {
                                                                                      fundupdateimage.removeAt(index);
                                                                                    });
                                                                                  },
                                                                                  child: Container(
                                                                                    height: 26,
                                                                                    width: 26,
                                                                                    decoration: BoxDecoration(
                                                                                      color: theamcolore,
                                                                                      shape: BoxShape.circle,
                                                                                    ),
                                                                                    child: const Center(child: Icon(Icons.close, color: Colors.white, size: 18,)),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          );
                                                                        },),
                                                                    ),
                                                                    const SizedBox(height: 20),
                                                                    TextFormField(
                                                                      style: TextStyle(color: notifier.textcolore),
                                                                      controller: photoscreencontroller,
                                                                      maxLines: 8,
                                                                      decoration: InputDecoration(
                                                                        contentPadding: const EdgeInsets.all(8),
                                                                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.withOpacity(0.4)),borderRadius: BorderRadius.circular(10)),
                                                                        disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.withOpacity(0.4)),borderRadius: BorderRadius.circular(10)),
                                                                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: theamcolore),borderRadius: BorderRadius.circular(10)),
                                                                        hintText: "Include specific details about the improvement or progress, such as medical milestones, personal achievements, or any other noteworthy updates".tr,
                                                                        hintStyle:  TextStyle(color: Colors.grey,fontSize: 16),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),

                                                              Padding(
                                                                padding: const EdgeInsets.only(left: 15,right: 15),
                                                                child: Column(
                                                                   crossAxisAlignment: CrossAxisAlignment.start,
                                                                   children: [
                                                                      Text('Story'.tr,style: TextStyle(color: notifier.textcolore,fontSize: 16,fontFamily: "SofiaProBold")),
                                                                     const SizedBox(height: 10),
                                                                     TextFormField(
                                                                       controller: textscreencontroller,
                                                                       style: TextStyle(color: notifier.textcolore),
                                                                       maxLines: 20,
                                                                       decoration: InputDecoration(
                                                                         contentPadding: const EdgeInsets.all(8),
                                                                         enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.withOpacity(0.4)),borderRadius: BorderRadius.circular(10)),
                                                                         disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.withOpacity(0.4)),borderRadius: BorderRadius.circular(10)),
                                                                         focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: theamcolore),borderRadius: BorderRadius.circular(10)),
                                                                         hintText: "Include specific details about the improvement or progress, such as medical milestones, personal achievements, or any other noteworthy updates".tr,
                                                                         hintStyle:  const TextStyle(color: Colors.grey,fontSize: 16),
                                                                       ),
                                                                     ),
                                                                     const SizedBox(height: 13),
                                                                   ],
                                                                 ),
                                                              ),

                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                ),
                                isScrollControlled: true
                            ).then((value) {
                            }) : const SizedBox();

                            selectPageIndex = -1;

                          },
                          child: SizedBox(
                            width: Get.width* 0.25,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  imagelist[index],
                                  width: 22,
                                  height: 22,
                                  color: selectPageIndex == index ? theamcolore : Colors.white,
                                ),
                                const SizedBox(height: 3),
                                Flexible(
                                    child: Text(
                                        textlist[index].toString(),
                                        style: TextStyle(
                                            fontSize: 12,
                                            color:
                                            selectPageIndex == index
                                                ? theamcolore
                                                : Colors.white,
                                            fontWeight: FontWeight.w400
                                        ),
                                        overflow: TextOverflow.ellipsis
                                    ),
                                ),
                              ],
                            ),
                          ));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body:  Your_Funder_Screen(id: widget.id,isComplete: widget.isComplete),
    );
  }



  Widget menu(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TabBar(

        // controller: _tabController,
        onTap: (value) {
          setState(() {
            tab = value;
            print(" + + + + + + + $tab");
          });

        },
        indicatorColor: theamcolore,
        physics: const NeverScrollableScrollPhysics(),
        labelColor: Colors.black,
        indicatorSize: TabBarIndicatorSize.label,
        dividerColor: Colors.transparent,
        tabs:  <Widget>[
          Tab(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Photo'.tr,style: TextStyle(color: notifier.textcolore,fontSize: 15,fontFamily: "SofiaProBold"),),
            ],
          )),
          Tab(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Text'.tr,style: TextStyle(color: notifier.textcolore,fontSize: 15,fontFamily: "SofiaProBold"),),
            ],
          )),
        ],
      ),
    );
  }



  void _getPincode(double latitude, double longitude) async {

    try {
      List<Placemark> placemarks =
      await placemarkFromCoordinates(latitude, longitude);
      if (placemarks != null && placemarks.isNotEmpty) {
        setState(() {
          pincode = placemarks[0].postalCode ?? 'Pincode not found';
        });
        print("+ + + + + + :--------$pincode");
      } else {
        setState(() {
          pincode = 'Pincode not found';
        });
      }
    } catch (e) {
      setState(() {
        pincode = 'Error: $e';
      });
    }
  }



  Future<void> selectDateAndTime(context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateAndTime,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme:  ColorScheme.light(
              primary: theamcolore,
              onPrimary: Colors.white,
              onSurface: theamcolore,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    print(pickedDate);
    if (pickedDate != null && pickedDate != selectedDateAndTime) {
      setState(() {
        selectedDateAndTime = pickedDate;
      });
    }
  }

}




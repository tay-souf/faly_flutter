// ignore_for_file: camel_case_types, avoid_print, unnecessary_brace_in_string_interps, unnecessary_string_interpolations, prefer_typing_uninitialized_variables, prefer_interpolation_to_compose_strings, prefer_collection_literals, unused_element, unnecessary_null_comparison

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/directions.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bootom_navigation_screen/home_screen.dart';
import '../common/common_button.dart';
import '../common/light_dark_mode.dart';
import '../controller/login_controller.dart';
import 'describe_fundraising.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

String pincode = '';
String emapty = '';
String emapty1 = '';

TextEditingController fundamountcontroller = TextEditingController();


var lat;
var long;
var address;

class Fundraiser_details extends StatefulWidget {
  const Fundraiser_details({super.key});

  @override
  State<Fundraiser_details> createState() => _Fundraiser_detailsState();
}

class _Fundraiser_detailsState extends State<Fundraiser_details> {

  int selectindex = 1;

  String description = 'Enter your text'.tr;
  TextEditingController controller = TextEditingController();
  TextEditingController locationcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      print(controller.text);
    });

    datagetfunction();

    setState(() {
      fun().then((value) {
        setState(() {
        });
        getCurrentLatAndLong(lat, long);
      },);
    });

  }

  String googleApikey = "AIzaSyCRF9Q1ttrleh04hqRlP_CqsFCPU815jJk";
  GoogleMapController? mapController; // contrller for Google map
  CameraPosition? cameraPosition;
  LatLng startLocation = const LatLng(27.6602292, 85.308027);
  String location = "Search for your postcode".tr;

  HomeApiController homeApiController = Get.put(HomeApiController());

  var userdata;
  var currency1;

  datagetfunction() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var uid = preferences.getString("userLogin");
    var curr =  preferences.getString("currenci");
    userdata = jsonDecode(uid!);
    currency1 = jsonDecode(curr!);

    homeApiController.homeApi(uid: userdata['id'],latitude: lathome.toString(),logitude: longhome.toString());
    fun();
    print('+ + + + + + + + ${userdata['id']}');
    setState(() {

    });
  }



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
        // icon: BitmapDescriptor.defaultMarker,
        icon: BitmapDescriptor.fromBytes(markIcon),
      ));
      setState(() {

      });
  }



  getCurrentLatAndLong(double latitude, double longitude) async {

    lat = latitude;
    long = longitude;

    await placemarkFromCoordinates(lat, long).then((List<Placemark> placemarks) {
      address = '${placemarks.first.name}, ${placemarks.first.locality}, ${placemarks.first.country}';
      print("FIRST USER CURRENT LOCATION : --${address}");
    });

  }



 Future fun() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {}
    var currentLocation = await locateUser();
    debugPrint('location: ${currentLocation.latitude}');
    _onAddMarkerButtonPressed(currentLocation.latitude, currentLocation.longitude);
    getCurrentLatAndLong(
      currentLocation.latitude,
      currentLocation.longitude,
    );
    print("????????????" + currentLocation.longitude.toString());
    print("SECOND USER CURRENT LOCATION : --  ${address}");

  }

  Future<Position> locateUser() async {
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high
    );
  }

  ColorNotifier notifier = ColorNotifier();
  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return Scaffold(
      backgroundColor: notifier.background,
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 70,
            width: MediaQuery.of(context).size.width,
            decoration:  BoxDecoration(
                color: notifier.background,
                borderRadius: const BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10))
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      (fundamountcontroller.text.isNotEmpty && emapty.isNotEmpty) ?
                        NextButton(containcolore: theamcolore, onPressed1: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const Describe_Fundraisinf(),));
                        },) :
                      NextButtonNon(onPressed1: () {},)
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: Get.height,
                  width: Get.width,
                  color: notifier.containercolore,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 40,),
                        Row(
                          children: [
                            InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child:  Icon(Icons.arrow_back,color: notifier.textcolore,size: 20)),
                            const Spacer(),
                            Text('Your fundraisers'.tr,style: TextStyle(color: notifier.textcolore,fontFamily: "SofiaProBold",fontSize: 18)),
                            const Spacer(),
                          ],
                        ),
                        const SizedBox(height: 30,),
                        Text("Let's Begin Your".tr,style: TextStyle(color: notifier.textcolore,fontFamily: "SofiaProBold",fontSize: 22),),
                        const SizedBox(height: 5,),
                        Text('Fundraising Journey'.tr,style: TextStyle(color: notifier.textcolore,fontFamily: "SofiaProBold",fontSize: 22),),
                      ],
                    ),
                  ),
                ),
                Container(
                    height: Get.height * 0.78,
                    width: Get.width,
                    decoration: BoxDecoration(
                        // color: notifier.background,
                        color: notifier.background,
                        borderRadius: const BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
                    ),
                    child: SingleChildScrollView(
                      // physics: NeverScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Step 1 of 4'.tr,style: const TextStyle(color: Colors.grey,fontSize: 14,fontFamily: "SofiaProBold"),),
                            const SizedBox(height: 5,),
                            Text('Fundraiser details'.tr,style: TextStyle(fontFamily: "SofiaProBold",fontSize: 22,color: notifier.textcolore),),
                            const SizedBox(height: 20,),
                            Text('How much would you like to raise?'.tr,style: TextStyle(fontSize: 16,color: notifier.textcolore,fontWeight: FontWeight.bold),maxLines: 2,overflow: TextOverflow.ellipsis,),
                            const SizedBox(height: 10,),
                            Container(
                              height: 50,
                              child: TextFormField(
                                controller: fundamountcontroller,
                                style:  TextStyle(fontSize: 16,color: notifier.textcolore),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  focusColor: Colors.red,
                                  border: InputBorder.none,
                                  hintStyle:  TextStyle(fontSize: 16,color: Colors.grey),
                                  hintText: '${currency1} Your starting goal',
                                  suffixIcon:  Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Text('    ${currency1}',style: TextStyle(color: Colors.grey)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey.withOpacity(0.4)),
                                      borderRadius: const BorderRadius.all(Radius.circular(14))
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: theamcolore,width: 2),
                                      borderRadius: const BorderRadius.all(Radius.circular(14))
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Text('What kind of fundraiser are you creating?'.tr,style: TextStyle(fontSize: 16,color: notifier.textcolore,fontWeight: FontWeight.bold),maxLines: 2,overflow: TextOverflow.ellipsis,),
                            const SizedBox(height: 10,),
                            InkWell(
                              onTap: () {
                                Get.bottomSheet(
                                    StatefulBuilder(
                                        builder: (context, setState)  {
                                          return  Container(
                                            height: 700,
                                            width: Get.width,
                                            decoration: BoxDecoration(
                                                color: notifier.background,
                                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))
                                            ),
                                            child:  Padding(
                                              padding: const EdgeInsets.all(15),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        InkWell(
                                                            onTap: () {
                                                              Get.back();
                                                            },
                                                            child: Icon(Icons.close,color: notifier.textcolore,)),
                                                        const Spacer(),
                                                        Text('Select a category'.tr,style: TextStyle(color: notifier.textcolore,fontFamily: "SofiaProBold",fontSize: 18),),
                                                        const Spacer(),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 30,),
                                                    Text('Pick the category that best represents your fundraiser.'.tr,style: const TextStyle(fontSize: 16,color: Colors.grey),maxLines: 2,overflow: TextOverflow.ellipsis,),
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
                                                                  print(" + + + +  + + + ${emapty}");
                                                                });
                                                                Get.back();
                                                              },
                                                              child: Container(
                                                                height: 40,
                                                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                                                                decoration: BoxDecoration(
                                                                    color: emapty1 == homeApiController.homeapimodel!.category[a].title ?  theamcolore : notifier.background,
                                                                    borderRadius: BorderRadius.circular(18),
                                                                    border: Border.all(color: Colors.grey.withOpacity(0.4))),
                                                                child: Row(
                                                                  mainAxisSize: MainAxisSize.min,
                                                                  children: [
                                                                    Text(homeApiController.homeapimodel!.category[a].title.toString(),style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 15,color: emapty1 == homeApiController.homeapimodel!.category[a].title ?  Colors.white : notifier.textcolore)),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          })
                                                      ],
                                                    ),
                                                    const SizedBox(height: 30,),
                                                  ],
                                                ),
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
                              child: Container(
                                height: 50,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  // color: Colors.red,
                                  border: Border.all(color: Colors.grey.withOpacity(0.4)),
                                  borderRadius: BorderRadius.circular(14)
                                ),
                                child: Row(
                                  children: [
                                   emapty1.isEmpty ?  Text('Select a category'.tr,style: const TextStyle(color: Colors.grey,fontSize: 16),) : Text('${emapty1}',style:  TextStyle(color: notifier.textcolore,fontSize: 16),),
                                    const Spacer(),
                                    Icon(Icons.arrow_drop_down_outlined,color: notifier.textcolore,)
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Text('Where are you fundraising?'.tr,style: TextStyle(fontSize: 16,color: notifier.textcolore,fontWeight: FontWeight.bold),maxLines: 2,overflow: TextOverflow.ellipsis,),
                            const SizedBox(height: 10,),
                            Container(
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
                                  initialCameraPosition: const CameraPosition(target: LatLng(21.2408, 72.8806), zoom: 13),
                                  mapType: MapType.normal,
                                  markers: Set<Marker>.of(markers),
                                  onTap: (argument) {
                                    setState(() {});
                                    _onAddMarkerButtonPressed(argument.latitude, argument.longitude);
                                    lat = argument.latitude;
                                    long = argument.longitude;
                                    getCurrentLatAndLong(
                                      lat,
                                      long,
                                    );
                                    print("**lato****:--- ${lat}");
                                    print("+++longo+++:--- ${long}");
                                    print("--------------------------------------");
                                    print("hfgjhvhjwfvhjuyfvf:-=---  ${address}");
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
                            ),
                            SizedBox(height: Get.height * 0.01),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: notifier.background,
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 0,right: 15,top: 10,bottom: 10),
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
                                          print("????????????" + currentLocation.latitude.toString());
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
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 10, vertical: 5),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: greaycolore,
                                                  borderRadius: BorderRadius.circular(15),
                                                ),
                                                child: Text(
                                                  "${lat != null ? lat.toString() : "Latitude"}",
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
                            ),
                            const SizedBox(height: 80,)
                          ],
                        ),
                      ),
                    )
                )
              ],
            )
          ],
        ),
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
        print("+ + + + + + :-------- ${pincode}");
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

}

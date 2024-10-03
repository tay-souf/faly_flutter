// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, annotate_overrides, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bootom_navigation_screen/home_screen.dart';
import 'common/common_button.dart';
import 'controller/login_controller.dart';
import 'package:get/get.dart';


class MyWidgetSlider extends StatefulWidget {
  final String data;
  final String ramount;
  MyWidgetSlider(this.data, this.ramount) : super();

  _MyWidgetSliderState createState() => _MyWidgetSliderState();
}

class _MyWidgetSliderState extends State<MyWidgetSlider> {
  late double _sliderValue;

  @override
  void initState() {
    super.initState();
    datagetfunction();
    _sliderValue = double.parse(widget.ramount);
    // print("++++++++++ramount++++++++++ : -----  ${widget.ramount}");
  }



  var currency1;
  CatWiseFundController catWiseFundController = Get.put(CatWiseFundController());



  datagetfunction() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var curr = currency1 = preferences.getString("currenci");
    currency1 = jsonDecode(curr!);
    setState(() {
    });
  }



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10,bottom: 10),
      child: SizedBox(
        height: 15,
        width: Get.width,
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: theamcolore.withOpacity(0.1),
          elevation: 0.0,
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 6,
              activeTrackColor: theamcolore,
              thumbShape: const RoundSliderThumbShape(
                enabledThumbRadius: 0,
                pressedElevation: 8.0,
                elevation: 0,
              ),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 15.0),
              trackShape: CustomTrackShape(),
              activeTickMarkColor: Colors.transparent,
              inactiveTickMarkColor: Colors.transparent,
              inactiveTrackColor: theamcolore.withOpacity(0.1),
              // inactiveTrackColor: Colors.black,
            ),
            child: Slider(
              value: _sliderValue,
              onChanged: (r){},
              min: 0.0,
              max: double.parse(widget.data),
              label: "$currency1 ${_sliderValue.round().toString()}",
              divisions: 30,
            ),
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: unnecessary_import, prefer_collection_literals

import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;


class HomeController extends  GetxController implements GetxService{

  int selectpage = 0;
  int selectpage1 = 0;

  TextEditingController photocontroller = TextEditingController();
  TextEditingController Storycontroller = TextEditingController();
  setselectpage(int value){
    selectpage = value;
    update();
  }

  Future<Uint8List> getImages(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }



}
// FundDidWise Api

import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;

import '../api_model/fundidapi_model.dart';
import '../common/config.dart';

class FundDidWiseController extends GetxController implements GetxService {

  Fundidimodel? fundidimodel;

  bool isLoading = true;

  Future funddidApi({required String uid, required String fundid, required String status}) async {
    Map body = {
      "uid": uid,
      "fund_id": fundid,
      "status": status,
    };

    Map<String, String> userHeader = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };

    var response = await http.post(Uri.parse(Config.api_path + Config.funddid),
        body: jsonEncode(body), headers: userHeader);

    print('+ + + + + + + + + + + $body');

    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (data["Result"] == "true") {
        fundidimodel = fundidimodelFromJson(response.body);
        update();
        if (fundidimodel!.result == "true") {
          isLoading = false;
          update();
        } else {
          Fluttertoast.showToast(
            msg: fundidimodel!.responseMsg,
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





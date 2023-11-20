import 'package:vcardgo/network_dio/network_dio.dart';
import 'package:vcardgo/utils/base_api.dart';
import 'dart:developer';

class BusinessRepository {
  getBusinessData() async {
    var response = await NetworkHttps.getRequest(API.businessUrl);
    print("message $response");
    return response;
  }
}

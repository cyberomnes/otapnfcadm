import 'package:vcardgo/network_dio/network_dio.dart';
import 'package:vcardgo/utils/base_api.dart';

class LogoutRepository {
  logOutFun() async {
    var response = await NetworkHttps.postRequest(API.logoutUrl, {});
    return response;
  }
}

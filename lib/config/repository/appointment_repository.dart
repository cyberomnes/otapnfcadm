import 'package:vcardgo/network_dio/network_dio.dart';
import 'package:vcardgo/utils/base_api.dart';
import 'dart:developer';

class AppointmentRepository {
  getAppointmentData(int pageNo) async {
    var response = await NetworkHttps.getRequest(
        API.appointmentUrl + API.pageUrl + pageNo.toString());
    print("message $response");
    return response;
  }

  changeAppointmentData({
    required int id,
    required String status,
  }) async {
    var response = await NetworkHttps.postRequest(
        API.appointmentStatusUrl, {'appointment_id': id, 'status': status});
    print("message $response");
    return response;
  }

  deleteAppointmentData({required int id}) async {
    var response = await NetworkHttps.postRequest(
        API.deleteAppointmentUrl, {'appointment_id': id});
    print("message $response");
    return response;
  }
}

import 'package:get/get.dart';
import 'package:vcardgo/config/repository/appointment_repository.dart';
import 'package:vcardgo/core/model/appointment.dart';
import 'package:vcardgo/view/widget/common_snak_bar_widget.dart';
import 'package:vcardgo/view/widget/loading_widget.dart';

class AppointmentController extends GetxController {
  AppointmentRepository appointmentRepository = AppointmentRepository();
  RxInt currantPage = 1.obs;
  RxBool isScroll = true.obs;
  Appointment? appointment;
  RxList<AppointmentListData> appointmentList = <AppointmentListData>[].obs;

  getAppointmentData(int pageNo) async {
    Loader.showLoader();
    var response = await appointmentRepository.getAppointmentData(pageNo);
    print("=========$response");
    if (response != null) {
      if (response['status'] == 1) {
        appointment = Appointment.fromJson(response);
        appointmentList.value.addAll(appointment!.data!.data!);
        appointmentList.refresh();
        if (currantPage.value == appointment!.data!.lastPage) {
          isScroll.value = false;
        }
      } else {
        commonToast(response['data']['message']);
      }
    }
    Get.back();
  }

  changeAppointmentData({
    required int id,
    required String status,
  }) async {
    Loader.showLoader();
    var response = await appointmentRepository.changeAppointmentData(
        id: id, status: status);
    print("=========$response");
    if (response != null) {
      if (response['status'] == 1) {
        commonToast(response['message']);
        getAppointmentData(currantPage.value);
      } else {
        commonToast(response['message']);
      }
    }
    Get.back();
  }

  deleteAppointmentData({
    required int id,
  }) async {
    Loader.showLoader();
    var response = await appointmentRepository.deleteAppointmentData(
      id: id,
    );
    print("=========$response");
    if (response != null) {
      if (response['status'] == 1) {
        appointmentList.clear();
        getAppointmentData(currantPage.value);
        commonToast(response['message']);
      } else {
        commonToast(response['message']);
      }
    }
    Get.back();
  }
}

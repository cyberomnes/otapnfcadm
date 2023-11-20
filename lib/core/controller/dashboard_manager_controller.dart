import 'package:get/get.dart';
import 'package:vcardgo/utils/images.dart';
import 'package:vcardgo/view/screen/appointments_screen/appointment_screen.dart';
import 'package:vcardgo/view/screen/business_screen/business_screen.dart';
import 'package:vcardgo/view/screen/setting_screen/setting_screen.dart';

class DashBoardManagerController extends GetxController {
  RxInt currantIndex = 0.obs;
  List itemList = [
    {
      "icon": DefaultImages.businessIcn,
      "title": "Business",
      "screen": BusinessScreen()
    },
    {
      "icon": DefaultImages.appointmentIcn,
      "title": "Appointments",
      "screen": AppointmentScreen()
    },
    {
      "icon": DefaultImages.settingIcn,
      "title": "Setting",
      "screen": SettingScreen()
    },
  ];
}

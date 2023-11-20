// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:vcardgo/config/repository/logout_repository.dart';
import 'package:vcardgo/utils/constant.dart';
import 'package:vcardgo/utils/prefer.dart';
import 'package:vcardgo/view/screen/auth/login_screen.dart';
import 'package:vcardgo/view/widget/loading_widget.dart';

import '../../view/widget/common_snak_bar_widget.dart';
import 'auth_controller.dart';

class SettingController extends GetxController {
  LogoutRepository logoutRepository = LogoutRepository();
  RxBool isDarkTheme = false.obs;
  // String defaultLanguageCode = Prefs.getString(AppConstant.LANGUAGE_CODE) == ''
  //     ? 'en'
  //     : Prefs.getString(AppConstant.LANGUAGE_CODE);
  RxBool isRtl = false.obs;
 RxString languageCode=defaultLanguageCode.obs;
  logOutData() async {
    Loader.showLoader();
    var response = await logoutRepository.logOutFun();
    print("response--->$response");
    if (response['status'] == 1) {
      Prefs.clear();
      Get.offAll(LoginScreen());
      commonToast(response['message']);
      Loader.hideLoader();
    } else if (response['status'] == 9) {
      Prefs.clear();
      Get.offAll(() => LoginScreen());
      commonToast(response['message']);
    } else {
      commonToast(response['message']);
    }
  }
}

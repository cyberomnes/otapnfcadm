import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vcardgo/config/theme/dark_theme.dart';
import 'package:vcardgo/config/theme/light_theme.dart';
import 'package:vcardgo/utils/colors.dart';
import 'package:vcardgo/utils/constant.dart';
import 'package:vcardgo/utils/prefer.dart';

class ThemeController extends GetxController {
  final scrollbarTheme = ScrollbarThemeData(
    thumbVisibility: MaterialStateProperty.all(true),
  );
  RxBool isDark = Prefs.getBool(AppConstant.isDarkUrl).obs;
  bool isDarkTheme = Prefs.getBool(AppConstant.isDarkUrl);

  ThemeData get theme => isDarkTheme
      ? ThemeData.dark().copyWith(
          scrollbarTheme: scrollbarTheme,
          primaryColor: AppColor.themeNavyBlueColor,
        )
      : ThemeData.light().copyWith(
          scrollbarTheme: scrollbarTheme,
          primaryColor: AppColor.themeNavyBlueColor,
        );

  void changeTheme(bool value) {
    Prefs.setBool(AppConstant.isDarkUrl, value);
    isDarkTheme = Prefs.getBool(AppConstant.isDarkUrl);
    print('isDarkTheme::: $isDarkTheme');

    if (isDarkTheme == false) {
      AppLightTheme.lightThemeColor();
      AppLightTheme.lightThemeImage();
      update();
    } else {
      AppDarkTheme.darkColor();
      AppDarkTheme.darkThemeImage();
      update();
    }
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    changeTheme(isDarkTheme);
  }
}

// ignore_for_file: avoid_print, must_be_immutable, prefer_const_constructors

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'utils/constant.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:vcardgo/utils/prefer.dart';
import 'view/screen/auth/welcome_screen.dart';
import 'package:vcardgo/utils/locale_string.dart';
import 'package:vcardgo/core/controller/theme_controller.dart';
import 'package:vcardgo/view/screen/dashboard_manager_screen/dashboard_manager_screen.dart';

class VCardGoApp extends StatelessWidget {
  VCardGoApp({super.key});

  ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    String languageCode = Prefs.getString(AppConstant.LANGUAGE_CODE) == '' ? 'en' : Prefs.getString(AppConstant.LANGUAGE_CODE);
    String countryCode = Prefs.getString(AppConstant.COUNTRY_CODE) == '' ? 'US' : Prefs.getString(AppConstant.COUNTRY_CODE);
    Locale locale = Locale(languageCode, countryCode);

    getToken() async {
      await dotenv.load(fileName: "asset/.env");
      String isDemoMode = dotenv.get(AppConstant.isDemoMode);
      Prefs.setBool(AppConstant.isDemoMode, bool.parse(isDemoMode));
      print("isDemo111========> $isDemoMode = ${Prefs.getBool(AppConstant.isDemoMode)}");
      String accessToken = await Prefs.getToken();
      print("accessToken===> $accessToken");
      return accessToken;
    }

    return GetBuilder(
        init: ThemeController(),
        builder: (themeController) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeController.theme,
            translations: LocaleString(),
            locale: locale,
            home: FutureBuilder(
                future: getToken(),
                builder: (context, AsyncSnapshot snapshot) {
                  print("111 ${snapshot.hasData}");
                  print("222 ${snapshot.data}");
                  if (snapshot.hasData && snapshot.data != '') {
                    print("===>> true");
                    return DashBoardManagerScreen();
                  } else {
                    print("===false");
                    return WelcomeScreen();
                  }
                }),
          );
        });
  }
}

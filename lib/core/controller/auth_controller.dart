// ignore_for_file: avoid_print, prefer_const_constructors

import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vcardgo/utils/prefer.dart';
import 'package:vcardgo/utils/base_api.dart';
import 'package:vcardgo/utils/constant.dart';
import 'package:vcardgo/view/widget/loading_widget.dart';
import 'package:vcardgo/view/widget/common_snak_bar_widget.dart';
import 'package:vcardgo/view/screen/dashboard_manager_screen/dashboard_manager_screen.dart';

  String defaultLanguageCode = Prefs.getString(AppConstant.LANGUAGE_CODE) == '' ? 'en' : Prefs.getString(AppConstant.LANGUAGE_CODE);
class AuthController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool isObscure = true.obs;
  RxInt selectedLanguageIndex=0.obs;
  RxString selectedLanguage="English".obs;
  RxString languageCode = defaultLanguageCode.obs;
  RxString countryCode = "US".obs;
  RxList languageList = [
    {'title': "English",   "local":Locale("en","US"),"languageCode":"en","countryCode":"US"}.obs, //en_US //English
    {'title': "Arabic",    "local":Locale("ar","DZ"),"languageCode":"ar","countryCode":"DZ"}.obs, //ar_DZ //Arabic
    {'title': "Chinese",   "local":Locale("zh","CN"),"languageCode":"zh","countryCode":"CN"}.obs, //zh_CN //Chinese
    {'title': "Danish",    "local":Locale("da","DK"),"languageCode":"da","countryCode":"DK"}.obs, //da_DK //Danish
    {'title': "German",    "local":Locale("de","DE"),"languageCode":"de","countryCode":"DE"}.obs, //de_DE //German
    {'title': "Spanish",   "local":Locale("es","ES"),"languageCode":"es","countryCode":"ES"}.obs, //es_ES //Spanish
    {'title': "French",    "local":Locale("fr","FR"),"languageCode":"fr","countryCode":"FR"}.obs, //fr_FR //French
    {'title': "Hebrew",    "local":Locale("he","IL"),"languageCode":"he","countryCode":"IL"}.obs, //he_IL //Hebrew
    {'title': "Italian",   "local":Locale("it","IT"),"languageCode":"it","countryCode":"IT"}.obs, //it_IT //Italian
    {'title': "Japanese",  "local":Locale("ja","JP"),"languageCode":"ja","countryCode":"JP"}.obs, //ja_JP //Japanese
    {'title': "Dutch",     "local":Locale("nl","NL"),"languageCode":"nl","countryCode":"NL"}.obs, //nl_NL //Dutch
    {'title': "Polish",    "local":Locale("pl","PL"),"languageCode":"pl","countryCode":"PL"}.obs, //pl_PL //Polish
    {'title': "Portuguese","local":Locale("pt","PT"),"languageCode":"pt","countryCode":"PT"}.obs, //pt_PT //Portuguese
    {'title': "Russian",   "local":Locale("ru","RU"),"languageCode":"ru","countryCode":"RU"}.obs, //ru_RU //Russian
    {'title': "Turkish",   "local":Locale("tr","TR"),"languageCode":"tr","countryCode":"TR"}.obs, //tr_TR //Turkish
  ].obs;

  updateLanguage(Locale locale) {
    print("================$locale");
    Get.updateLocale(locale);
    Prefs.setString(AppConstant.LANGUAGE_CODE, locale.languageCode);
    Prefs.setString(AppConstant.COUNTRY_CODE, locale.countryCode.toString());
  }

  authLogin({
    required String email,
    required String password,
  }) async {
    Loader.showLoader();
    var response = await http.post(Uri.parse(API.baseUrl + API.loginUrl),
        body: {'email': email, 'password': password});
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      var decodeData = jsonDecode(response.body);
      if (decodeData['status'] == 1) {
        print('=====> ${decodeData['data']['token']}');
        print('id=====> ${decodeData['data']['id']}');

        Prefs.setToken(decodeData['data']['token']);
        Prefs.setUserID(decodeData['data']['id'].toString());
        Prefs.setString(AppConstant.userName, decodeData['data']['name']);
        Prefs.setString(AppConstant.emailId, decodeData['data']['email']);
        Prefs.setString(AppConstant.profileImage, decodeData['data']['avtar']);
        print('=====> ${Prefs.getToken()}');
        print('=====> ${Prefs.getUserID()}');
        commonToast(decodeData['data']['name']+" Login successfully");

        Get.offAll(() => DashBoardManagerScreen());
      }
      else{
        Loader.hideLoader();
        commonToast(decodeData['message']);
      }
    }
  }
}

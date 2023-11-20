// ignore_for_file: prefer_const_constructors

import 'package:vcardgo/utils/colors.dart';
import 'package:vcardgo/utils/images.dart';

class AppDarkTheme {
  AppDarkTheme._();

  static darkColor() {
    AppColor.cBackGround = DarkThemeColor.cBackGround;
    AppColor.cWhiteFont = DarkThemeColor.cWhiteFont;
    AppColor.cBlackFont = DarkThemeColor.cBlackFont;
    AppColor.cText = DarkThemeColor.cText;
    AppColor.cLabel = DarkThemeColor.cLabel;
    AppColor.cBottomNavyBlueColor = DarkThemeColor.cBottomNavyBlueColor;
    AppColor.cGrey = DarkThemeColor.cGrey;
  }

  static darkThemeImage() {
    DefaultImages.vCardGoLogo = DefaultImages.whiteVcardGoLogo;
  }
}

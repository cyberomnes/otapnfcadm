import 'package:vcardgo/utils/colors.dart';
import 'package:vcardgo/utils/images.dart';

class AppLightTheme {
  AppLightTheme._();

  static lightThemeColor() {
    AppColor.cBackGround = LightThemeColor.cBackGround;
    AppColor.cWhiteFont = LightThemeColor.cWhiteFont;
    AppColor.cBlackFont = LightThemeColor.cBlackFont;
    AppColor.cText = LightThemeColor.cText;
    AppColor.cLabel = LightThemeColor.cLabel;
    AppColor.cBottomNavyBlueColor = LightThemeColor.cBottomNavyBlueColor;
    AppColor.cGrey = LightThemeColor.cGrey;
  }

  static lightThemeImage() {
    DefaultImages.vCardGoLogo = "asset/image/svg_image/vcardgo_logo.svg";
  }
}

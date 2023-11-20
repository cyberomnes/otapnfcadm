// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vcardgo/core/controller/auth_controller.dart';
import 'package:vcardgo/core/controller/setting_controller.dart';
import 'package:vcardgo/core/controller/theme_controller.dart';
import 'package:vcardgo/utils/colors.dart';
import 'package:vcardgo/utils/constant.dart';
import 'package:vcardgo/utils/images.dart';
import 'package:vcardgo/utils/prefer.dart';
import 'package:vcardgo/utils/text_style.dart';
import 'package:vcardgo/view/screen/setting_screen/language_screen.dart';
import 'package:vcardgo/view/screen/setting_screen/store_theme_settings.dart';
import 'package:vcardgo/view/widget/icon_and_image.dart';
import 'package:vcardgo/view/widget/common_appbar_widget.dart';
import 'package:vcardgo/view/widget/common_space_divider_widget.dart';

import 'change_password_screen.dart';
import 'edit_profile_screen.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});

  SettingController settingController = Get.put(SettingController());
  AuthController authController = Get.put(AuthController());


  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: ThemeController(),
        builder: (themeController) {
          return Column(
            children: [
              simpleAppBar(title: "Settings"),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Obx(() {
                  if ( settingController.languageCode.value == 'ar') {
                    settingController.isRtl.value = true;
                  } else {
                    settingController.isRtl.value = false;
                  }
                  print(settingController.isRtl.value);
                  return Column(
                    children: [
                      titleRowWidget(
                        icn: DefaultImages.userProfileIcn,
                        title: "Edit Profile",
                        onTap: () {
                          Get.to(() => EditProfileScreen());
                        },
                      ),
                      horizontalDivider(),
                      titleRowWidget(
                        icn: DefaultImages.changePasswordIcn,
                        title: "Change password",
                        onTap: () {
                          Get.to(() => ChangePasswordScreen());
                        },
                      ),
                      horizontalDivider(),
                      titleRowWidget(
                        icn: DefaultImages.languageIcn,
                        title: "Language",
                        onTap: () {
                          Get.to(()=>LanguageScreen());
                        },
                      ),
                      horizontalDivider(),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            titleRowWidget(
                              icn: DefaultImages.rtlIcn,
                              title: "Enable RTL",
                              onTap: () {
                                if ( settingController.isRtl.value == false) {
                                  settingController.languageCode.value  = 'ar';
                                  settingController.isRtl.value = true;
                                  authController.updateLanguage(Locale("ar", "AR"));
                                } else {
                                  settingController.isRtl.value = false;
                                  settingController.languageCode.value  = 'en';
                                  authController.updateLanguage(Locale("en", "US"));
                                }
                              },
                            ),
                            CupertinoSwitch(
                              value: settingController.isRtl.value,
                              onChanged: (value) {
                                // settingController.isRtl.value = value;
                                if (value == true) {
                                  settingController.languageCode.value  = 'ar';
                                  settingController.isRtl.value = true;
                                  authController.updateLanguage(Locale("ar", "AR"));
                                } else {
                                  settingController.isRtl.value = false;
                                  settingController.languageCode.value  = 'en';
                                  authController.updateLanguage(Locale("en", "US"));
                                }
                              },
                              activeColor: AppColor.themeGreenColor,
                            )
                          ]),
                      horizontalDivider(),
                      titleRowWidget(
                        icn: DefaultImages.themeIcn,
                        title: "Store Theme Settings",
                        onTap: () {
                          Get.to(() => StoreThemeSettingScreen());
                        },
                      ),
                      horizontalDivider(),
                      titleRowWidget(
                        icn: DefaultImages.logoutIcn,
                        title: "Logout",
                        onTap: () {
                          settingController.logOutData();
                        },
                      ),
                      horizontalDivider(),
                    ],
                  );
                }),
              )
            ],
          );
        });
  }

  titleRowWidget({
    required String icn,
    required String title,
    Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          assetSvdImageWidget(image: icn, height: 40),
          horizontalSpace(10),
          Text(
            title,
            style: pSemiBold16,
          )
        ],
      ),
    );
  }
}

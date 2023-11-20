// ignore_for_file: must_be_immutable

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../widget/common_button.dart';
import 'package:vcardgo/utils/images.dart';
import 'package:vcardgo/utils/colors.dart';
import 'package:vcardgo/utils/text_style.dart';
import 'package:vcardgo/view/widget/icon_and_image.dart';
import 'package:vcardgo/core/controller/theme_controller.dart';
import 'package:vcardgo/view/widget/common_appbar_widget.dart';
import 'package:vcardgo/view/widget/common_space_divider_widget.dart';

class StoreThemeSettingScreen extends StatelessWidget {
  StoreThemeSettingScreen({super.key});

  ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ThemeController(),
      builder: (_) {
        return Scaffold(
          backgroundColor: AppColor.cBackGround,
          body: SafeArea(
            child: Column(
              children: [
                myAppBar(title:  "Store Theme Setting"),
                Obx(
                      () {
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          verticalSpace(20),
                          Row(
                            children: [
                              assetSvdImageWidget(
                                image: DefaultImages.themeIcn,
                                height: 40,
                                // width: 24,
                              ),
                              horizontalSpace(10),
                              Text(
                                "Layout Settings",
                                style: pSemiBold16,
                              ),
                            ],
                          ),
                          verticalSpace(10),
                          horizontalDivider(),
                          verticalSpace(10),
                          Row(
                            children: [
                              CupertinoSwitch(
                                value: themeController.isDark.value,
                                onChanged: (value) {
                                  themeController.isDark.value = value;
                                },
                                activeColor: AppColor.themeGreenColor,
                              ),
                              horizontalSpace(10),
                              Text(
                                "Dark Layout",
                                style: pMedium14,
                              ),
                            ],
                          ),
                          verticalSpace(20),
                          CommonButton(
                            title: "Save",
                            onPressed: () {
                              themeController
                                  .changeTheme(themeController.isDark.value);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

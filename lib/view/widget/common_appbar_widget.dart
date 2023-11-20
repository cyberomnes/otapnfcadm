// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:vcardgo/utils/colors.dart';
import 'package:vcardgo/utils/images.dart';
import 'package:vcardgo/utils/text_style.dart';
import 'package:vcardgo/view/widget/common_space_divider_widget.dart';
import 'package:vcardgo/view/widget/icon_and_image.dart';

Widget simpleAppBar({String? title}) {
  return Container(
    width: Get.height,
    height: 70,
    decoration: BoxDecoration(
      color: AppColor.cGrey,
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(22),
      ),
    ),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
    child: Text(
      title!,
      style: pSemiBold23.copyWith(color: AppColor.cFont),
    ),
  );
}

Container myAppBar({required String title}) {
  return Container(
    width: Get.width,
    color: AppColor.themeGreenColor,
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    child: Row(children: [
      GestureDetector(
        onTap: () {
          Get.back();
        },
        child: assetSvdImageWidget(
            image: DefaultImages.backIcn, height: 32, width: 32),
      ),
      horizontalSpace(16),
      Text(
        title,
        style: pSemiBold18.copyWith(color: AppColor.cWhite),
      ),
    ]),
  );
}

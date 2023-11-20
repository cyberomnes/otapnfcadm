import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:vcardgo/core/controller/theme_controller.dart';
import 'package:vcardgo/utils/colors.dart';
import 'package:vcardgo/utils/text_style.dart';
import 'package:vcardgo/view/widget/icon_and_image.dart';
import 'package:vcardgo/view/widget/common_space_divider_widget.dart';
import 'package:vcardgo/core/controller/dashboard_manager_controller.dart';

class DashBoardManagerScreen extends StatelessWidget {
  DashBoardManagerScreen({super.key});

  DashBoardManagerController dashBoardManagerController =
      Get.put(DashBoardManagerController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: ThemeController(),
        builder: (themeController) {
        return Obx(() {
          return Scaffold(
            backgroundColor: AppColor.cBackGround,
            body: SafeArea(
                bottom: false,
                child: dashBoardManagerController
                        .itemList[dashBoardManagerController.currantIndex.value]
                    ['screen']),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: AppColor.cBottomNavyBlueColor,
              currentIndex: dashBoardManagerController.currantIndex.value,
              onTap: (value) {
                dashBoardManagerController.currantIndex.value = value;
              },
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: List.generate(dashBoardManagerController.itemList.length,
                  (index) {
                var data = dashBoardManagerController.itemList[index];
                return BottomNavigationBarItem(
                  icon: Column(
                    children: [
                      assetSvdImageWidget(
                          image: data['icon'],
                          colorFilter: ColorFilter.mode(
                              index == dashBoardManagerController.currantIndex.value
                                  ? AppColor.cGreenFont
                                  : AppColor.cDarkGreyFont,
                              BlendMode.srcIn)),
                      verticalSpace(8),
                      Text(
                        data['title'],
                        style: pMedium14.copyWith(
                            color: index ==
                                    dashBoardManagerController.currantIndex.value
                                ? AppColor.cGreenFont
                                : AppColor.cDarkGreyFont),
                      )
                    ],
                  ),
                  label: data['title'],
                );
              }),
              // items: dashBoardManagerController.itemList
              //     .map((e) => BottomNavigationBarItem(
              //           icon: Column(
              //             children: [
              //               assetSvdImageWidget(image: e['icon']),
              //               verticalSpace(8),
              //               Text(
              //                 e['title'],
              //               )
              //             ],
              //           ),
              //           label: e['title'],
              //         ))
              //     .toList(),
            ),
          );
        });
      }
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vcardgo/core/controller/appointment_controller.dart';
import 'package:vcardgo/core/model/appointment.dart';
import 'package:vcardgo/utils/colors.dart';
import 'package:vcardgo/utils/constant.dart';
import 'package:vcardgo/utils/images.dart';
import 'package:vcardgo/utils/prefer.dart';
import 'package:vcardgo/utils/text_style.dart';
import 'package:vcardgo/view/widget/common_appbar_widget.dart';
import 'package:vcardgo/view/widget/common_snak_bar_widget.dart';
import 'package:vcardgo/view/widget/common_space_divider_widget.dart';
import 'package:vcardgo/view/widget/icon_and_image.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  AppointmentController appointmentController =
      Get.put(AppointmentController());
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appointmentController.appointmentList.clear();
    appointmentController.currantPage.value = 1;
    appointmentController.isScroll.value = true;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getData(appointmentController.currantPage.value);
    });
    scrollController.addListener(() {
      if (appointmentController.isScroll.value == true &&
          scrollController.position.maxScrollExtent ==
              scrollController.position.pixels) {
        appointmentController.currantPage.value += 1;
        getData(appointmentController.currantPage.value);
        print(
            "currantPage................-> ${appointmentController.currantPage.value}");
      }
    });
  }

  getData(int pageNo) {
    appointmentController.getAppointmentData(pageNo);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        simpleAppBar(title: "Appointments"),
        Obx(() {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ListView.builder(
                  itemCount: appointmentController.appointmentList.length,
                  shrinkWrap: true,
                  controller: scrollController,
                  itemBuilder: (context, index) {
                    AppointmentListData appointment =
                        appointmentController.appointmentList[index];
                    return appointmentWidget(
                      category: appointment.businessName,
                      date: appointment.date!.day.toString(),
                      month:
                          DateFormat.MMM().format(appointment.date!).toString(),
                      year: appointment.date!.year.toString(),
                      name: appointment.name,
                      email: appointment.email,
                      phoneNo: appointment.phone,
                      time: appointment.time,
                      isPending: appointment.status.toString() == "pending"
                          ? true
                          : false,
                      deleteFun: () {
                        if (Prefs.getBool(AppConstant.isDemoMode) == true) {
                          commonToast(AppConstant.demoString);
                        } else {
                          appointmentController.deleteAppointmentData(
                              id: appointment.id!);
                        }
                      },
                      statusFun: () {
                        if (Prefs.getBool(AppConstant.isDemoMode) == true) {
                          commonToast(AppConstant.demoString);
                        } else {
                          if (appointment.status.toString() == "pending") {
                            appointmentController.changeAppointmentData(
                                id: appointment.id!,
                                status: appointment.status.toString());
                          }
                        }
                      },
                    );
                  }),
            ),
          );
        })
      ],
    );
  }

  Widget appointmentWidget({
    String? category,
    String? name,
    String? email,
    String? phoneNo,
    String? date,
    String? month,
    String? year,
    String? time,
    bool isPending = true,
    Function()? deleteFun,
    Function()? statusFun,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        color: AppColor.cBackGround,
        shadowColor: AppColor.themeGreenColor,
        elevation: 1.8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: AppColor.cBackGround,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColor.cLightGrey),
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(
              decoration: BoxDecoration(
                  color: AppColor.themeGreenColor,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(12))),
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    category!,
                    style: pSemiBold16,
                  ),
                  GestureDetector(
                    onTap: deleteFun,
                    child: assetSvdImageWidget(
                        image: DefaultImages.deleteIcn,
                        colorFilter:
                            ColorFilter.mode(AppColor.cText, BlendMode.srcIn)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColor.cGrey),
                    child: Center(
                      child: Text.rich(
                          TextSpan(
                              text: "$date\n",
                              style: pMedium24.copyWith(color: AppColor.cFont),
                              children: [
                                TextSpan(
                                    text: '$month\n',
                                    style: pRegular14.copyWith(
                                        color: AppColor.cFont)),
                                TextSpan(
                                    text: '$year',
                                    style: pRegular14.copyWith(
                                        color: AppColor.cFont)),
                              ]),
                          textAlign: TextAlign.center),
                    ),
                  ),
                  horizontalSpace(8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        dataRowWidget(DefaultImages.userIcn, name!),
                        verticalSpace(6),
                        dataRowWidget(DefaultImages.emailIcn, email!),
                        verticalSpace(6),
                        dataRowWidget(DefaultImages.phoneIcn, phoneNo!),
                        // verticalSpace(4),
                        // dataRowWidget(DefaultImages.timeIcn, "11:00 - 12:00"),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            time == null
                                ? SizedBox()
                                : dateTimeWidget(DefaultImages.timeIcn, time),
                            Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: statusFun,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                      color: isPending == true
                                          ? AppColor.themeYellowColor
                                          : AppColor.themeGreenColor,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Text(
                                      isPending ? "Pending" : "Completed",
                                      style: pRegular12.copyWith(
                                          color: AppColor.cWhiteFont)),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }

  Widget dataRowWidget(String icon, String title) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
            width: 18,
            child: assetSvdImageWidget(
                image: icon,
                height: 15,
                width: 15,
                colorFilter:
                    ColorFilter.mode(AppColor.cText, BlendMode.srcIn))),
        horizontalSpace(6),
        Expanded(
          child: Text(
            title,
            style: pMedium14,
            maxLines: 2,
            // overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
  Widget dateTimeWidget(String icon, String title) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
            width: 18,
            child: assetSvdImageWidget(
                image: icon,
                height: 15,
                width: 15,
                colorFilter:
                ColorFilter.mode(AppColor.cText, BlendMode.srcIn))),
        horizontalSpace(6),
        Text(
          title,
          style: pMedium14,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }

}

// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:vcardgo/utils/colors.dart';
import 'package:vcardgo/utils/constant.dart';
import 'package:vcardgo/utils/prefer.dart';
import 'package:vcardgo/utils/text_style.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vcardgo/view/widget/common_button.dart';
import 'package:vcardgo/view/widget/common_snak_bar_widget.dart';
import 'package:vcardgo/view/widget/common_text_field.dart';
import 'package:vcardgo/view/widget/common_appbar_widget.dart';
import 'package:vcardgo/core/controller/edit_profile_controller.dart';
import 'package:vcardgo/view/widget/common_space_divider_widget.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  EditProfileController editProfileController =
      Get.put(EditProfileController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    editProfileController.imagePath.value = '';
    editProfileController.nameController.text =
        Prefs.getString(AppConstant.userName);
    editProfileController.emailController.text =
        Prefs.getString(AppConstant.emailId);
    editProfileController.profileImage.value =
        Prefs.getString(AppConstant.profileImage);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: AppColor.cBackGround,
        body: SafeArea(
          child: Column(children: [
            myAppBar(title: "Edit Profile"),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, Get.height * 0.06, 16, 16),
                  child: Obx(() {
                    return Column(
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundColor: AppColor.cBlackFont,
                              backgroundImage: editProfileController
                                          .imagePath.value ==
                                      ""
                                  ? NetworkImage(
                                      editProfileController.profileImage.value)
                                  : FileImage(File(editProfileController
                                      .imagePath.value)) as ImageProvider,
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(16))),
                                  builder: (context) {
                                    return Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(16))),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 25, horizontal: 16),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          imageWidget(
                                              title: "Camera",
                                              iconData: Icons.camera_alt,
                                              imageSource: ImageSource.camera),
                                          horizontalSpace(35),
                                          imageWidget(
                                              title: "Gallery",
                                              iconData: Icons.photo,
                                              imageSource: ImageSource.gallery),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: AppColor.themeGreenColor,
                                child: Icon(Icons.camera_alt,
                                    size: 18, color: AppColor.cWhiteFont),
                              ),
                            )
                          ],
                        ),
                        verticalSpace(35),
                        CommonTextField(
                          controller: editProfileController.nameController,
                          labelText: 'Name',
                        ),
                        verticalSpace(12),
                        CommonTextField(
                          controller: editProfileController.emailController,
                          labelText: 'Email',
                        ),
                        verticalSpace(35),
                        CommonButton(
                          title: 'Save Changes',
                          onPressed: () {
                            if (Prefs.getBool(AppConstant.isDemoMode) == true) {
                              commonToast(AppConstant.demoString);
                            } else {
                              editProfileController.saveProfileData(
                                  email: editProfileController
                                      .emailController.text
                                      .trim(),
                                  name: editProfileController
                                      .nameController.text
                                      .trim(),
                                  avtar: editProfileController.imagePath.value);
                            }
                          },
                        )
                      ],
                    );
                  }),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }

  Widget imageWidget({
    ImageSource? imageSource,
    String? title,
    IconData? iconData,
  }) {
    return GestureDetector(
      onTap: () {
        editProfileController.pickImage(imageSource: imageSource!);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(iconData, color: AppColor.cDarkGreyFont, size: 55),
          verticalSpace(8),
          Text(
            title!,
            style: pSemiBold19.copyWith(color: AppColor.cDarkGreyFont),
          )
        ],
      ),
    );
  }
}

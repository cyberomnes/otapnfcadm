// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:vcardgo/utils/colors.dart';
import 'package:vcardgo/utils/constant.dart';
import 'package:vcardgo/utils/prefer.dart';
import 'package:vcardgo/utils/validator.dart';
import 'package:vcardgo/view/widget/common_button.dart';
import 'package:vcardgo/view/widget/common_snak_bar_widget.dart';
import 'package:vcardgo/view/widget/common_text_field.dart';
import 'package:vcardgo/view/widget/common_appbar_widget.dart';
import 'package:vcardgo/view/widget/common_space_divider_widget.dart';
import 'package:vcardgo/core/controller/change_password_controller.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  ChangePasswordController changePasswordController =
      Get.put(ChangePasswordController());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: AppColor.cBackGround,
        body: SafeArea(
          child: Column(
            children: [
              myAppBar(title: "Change password"),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                  child: Obx(() {
                    return Form(
                      key: formKey,
                      child: Column(
                        children: [
                          CommonTextField(
                            controller: changePasswordController.oldPassword,
                            labelText: 'Old password',
                            hintText: 'Enter old password',
                            obscureText:
                                changePasswordController.isOldPass.value,
                            obscuringCharacter: "*",
                            onChanged: (value) {
                              Validator.validateRequired(value,
                                  string: "Password");
                            },
                            validator: (value) {
                              return Validator.validateRequired(value!,
                                  string: "Password");
                            },
                            suffix: GestureDetector(
                              onTap: () {
                                changePasswordController.isOldPass.value =
                                    !changePasswordController.isOldPass.value;
                              },
                              child: Icon(
                                changePasswordController.isOldPass.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: AppColor.cDarkGreyFont,
                              ),
                            ),
                          ),
                          verticalSpace(16),
                          CommonTextField(
                            controller: changePasswordController.newPassword,
                            labelText: 'New password',
                            hintText: 'Enter new password',
                            obscureText:
                                changePasswordController.isNewPass.value,
                            obscuringCharacter: "*",
                            onChanged: (value) {
                              Validator.validateRequired(value,
                                  string: "Password");
                            },
                            validator: (value) {
                              return Validator.validateRequired(value!,
                                  string: "Password");
                            },
                            suffix: GestureDetector(
                              onTap: () {
                                changePasswordController.isNewPass.value =
                                    !changePasswordController.isNewPass.value;
                              },
                              child: Icon(
                                changePasswordController.isNewPass.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: AppColor.cDarkGreyFont,
                              ),
                            ),
                          ),
                          verticalSpace(16),
                          CommonTextField(
                            controller:
                                changePasswordController.confirmPassword,
                            labelText: 'Confirm password',
                            hintText: 'Enter confirm password',
                            obscureText:
                                changePasswordController.isConfirmPass.value,
                            obscuringCharacter: "*",
                            onChanged: (value) {
                              Validator.validateConfirmRequired(value,
                                  changePasswordController.newPassword.text);
                            },
                            validator: (value) {
                              return Validator.validateConfirmRequired(value!,
                                  changePasswordController.newPassword.text);
                            },
                            suffix: GestureDetector(
                              onTap: () {
                                changePasswordController.isConfirmPass.value =
                                    !changePasswordController
                                        .isConfirmPass.value;
                              },
                              child: Icon(
                                changePasswordController.isConfirmPass.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: AppColor.cDarkGreyFont,
                              ),
                            ),
                          ),
                          verticalSpace(35),
                          CommonButton(
                            title: 'Save change',
                            onPressed: () {
                              if (Prefs.getBool(AppConstant.isDemoMode) == true) {
                                commonToast(AppConstant.demoString);
                              } else {
                                if (formKey.currentState!.validate()) {
                                  print("validate");
                                  changePasswordController.changePassword(
                                      oldPassword: changePasswordController
                                          .oldPassword.text
                                          .trim(),
                                      newPassword: changePasswordController
                                          .newPassword.text
                                          .trim(),
                                      confirmPassword: changePasswordController
                                          .confirmPassword.text
                                          .trim());
                                }
                              }
                            },
                          )
                        ],
                      ),
                    );
                  }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

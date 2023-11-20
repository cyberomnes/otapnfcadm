import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vcardgo/core/controller/auth_controller.dart';
import 'package:vcardgo/utils/colors.dart';
import 'package:vcardgo/utils/constant.dart';
import 'package:vcardgo/utils/images.dart';
import 'package:vcardgo/utils/prefer.dart';
import 'package:vcardgo/utils/text_style.dart';
import 'package:vcardgo/utils/validator.dart';
import 'package:vcardgo/view/screen/dashboard_manager_screen/dashboard_manager_screen.dart';
import 'package:vcardgo/view/widget/common_button.dart';
import 'package:vcardgo/view/widget/common_space_divider_widget.dart';
import 'package:vcardgo/view/widget/common_text_field.dart';
import 'package:vcardgo/view/widget/icon_and_image.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthController authController = Get.put(AuthController());

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Prefs.getBool(AppConstant.isDemoMode) == true) {
      authController.emailController.text = 'company@example.com';
      authController.passwordController.text = '1234';
    } else {
      authController.emailController.clear();
      authController.passwordController.clear();
    }
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
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child:
                        assetSvdImageWidget(image: DefaultImages.vCardGoLogo)),
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Obx(() {
                        return Form(
                          key: formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Login",
                                style: pBold42,
                                textAlign: TextAlign.center,
                              ),
                              verticalSpace(8),
                              Text(
                                "Login now to access Otap",
                                style: pMedium16,
                                textAlign: TextAlign.center,
                              ),
                              verticalSpace(35),
                              CommonTextField(
                                controller: authController.emailController,
                                labelText: 'Email',
                                hintText: "Enter Email",
                                keyboardType: TextInputType.emailAddress,
                                onChanged: (value) {
                                  Validator.validateEmail(value);
                                },
                                validator: (value) {
                                  return Validator.validateEmail(value!);
                                },
                              ),
                              verticalSpace(16),
                              CommonTextField(
                                controller: authController.passwordController,
                                labelText: "Password",
                                hintText: "Enter Password",
                                obscureText: authController.isObscure.value,
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
                                    authController.isObscure.value =
                                        !authController.isObscure.value;
                                  },
                                  child: Icon(
                                    authController.isObscure.value
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: AppColor.cDarkGreyFont,
                                  ),
                                ),
                              ),
                              verticalSpace(32),
                              CommonButton(
                                title: "Login",
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    authController.authLogin(
                                        email: authController
                                            .emailController.text
                                            .trim(),
                                        password: authController
                                            .passwordController.text
                                            .trim());
                                  }
                                },
                              )
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

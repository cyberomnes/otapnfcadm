import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:vcardgo/utils/colors.dart';
import 'package:vcardgo/utils/images.dart';
import 'package:vcardgo/utils/text_style.dart';
import 'package:vcardgo/view/widget/common_button.dart';
import 'package:vcardgo/view/widget/icon_and_image.dart';
import 'package:vcardgo/view/screen/auth/login_screen.dart';
import 'package:vcardgo/view/widget/common_space_divider_widget.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.cBackGround,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 26),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  child: assetSvdImageWidget(image: DefaultImages.vCardGoLogo),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    verticalSpace(55),
                    Center(child: Image.asset(DefaultImages.welcomeImage)),
                    verticalSpace(50),
                    Text(
                      "Welcome to Otap",
                      style: pBold42.copyWith(fontSize: 40),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 26, 12, 75),
                      child: Text(
                        "Welcome to Otap, the innovative app that revolutionizes the way you share information and connect with others in the business world!",
                        style: pRegular14,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    CommonButton(
                      title: 'Next',
                      onPressed: () {
                        Get.offAll(() => LoginScreen());
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

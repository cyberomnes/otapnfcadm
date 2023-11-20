import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vcardgo/utils/base_api.dart';
import 'package:vcardgo/utils/constant.dart';
import 'package:vcardgo/utils/prefer.dart';
import 'package:vcardgo/view/screen/auth/login_screen.dart';
import 'package:vcardgo/view/widget/common_snak_bar_widget.dart';
import 'package:http/http.dart' as http;
import 'package:vcardgo/view/widget/loading_widget.dart';

class EditProfileController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  RxString imagePath = ''.obs;
  RxString profileImage =
      '"https://portal.bilardo.gov.tr/assets/pages/media/profile/profile_user.jpg"'
          .obs;

  pickImage({required ImageSource imageSource}) async {
    final XFile? media = await _picker.pickImage(source: imageSource);
    Get.back();
    print("media--->$media");
    if (media != null) {
      imagePath.value = media.path;
      print("imagePath---->(£$imagePath)");
    } else {
      commonToast("Image not pick");
    }
  }

  saveProfileData({
    String? email,
    String? name,
    String? avtar,
  }) async {
    String url = API.baseUrl + API.editProfileUrl;
    print("url==>$url");
    print("data==>${{'name': name!, 'email': email!}}");
    Loader.showLoader();
    var headers = {
      "Authorization": 'Bearer ${Prefs.getToken()}',
    };
    var request = await http.MultipartRequest("POST", Uri.parse(url));

    request.fields.addAll({'name': name!, 'email': email!});
    if (avtar != '') {
      request.files.add(await http.MultipartFile.fromPath('avtar', avtar!));
    }
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    print("v statusCode===========>${response.statusCode}");
    var decodedData = jsonDecode(await response.stream.bytesToString());
    print("1111===========>$decodedData");
    print(response.statusCode);
    if (response.statusCode == 200) {
      if (decodedData['status'] == 1) {
        print('=====> ${decodedData}');
        Prefs.setString(AppConstant.userName, decodedData['data']['name']);
        Prefs.setString(AppConstant.emailId, decodedData['data']['email']);
        Prefs.setString(AppConstant.profileImage, decodedData['data']['avtar']);
        commonToast(decodedData['message']);
        Loader.hideLoader();
      } else if (decodedData['status'] == 9) {
        await Prefs.clear();
        Get.offAll(() => LoginScreen());
      } else {
        Loader.hideLoader();
        commonToast(decodedData['message']);
      }
    }
  }
}

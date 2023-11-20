import 'package:get/get.dart';
import 'package:vcardgo/config/repository/business_repository.dart';
import 'package:vcardgo/core/model/business.dart';
import 'package:vcardgo/view/widget/loading_widget.dart';

class BusinessController extends GetxController {
  BusinessRepository businessRepository = BusinessRepository();
  BusinessModel? businessModel;
  RxList<BusinessData> businessList = <BusinessData>[].obs;

  getBusinessData() async {
    Loader.showLoader();
    var response = await businessRepository.getBusinessData();
    print("=== ${response}");
    if (response['status'] == 1) {
      businessModel = BusinessModel.fromJson(response);
      businessList.value = businessModel!.data!;
      businessList.refresh();
      Get.back();
    }
  }
}

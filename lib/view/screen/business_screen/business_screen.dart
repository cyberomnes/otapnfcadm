// ignore_for_file: prefer_const_constructors, avoid_print, use_build_context_synchronously

import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vcardgo/core/model/business.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vcardgo/core/controller/business_controller.dart';
import 'package:vcardgo/utils/colors.dart';
import 'package:vcardgo/utils/images.dart';
import 'package:vcardgo/utils/text_style.dart';
import 'package:vcardgo/view/widget/common_snak_bar_widget.dart';
import 'package:vcardgo/view/widget/icon_and_image.dart';
import 'package:vcardgo/view/widget/common_space_divider_widget.dart';

import 'scan_widget.dart';
class BusinessScreen extends StatefulWidget {
  const BusinessScreen({super.key});

  @override
  State<BusinessScreen> createState() => _BusinessScreenState();
}

class _BusinessScreenState extends State<BusinessScreen> {
  BusinessController businessController = Get.put(BusinessController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      businessController.getBusinessData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Obx(() {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Cards",
                  style: pMedium24,
                ),
                assetSvdImageWidget(
                    image: DefaultImages.vCardGoLogo, height: 29)
              ],
            ),
            verticalSpace(26),
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: businessController.businessList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.9),
                itemBuilder: (context, index) {
                  BusinessData business =
                      businessController.businessList[index];
                  return cardsWidget(
                    image: business.logo!,
                    title: business.title!.capitalizeFirst!,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(16))),
                        barrierColor: AppColor.cBlackOpacity,
                        isScrollControlled: true,
                        builder: (context) {
                          Uint8List bytesImage = Base64Decoder()
                              .convert(business.qrcodeBase64.toString());

                          return Container(
                            decoration: BoxDecoration(
                              color: AppColor.cBackGround,
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(16))),
                            padding: EdgeInsets.fromLTRB(16, 25, 16, 35),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border:
                                          Border.all(color: AppColor.cBorder)),
                                  padding: EdgeInsets.fromLTRB(24, 24, 16, 24),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 40,
                                        backgroundImage:
                                            NetworkImage(business.logo!),
                                        backgroundColor: AppColor.cWhite,
                                        child: buildCachedNetworkImage(
                                            imageUrl: business.logo!),
                                      ),
                                      horizontalSpace(16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              business.title!,
                                              style: pSemiBold27,
                                            ),
                                            verticalSpace(business.subtitle == null ? 0 : 8),
                                            Text(
                                              business.subtitle ?? '',
                                              style: pRegular16.copyWith(color: AppColor.cDarkGreyFont),
                                              maxLines: 2,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                verticalSpace(20),
                                Row(
                                  children: [
                                    sendCardButton(
                                      image: DefaultImages.sendIcn,
                                      title: "Send",
                                      subTitle:
                                          "Share via QR, email, text and more.",
                                      onTap: () {
                                        onShare(context,
                                            "${business.title}\n${business.subtitle}\n${business.links}");
                                      },
                                    ),
                                    horizontalSpace(16),
                                    sendCardButton(
                                      image: DefaultImages.viewIcn,
                                      title: "View",
                                      subTitle: "Open your card in VcardGo.",
                                      onTap: () {
                                        _launchInBrowser(
                                            Uri.parse(business.links!));
                                      },
                                    ),
                                  ],
                                ),
                                verticalSpace(20),
                                Row(
                                  children: [
                                    Expanded(
                                      child: iconButton(
                                        image: DefaultImages.downloadIcn,
                                        title: "Download QR",
                                        onTap: () async {
                                          if (await Permission
                                                  .mediaLibrary.isGranted ||
                                              await Permission
                                                  .storage.isGranted) {
                                            Directory? tempDir =
                                                await getApplicationDocumentsDirectory();
                                            String path = Platform.isAndroid
                                                ? '/storage/emulated/0/Download/${business.title!.trim()}.png'
                                                : "${tempDir.path}/${business.title!.trim()}.png";
                                            var image = File(path)
                                                .openSync(mode: FileMode.write);
                                            print(image.path);
                                            image.writeFromSync(bytesImage);
                                            await image.close();
                                            commonToast("Save to Gallery");
                                          } else {
                                            final status = await Permission
                                                .values
                                                .request();
                                            print("===status====$status");
                                          }
                                        },
                                      ),
                                    ),
                                    horizontalSpace(16),
                                    Expanded(
                                      child: iconButton(
                                        image: DefaultImages.writeNfcIcn,
                                        title: "Write NFC",
                                        onTap: () async {
                                          Get.back();
                                          bool isNFCAvailable = await NfcManager
                                              .instance
                                              .isAvailable();
                                          if (isNFCAvailable == true) {
                                            if (Platform.isAndroid) {
                                              showModalBottomSheet(
                                                context: context,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
                                                barrierColor: AppColor.cBlackOpacity,
                                                isScrollControlled: true,
                                                builder: (context) {
                                                  return ReadyToScanWidget(
                                                    nfcWriteLink: business.links.toString(),
                                                  );
                                                },
                                              );
                                            } else {
                                              ndefWrite(business.links.toString());
                                            }
                                          } else {
                                            commonToast(
                                                "NFC not available in your device");
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            )
          ],
        );
      }),
    );
  }

  onShare(BuildContext context, String text) async {
    return await Share.share(
      text,
    );
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  Widget iconButton({
    String? image,
    String? title,
    Function()? onTap,
  }) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          height: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColor.cBorder)),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 19),
          child: FittedBox(
            child: Row(children: [
              assetSvdImageWidget(image: image,colorFilter: ColorFilter.mode(AppColor.cText, BlendMode.srcIn)),
              horizontalSpace(10),
              Text(
                title!,
                style: pMedium14,
              )
            ]),
          ),
        ));
  }

  Widget sendCardButton({
    String? image,
    String? title,
    String? subTitle,
    Function()? onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 170,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColor.cBorder)),
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              assetSvdImageWidget(image: image),
              verticalSpace(10),
              Text(
                title!,
                style: pSemiBold21,
              ),
              verticalSpace(8),
              Text(
                subTitle!,
                style: pRegular12.copyWith(color: AppColor.cDarkGreyFont),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardsWidget(
      {required String image, required String title, Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColor.cLightGrey)),
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: Get.height * 0.12,
              width: Get.height * 0.12,
              decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(10),
                  // border: Border.all(color: AppColor.cBorder),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(image), fit: BoxFit.contain)),
              child: ClipOval(
                  child: buildCachedNetworkImage(imageUrl: image, height: 120)),
            ),
            verticalSpace(12),
            Text(
              title,
              style: pBold18.copyWith(),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}

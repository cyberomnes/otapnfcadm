// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:vcardgo/utils/colors.dart';
import 'package:vcardgo/utils/images.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:vcardgo/utils/text_style.dart';
import 'package:vcardgo/view/widget/common_button.dart';
import 'package:vcardgo/view/widget/common_snak_bar_widget.dart';
import 'package:vcardgo/view/widget/common_space_divider_widget.dart';

Future<void> ndefWrite(String url) async {
  print("-------------- ${await NfcManager.instance.isAvailable()}");

  NfcManager.instance.startSession(
      onDiscovered: (NfcTag tag) async {
        var ndef = Ndef.from(tag);
        print("ndef----------->$ndef");
        if (ndef == null || !ndef.isWritable) {
          NfcManager.instance.stopSession();
          return;
        }

        NdefMessage message = NdefMessage([
          NdefRecord.createUri(Uri.parse(url)),
        ]);
        print("------------message--->${message}");
        try {
          await ndef.write(message);
          NfcManager.instance.stopSession();
          Get.back();
        } catch (e) {
          print("eeeeeeee-> $e");
          print("eeeeeeee---> ${e.toString()}");
          NfcManager.instance.stopSession(errorMessage: e.toString());
          return;
        }
      },
      alertMessage: "Tap the NFC tag to the top of your device to write your Work card to it.",
      onError: (error) async {
        print("eeeonError------e-> $error");
        print("eeeonError------e-> ${error.details}");
        print("eeeonError------e-> ${error.message}");
        print("eeeonError------e-> ${error.type}");
        NfcManager.instance.stopSession(errorMessage: error.message.toString());
        commonToast(error.message);
      },
      invalidateAfterFirstRead: false,
    pollingOptions: {NfcPollingOption.iso14443, NfcPollingOption.iso15693,NfcPollingOption.iso18092,},
  );
}

class ReadyToScanWidget extends StatefulWidget {
  final String nfcWriteLink;

  const ReadyToScanWidget({super.key, required this.nfcWriteLink});

  @override
  State<ReadyToScanWidget> createState() => _ReadyToScanWidgetState();
}

class _ReadyToScanWidgetState extends State<ReadyToScanWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ndefWrite(widget.nfcWriteLink);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
          color: AppColor.cWhite,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Ready to scan",
            style: pSemiBold27,
          ),
          verticalSpace(22),
          Image(image: AssetImage(DefaultImages.nfcScanImage)),
          verticalSpace(43),
          Text(
            "Tap the NFC tag to the top of your device to write your Work card to it.",
            style: pRegular16.copyWith(color: AppColor.cDarkGreyFont),
            textAlign: TextAlign.center,
          ),
          verticalSpace(25),
          CommonButton(
            title: 'Cancel',
            onPressed: () {
              NfcManager.instance.stopSession();
              Get.back();
            },
            btnColor: AppColor.cButton,
            textColor: AppColor.cFont,
          ),
          verticalSpace(25),
        ],
      ),
    );
  }
}

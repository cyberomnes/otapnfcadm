import 'dart:isolate';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vcardgo/vcardgo_app.dart';

GetStorage? getStorage;

void _isolateMain(RootIsolateToken rootIsolateToken) async {
  BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  print(sharedPreferences.getBool('isDebug'));
}


Future<void> main() async {
  RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
  Isolate.spawn(_isolateMain, rootIsolateToken);
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  getStorage = GetStorage();
  runApp(VCardGoApp());
}

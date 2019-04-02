import 'package:flutter/material.dart';
import 'dart:io';
import './sharedPreferences.dart';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

Future<bool> checkPermission(PermissionGroup permission) async {
  if (Platform.isAndroid) {
    PermissionStatus permissionStatus =
        await PermissionHandler().checkPermissionStatus(permission);
    if (permissionStatus != PermissionStatus.granted) {
      return await requestionPermission(permission);
    } else {
      return true;
    }
  } else {
    return false;
  }
}

Future<bool> requestionPermission(PermissionGroup permission) async {
  if (Platform.isAndroid) {
    Map<PermissionGroup, PermissionStatus> permissions =
        await PermissionHandler().requestPermissions([permission]);
    return permissions[permission] == PermissionStatus.granted;
  }
  return false;
}

Future<String> getFileDownloadPath() async {
  final directory = Platform.isAndroid
      ? await getExternalStorageDirectory()
      : await getApplicationDocumentsDirectory();
  final localPath = '${directory.path}/Download';

  final saveDir = Directory(localPath);

  if (!(await saveDir.exists())) {
    await saveDir.createSync();
  }

  return localPath;
}

Future logout() async {
  SpUtil spUtil = await SpUtil.getInstance();

  await spUtil.putBool(SharedPreferencesKeys.hasLogin, false);
  await spUtil.remove(SharedPreferencesKeys.basicKey);
  await spUtil.remove(SharedPreferencesKeys.loginUserName);
  await spUtil.remove(SharedPreferencesKeys.loginUserPWD);
  await spUtil.remove(SharedPreferencesKeys.teamCityServerUrl);
}

Future login(
    {String authKey, String userName, String pwd, String serverUrl}) async {
  SpUtil spUtil = await SpUtil.getInstance();

  await spUtil.putBool(SharedPreferencesKeys.hasLogin, true);
  await spUtil.putString(SharedPreferencesKeys.basicKey, authKey);
  await spUtil.putString(SharedPreferencesKeys.loginUserName, userName);
  await spUtil.putString(SharedPreferencesKeys.loginUserPWD, pwd);
  await spUtil.putString(SharedPreferencesKeys.teamCityServerUrl, serverUrl);
}

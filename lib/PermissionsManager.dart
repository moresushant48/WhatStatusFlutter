import 'package:permission_handler/permission_handler.dart';

class PermissionManager {
  static Future<bool> askForPermission() async {
    return await Permission.storage.request().isGranted ? true : false;
  }

  Future<bool> checkPermission() async {
    return await Permission.storage.isGranted;
  }
}

final permissionManager = PermissionManager();

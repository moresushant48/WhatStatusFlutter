import 'package:permission_handler/permission_handler.dart';

class PermissionManager {
  static Future<bool> askForPermission() async {
    return await Permission.storage.request().isGranted ? true : false;
  }
}

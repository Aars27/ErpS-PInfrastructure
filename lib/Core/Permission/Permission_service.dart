import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  /// 🔍 Check all required permissions
  Future<bool> checkAllPermissions() async {
    final location = await Permission.location.status;
    final camera = await Permission.camera.status;
    final notification = await Permission.notification.status;

    /// Location mandatory, baaki optional
    return location.isGranted;
  }

  /// 📲 Request permissions
  Future<Map<Permission, PermissionStatus>> requestAllPermissions() async {
    return await [
      Permission.location,
      Permission.camera,
      Permission.notification,
    ].request();
  }

  /// ⚙️ Open app settings
  Future<void> openSettings() async {
    await openAppSettings();
  }
}

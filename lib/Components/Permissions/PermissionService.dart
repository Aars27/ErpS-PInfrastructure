import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  // Singleton pattern
  static final PermissionService _instance = PermissionService._internal();
  factory PermissionService() => _instance;
  PermissionService._internal();

  // Check if all permissions are granted
  Future<bool> checkAllPermissions() async {
    final locationStatus = await Permission.location.status;
    final cameraStatus = await Permission.camera.status;
    final photosStatus = await Permission.photos.status;
    final notificationStatus = await Permission.notification.status;

    return locationStatus.isGranted &&
        cameraStatus.isGranted &&
        photosStatus.isGranted &&
        notificationStatus.isGranted;
  }

  // Request all permissions
  Future<Map<Permission, PermissionStatus>> requestAllPermissions() async {
    return await [
      Permission.location,
      Permission.camera,
      Permission.photos,
      Permission.notification,
    ].request();
  }

  // Check individual permission
  Future<bool> isPermissionGranted(Permission permission) async {
    return await permission.isGranted;
  }

  // Request individual permission
  Future<PermissionStatus> requestPermission(Permission permission) async {
    return await permission.request();
  }

  // Open app settings
  Future<bool> openSettings() async {
    return await openAppSettings();
  }

  // Get permission status for all required permissions
  Future<Map<String, PermissionStatus>> getPermissionsStatus() async {
    return {
      'location': await Permission.location.status,
      'camera': await Permission.camera.status,
      'photos': await Permission.photos.status,
      'notification': await Permission.notification.status,
    };
  }

  // Check if any permission is permanently denied
  Future<bool> hasPermissionPermanentlyDenied() async {
    final locationStatus = await Permission.location.status;
    final cameraStatus = await Permission.camera.status;
    final photosStatus = await Permission.photos.status;
    final notificationStatus = await Permission.notification.status;

    return locationStatus.isPermanentlyDenied ||
        cameraStatus.isPermanentlyDenied ||
        photosStatus.isPermanentlyDenied ||
        notificationStatus.isPermanentlyDenied;
  }

  // Request location permission
  Future<PermissionStatus> requestLocationPermission() async {
    return await Permission.location.request();
  }

  // Request camera permission
  Future<PermissionStatus> requestCameraPermission() async {
    return await Permission.camera.request();
  }

  // Request photos permission
  Future<PermissionStatus> requestPhotosPermission() async {
    return await Permission.photos.request();
  }

  // Request notification permission
  Future<PermissionStatus> requestNotificationPermission() async {
    return await Permission.notification.request();
  }

  // Check location permission
  Future<bool> isLocationGranted() async {
    return await Permission.location.isGranted;
  }

  // Check camera permission
  Future<bool> isCameraGranted() async {
    return await Permission.camera.isGranted;
  }

  // Check photos permission
  Future<bool> isPhotosGranted() async {
    return await Permission.photos.isGranted;
  }

  // Check notification permission
  Future<bool> isNotificationGranted() async {
    return await Permission.notification.isGranted;
  }
}
import 'package:permission_handler/permission_handler.dart';

Future<void> requestPermissions() async {
  final cameraStatus = await Permission.camera.request();
  final locationStatus = await Permission.location.request();

  if (!cameraStatus.isGranted || !locationStatus.isGranted) {
    throw Exception('Camera and location permissions are required.');
  }
}

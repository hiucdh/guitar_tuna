import 'package:permission_handler/permission_handler.dart';
import '../../core/utils/logger.dart';

class PermissionService {
  Future<bool> requestMicrophonePermission() async {
    try {
      final status = await Permission.microphone.request();
      
      switch (status) {
        case PermissionStatus.granted:
          Logger.info('Microphone permission granted');
          return true;
        case PermissionStatus.denied:
          Logger.warning('Microphone permission denied');
          return false;
        case PermissionStatus.permanentlyDenied:
          Logger.warning('Microphone permission permanently denied');
          await openAppSettings();
          return false;
        case PermissionStatus.restricted:
          Logger.warning('Microphone permission restricted');
          return false;
        case PermissionStatus.limited:
          Logger.info('Microphone permission limited');
          return true; // Limited access is still access
        case PermissionStatus.provisional:
           Logger.info('Microphone permission provisional');
           return true; 
      }
    } catch (e) {
      Logger.error('Error requesting microphone permission', error: e);
      return false;
    }
  }

  Future<bool> checkMicrophonePermission() async {
    try {
      final status = await Permission.microphone.status;
      return status.isGranted || status.isLimited;
    } catch (e) {
      Logger.error('Error checking microphone permission', error: e);
      return false;
    }
  }
}

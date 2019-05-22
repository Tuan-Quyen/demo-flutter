import 'package:permission_handler/permission_handler.dart';
class CheckPermission {
  checkPermissionStorage() async {
    PermissionStatus checkResultStorage = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);
    if (checkResultStorage == PermissionStatus.denied) {
      return await PermissionHandler()
          .requestPermissions([PermissionGroup.storage]).then(
              (Map<PermissionGroup, PermissionStatus> status) async {
        if (status[PermissionGroup.storage] == PermissionStatus.granted) {
          return true;
        } else {
          return false;
        }
      });
    } else {
      return true;
    }
  }

  Future<bool> checkPermissionCamera() async {
    PermissionStatus checkResultCamera =
        await PermissionHandler().checkPermissionStatus(PermissionGroup.camera);
    if (checkResultCamera == PermissionStatus.denied) {
      return await PermissionHandler()
          .requestPermissions([PermissionGroup.camera]).then(
              (Map<PermissionGroup, PermissionStatus> status) async {
        if (status[PermissionGroup.camera] == PermissionStatus.granted) {
          return true;
        } else {
          return false;
        }
      });
    } else {
      return true;
    }
  }

  Future<bool> checkPermissionMicroPhone() async {
    PermissionStatus checkResultMicroPhone = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.microphone);
    if (checkResultMicroPhone == PermissionStatus.denied) {
      return await PermissionHandler()
          .requestPermissions([PermissionGroup.microphone]).then(
              (Map<PermissionGroup, PermissionStatus> status) async {
        if (status[PermissionGroup.microphone] == PermissionStatus.granted) {
          return true;
        } else {
          return false;
        }
      });
    } else {
      return true;
    }
  }
}

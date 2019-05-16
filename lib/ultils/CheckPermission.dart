import 'package:permission_handler/permission_handler.dart';

class CheckPermission {
  checkPermissionStorage() async {
    PermissionStatus checkResultStorage = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);
    if (checkResultStorage.value == 0) {
      //0 is unknow permission checked
      return await PermissionHandler()
          .requestPermissions([PermissionGroup.storage]).then(
              (Map<PermissionGroup, PermissionStatus> status) async {
        if (status[PermissionGroup.storage].value == 2) {
          //2 is granted
          return true;
        } else {
          //denied
          return false;
        }
      });
    } else {
      //granted
      return true;
    }
  }

  Future<bool> checkPermissionCamera() async {
    PermissionStatus checkResultCamera =
        await PermissionHandler().checkPermissionStatus(PermissionGroup.camera);
    if (checkResultCamera.value == 0) {
      //0 is unknow permission checked
      return await PermissionHandler()
          .requestPermissions([PermissionGroup.camera]).then(
              (Map<PermissionGroup, PermissionStatus> status) async {
        if (status[PermissionGroup.camera].value == 2) {
          //2 is granted
          return true;
        } else {
          //denied
          return false;
        }
      });
    } else {
      //granted
      return true;
    }
  }

  Future<bool> checkPermissionMicroPhone() async {
    PermissionStatus checkResultMicroPhone = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.microphone);
    if (checkResultMicroPhone.value == 0) {
      //0 is unknow permission checked
      return await PermissionHandler()
          .requestPermissions([PermissionGroup.microphone]).then(
              (Map<PermissionGroup, PermissionStatus> status) async {
        if (status[PermissionGroup.microphone].value == 2) {
          //2 is granted
          return true;
        } else {
          //denied
          return false;
        }
      });
    } else {
      //granted
      return true;
    }
  }

  Future<bool> checkPermissionLocation() async {
    PermissionStatus checkResultLocation = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.location);
    if (checkResultLocation.value == 0) {
      //0 is unknow permission checked
      return await PermissionHandler()
          .requestPermissions([PermissionGroup.location]).then(
              (Map<PermissionGroup, PermissionStatus> status) async {
        if (status[PermissionGroup.location].value == 2) {
          //2 is granted
          return true;
        } else {
          //denied
          return false;
        }
      });
    } else {
      //granted
      return true;
    }
  }
}

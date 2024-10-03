// ignore_for_file: avoid_print



import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../common/config.dart';

Future<void> initPlatformState({context}) async {
  OneSignal.shared.setAppId(Config.oneSignel).then((value) {
    print("accepted123:------  ");
  });
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    print("accepted:------   $accepted");
  });
  OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
    print("Accepted OSPermissionStateChanges : $changes");
  });

}
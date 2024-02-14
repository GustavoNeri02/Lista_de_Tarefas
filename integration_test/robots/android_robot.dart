import 'package:patrol/patrol.dart';

class AndroidRobot {
  final PatrolIntegrationTester $;

  AndroidRobot(this.$);

  Future<void> goBack() async {
    await $.native.pressBack();
    await $.pumpAndSettle();
    await Future.delayed(Duration(seconds: 1));
  }

  Future<void> grantPermissionWhenInUse() async {
    if (await $.native.isPermissionDialogVisible(timeout: Duration(seconds: 5)))
      await $.native.grantPermissionWhenInUse();
  }

  Future<void> denyPermission() async {
    if (await $.native.isPermissionDialogVisible(timeout: Duration(seconds: 5)))
      await $.native.denyPermission();
  }

  Future<void> grantPermissionOnlyThisTime() async {
    if (await $.native.isPermissionDialogVisible(timeout: Duration(seconds: 5)))
      await $.native.grantPermissionOnlyThisTime();
  }

  Future<void> pickMedia() async {
    await $.native
        .tap(Selector(pkg: 'com.google.android.providers.media.module'));
    await $.pumpAndSettle();

    await Future.delayed(Duration(seconds: 1));
  }
}

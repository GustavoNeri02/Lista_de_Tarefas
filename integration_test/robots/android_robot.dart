import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

class AndroidRobot {
  final PatrolIntegrationTester $;

  AndroidRobot(this.$);

  /// Finders

  Future<void> findImagePickerModal() async {
    final List<NativeView> nativeViews = await $.native.getNativeViews(Selector(
      resourceId: 'com.google.android.providers.media.module:id/bottom_sheet',
      pkg: 'com.google.android.providers.media.module',
    ));
    expect(nativeViews, isNotEmpty);
  }

  /// Actions

  Future<void> goBack() async {
    await $.native.pressBack();
    await $.pumpAndSettle();
    await Future.delayed(Duration(seconds: 1));
  }

  Future<void> getPermission(bool isGranted) async {
    if (await $.native
        .isPermissionDialogVisible(timeout: Duration(seconds: 5))) {
      if (isGranted)
        await $.native.grantPermissionWhenInUse();
      else
        await $.native.denyPermission();
    }
  }

  Future<void> pickMedia() async {
    await findImagePickerModal();
    await $.native
        .tap(Selector(pkg: 'com.google.android.providers.media.module'));

    await $.pumpAndSettle();
  }
}

import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:lista_de_tarefas/main.dart' as app;

void main() {
  patrolTest(
    'counter state is the same after going to home and switching apps',
    ($) async {
      app.main();
      await $.pumpAndSettle();

      expect($('Patrol Poc'), findsNothing);

      await $.native.pressHome();
      await $.native.pressRecentApps();

      await $.pumpAndSettle();
    },
    nativeAutomation: true,
  );
}

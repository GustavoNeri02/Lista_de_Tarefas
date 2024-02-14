import 'package:flutter_test/flutter_test.dart';
import 'package:lista_de_tarefas/main.dart';
import 'package:patrol/patrol.dart';

import 'robots/android_robot.dart';
import 'robots/home_robot.dart';

void main() {
  group(
    'Home Page',
    () {
      patrolTest(
        'Validar elementos da página.',
        ($) async {
          await $.pumpWidgetAndSettle(MyApp());
          final homeRobot = HomeRobot($);

          await homeRobot.findAtualDateWidget();
          await homeRobot.findUserAvatar();
          await homeRobot.findAddTarefaButton();
        },
      );
      patrolTest(
        'Verificar se o Widget AtualDateWidget está exibindo a data atual.',
        ($) async {
          await $.pumpWidgetAndSettle(MyApp());
          final homeRobot = HomeRobot($);

          await homeRobot.findAtualDateWidget();
        },
      );
      patrolTest(
        'Tentar exibir modal de Seleção de Imagem do UserAvatar',
        ($) async {
          await $.pumpWidgetAndSettle(MyApp());
          final homeRobot = HomeRobot($);
          final androidRobot = AndroidRobot($);

          await homeRobot.tapUserAvatar();
          await androidRobot.grantPermissionWhenInUse();
          await androidRobot.pickMedia();

          await $.pumpAndSettle();
        },
        nativeAutomation: true,
      );
    },
  );
}

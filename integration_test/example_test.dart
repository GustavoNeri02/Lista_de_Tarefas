import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lista_de_tarefas/app/modules/home/home_module.dart';
import 'package:lista_de_tarefas/main.dart';
import 'package:patrol/patrol.dart';

import 'robots/android_robot.dart';
import 'robots/home_robot.dart';

void main() {
  group(
    'Home Page',
    () {
      // widget test
      patrolTest(
        'Validar elementos da página.',
        ($) async {
          await $.pumpWidgetAndSettle(MyApp());
          final homeRobot = HomeRobot($);

          await homeRobot.findAtualDateWidget();
          await homeRobot.findUserAvatar();
          await homeRobot.findAddTarefaButton();
          await homeRobot.findTodoList();
          expect(Modular.initialRoute, HomeModule.routeName);
        },
        tags: 'validatePageElements',
      );

      // widget test
      patrolTest(
        'Verificar se o Widget AtualDateWidget está exibindo a data atual.',
        ($) async {
          await $.pumpWidgetAndSettle(MyApp());
          final homeRobot = HomeRobot($);

          await homeRobot.verifyAtualDateWidget();
        },
        tags: 'verifyAtualDateWidget',
      );

      // integration test
      group('UserAvatar', () {
        patrolTest(
          'Tentar exibir modal de Seleção de Imagem do UserAvatar se permissão concedida',
          ($) async {
            await $.pumpWidgetAndSettle(MyApp());
            final homeRobot = HomeRobot($);
            final androidRobot = AndroidRobot($);

            await homeRobot.tapUserAvatar();
            await androidRobot.getPermission(true);
            await androidRobot.findImagePickerModal();
            await $.native.pressBack();

            await $.pumpAndSettle();
          },
          nativeAutomation: true,
          tags: 'findImagePicker',
        );
        patrolTest(
          'Tentar inserir foto no avatar',
          ($) async {
            await $.pumpWidgetAndSettle(MyApp());
            final homeRobot = HomeRobot($);
            final androidRobot = AndroidRobot($);

            await homeRobot.tapUserAvatar();
            await androidRobot.getPermission(true);
            await androidRobot.pickMedia();
            await homeRobot.findUserAvatar(hasImage: true);

            await $.pumpAndSettle();
          },
          nativeAutomation: true,
          tags: 'insertAvatarImage',
        );
        patrolTest(
          'Tentar deletar foto no avatar',
          ($) async {
            await $.pumpWidgetAndSettle(MyApp());
            final homeRobot = HomeRobot($);
            final androidRobot = AndroidRobot($);

            await homeRobot.tapUserAvatar();
            await androidRobot.getPermission(true);
            await androidRobot.pickMedia();
            await homeRobot.findUserAvatar(hasImage: true);

            await homeRobot.tapUserAvatar();
            await androidRobot.goBack();
            await homeRobot.findUserAvatar(hasImage: false);

            await $.pumpAndSettle();
          },
          nativeAutomation: true,
          tags: 'deleteAvatarImage',
        );
      });

      group('Tarefas', () {
        patrolTest(
          'Inserir nova Tarefa',
          ($) async {
            await $.pumpWidgetAndSettle(MyApp());
            final homeRobot = HomeRobot($);

            await homeRobot.tapAddTarefaButton();
            await homeRobot.findAddTarefaModal();
            await homeRobot.insertTarefaTitle('teste tarefa');
            await homeRobot.tapAddTarefaModalOkButton();

            await homeRobot.findUserAvatar(hasImage: false);

            await $.pumpAndSettle();
          },
          tags: 'insertNewTarefa',
        );
      });
    },
  );
}

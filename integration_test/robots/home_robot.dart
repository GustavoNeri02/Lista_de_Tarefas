import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lista_de_tarefas/utils/date_time_extension_utils.dart';
import 'package:lista_de_tarefas/utils/keys.dart';
import 'package:path_provider/path_provider.dart';
import 'package:patrol/patrol.dart';

class HomeRobot {
  final PatrolIntegrationTester $;

  HomeRobot(this.$);

  /// Finders

  Future<void> findUserAvatar({bool? hasImage}) async {
    expect($(Keys.userAvatar), findsOneWidget);
    if (hasImage ?? false) {
      expect($(Keys.userAvatar).$(Icons.person_add), findsNothing);
      final directory = await getApplicationDocumentsDirectory();
      final File imageFile = File("${directory.path}/image_avatar.png");
      expect(imageFile.existsSync(), true);
    }
  }

  Future<void> findAddTarefaButton() async {
    expect($(Keys.addTarefaButton), findsOneWidget);
  }

  Future<void> findTodoList() async {
    expect($(Keys.todoList), findsOneWidget);
  }

  Future<void> findAtualDateWidget() async {
    expect($(Keys.atualDateWidget), findsOneWidget);
  }

  Future<void> findAddTarefaModal() async {
    expect($(Keys.addTarefaModal), findsOneWidget);
  }

  /// Actions

  Future<void> verifyAtualDateWidget() async {
    final DateTime now = DateTime.now();
    await findAtualDateWidget();
    expect($(Keys.atualDateWidget).$(now.day.toString()), findsOneWidget);
    expect(
      $(Keys.atualDateWidget).$(DateTimeExtension.weekDays[now.weekday]),
      findsOneWidget,
    );
    expect(
      $(Keys.atualDateWidget).$(
        "${DateTimeExtension.monthsYear[now.month - 1]} ${now.year}",
      ),
      findsOneWidget,
    );
  }

  Future<void> tapUserAvatar() async {
    await findUserAvatar();
    await $(Keys.userAvatar).tap();
    await $.pumpAndSettle();
    await Future.delayed(Duration(seconds: 1));
  }

  Future<void> tapAddTarefaButton() async {
    await findAddTarefaButton();
    await $(Keys.addTarefaButton).tap();
    await $.pumpAndSettle();
    await Future.delayed(Duration(seconds: 1));
  }

  Future<void> insertTarefaTitle(String title) async {
    await findAddTarefaModal();
    await $.pumpAndSettle();
    await $(Keys.addTarefaTitleTextField).enterText(title);
    await $.pumpAndSettle();
  }

  Future<void> tapAddTarefaModalOkButton() async {
    await findAddTarefaModal();
    await $(Keys.addTarefaModal).$(Keys.addTarefaModalOkButton).tap();
    await $.pumpAndSettle();
    await Future.delayed(Duration(seconds: 1));
  }
}
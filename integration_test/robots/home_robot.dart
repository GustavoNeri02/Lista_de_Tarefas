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
    expect($(Keys.userAvatarWidget), findsOneWidget);
    if (hasImage ?? false) {
      expect($(Keys.userAvatarWidget).$(Icons.person_add), findsNothing);
      final directory = await getApplicationDocumentsDirectory();
      final File imageFile = File("${directory.path}/image_avatar.png");
      expect(imageFile.existsSync(), true);
    }
  }

  Future<void> findAddTarefaButton() async {
    expect($(Keys.addTarefaButton), findsOneWidget);
  }

  Future<void> findTodoList() async {
    expect($(Keys.toDoListBodyWidget), findsOneWidget);
  }

  Future<void> findAtualDateWidget() async {
    expect($(Keys.currentDateWidget), findsOneWidget);
  }

  Future<void> findAddTarefaModal() async {
    expect($(Keys.addTarefaModal), findsOneWidget);
  }

  Future<void> findItemTarefaWidget(int index) async {
    expect($(Keys.itemTarefaDismissableWidget(index)), findsOneWidget);
  }

  Future<void> findToDoListLocalFileContent() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File("${directory.path}/listaData.json");

    expect(file.existsSync(), equals(true));

    final String content = await file.readAsString();

    expect(content.isNotEmpty, equals(true));
  }

  /// Actions

  Future<void> verifyAtualDateWidget() async {
    final DateTime now = DateTime.now();
    await findAtualDateWidget();
    expect($(Keys.currentDateWidget).$(now.day.toString()), findsOneWidget);
    expect(
      $(Keys.currentDateWidget).$(DateTimeExtension.weekDays[now.weekday]),
      findsOneWidget,
    );
    expect(
      $(Keys.currentDateWidget).$(
        "${DateTimeExtension.monthsYear[now.month - 1]} ${now.year}",
      ),
      findsOneWidget,
    );
  }

  Future<void> tapUserAvatar() async {
    await findUserAvatar();
    await $(Keys.userAvatarWidget).tap();
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

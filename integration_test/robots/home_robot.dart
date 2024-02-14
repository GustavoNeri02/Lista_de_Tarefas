import 'package:flutter_test/flutter_test.dart';
import 'package:lista_de_tarefas/utils/date_time_extension_utils.dart';
import 'package:lista_de_tarefas/utils/keys.dart';
import 'package:patrol/patrol.dart';

class HomeRobot {
  final PatrolIntegrationTester $;

  HomeRobot(this.$);

  /// Finders

  Future<void> findUserAvatar() async {
    expect($(Keys.userAvatar), findsOneWidget);
  }

  Future<void> findAddTarefaButton() async {
    expect($(Keys.addTarefaButton), findsOneWidget);
  }

  Future<void> findTodoList() async {
    expect($(Keys.todoList), findsOneWidget);
  }

  Future<void> findAtualDateWidget() async {
    final DateTime now = DateTime.now();
    expect($(Keys.atualDateWidget), findsOneWidget);
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

  /// Actions

  Future<void> tapUserAvatar() async {
    await findUserAvatar();
    await $(Keys.userAvatar).tap();
    await Future.delayed(Duration(seconds: 1));
  }
}

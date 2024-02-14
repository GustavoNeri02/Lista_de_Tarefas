import 'package:flutter_test/flutter_test.dart';
import 'package:lista_de_tarefas/main.dart';
import 'package:lista_de_tarefas/utils/date_time_extension_utils.dart';
import 'package:lista_de_tarefas/widgets/atual_date_widget.dart';
import 'package:patrol/patrol.dart';

void main() {
  group(
    'Home Page',
    () {
      patrolTest(
        'AtualDateWidget test',
        ($) async {
          await $.pumpWidgetAndSettle(MyApp());
          final DateTime now = DateTime.now();
          expect($(AtualDateWidget), findsOneWidget);
          expect($(AtualDateWidget).$(now.day.toString()), findsOneWidget);
          expect(
            $(AtualDateWidget).$(DateTimeExtension.weekDays[now.weekday]),
            findsOneWidget,
          );
          expect(
            $(AtualDateWidget).$(
              "${DateTimeExtension.monthsYear[now.month - 1]} ${now.year}",
            ),
            findsOneWidget,
          );
        },
        nativeAutomation: true,
        tags: 'AtualDateWidget',
      );
    },
  );
}

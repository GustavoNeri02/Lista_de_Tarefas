import 'package:flutter_modular/flutter_modular.dart';
import 'package:lista_de_tarefas/app/modules/home/presentation/controllers/avatar_controller.dart';
import 'package:lista_de_tarefas/app/modules/home/presentation/controllers/to_do_list_controller.dart';

import 'data/datasources/local_datasource.dart';
import 'presentation/pages/home_page.dart';

class HomeModule extends Module {
  static const String routeName = '/homePage';
  static const String initialRoute = '$routeName/';

  @override
  List<Bind<Object>> get binds => [
        Bind(
          (i) => LocalDataSource(),
        ),
        Bind(
          (i) => AvatarController(),
        ),
        Bind(
          (i) => ToDoListController(i()),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (context, args) => HomePage(),
        )
      ];
}

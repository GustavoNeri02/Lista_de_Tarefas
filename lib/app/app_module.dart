import 'package:flutter_modular/flutter_modular.dart';
import 'package:lista_de_tarefas/app/modules/home/home_module.dart';

class AppModule extends Module {
  static const String initialRoute = HomeModule.initialRoute;

  @override
  List<Module> get imports => [
        HomeModule(),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(
          HomeModule.routeName,
          module: HomeModule(),
        )
      ];
}

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lista_de_tarefas/app/modules/home/presentation/controllers/avatar_controller.dart';
import 'package:lista_de_tarefas/app/modules/home/presentation/controllers/to_do_list_controller.dart';
import 'package:lista_de_tarefas/app/modules/home/presentation/widgets/to_do_list_body_widget.dart';
import 'package:lista_de_tarefas/utils/keys.dart';
import 'package:lista_de_tarefas/app/modules/home/presentation/widgets/atual_date_widget.dart';
import 'package:lista_de_tarefas/app/modules/home/presentation/widgets/icon_avatar.dart';

import '../widgets/add_tarefa_modal_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final toDoListController = Modular.get<ToDoListController>();
  final avatarController = Modular.get<AvatarController>();

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await toDoListController.fetchToDoList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0XFF6200b3), Color(0XFF8B54C9)],
                stops: [0, 0.7],
                transform: GradientRotation(0.3),
                tileMode: TileMode.repeated,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: SafeArea(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconAvatarWidget(
                        controller: avatarController,
                      ),
                      IconButton(
                        key: Keys.addTarefaButton,
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          toDoListController.textController.text = "";
                          AddTarefaModal.show(
                            context: context,
                            toDoListController: toDoListController,
                          );
                        },
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  AtualDateWidget(),
                  SizedBox(height: 20),
                  ToDoListBodyWidget(controller: toDoListController)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

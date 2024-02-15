import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lista_de_tarefas/app/modules/home/presentation/controllers/to_do_list_controller.dart';

import '../../../../../utils/keys.dart';
import 'item_tarefa_widget.dart';
import 'on_empty_message_widget.dart';

class ToDoListBodyWidget extends StatelessWidget {
  final ToDoListController controller;
  ToDoListBodyWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      key: Keys.todoList,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: RefreshIndicator(
            onRefresh: controller.refresh,
            child: Observer(
              builder: (context) => controller.toDoList.isEmpty
                  ? EmptyMessageWidget()
                  : ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      itemCount: controller.toDoList.length,
                      itemBuilder: (context, index) {
                        return ItemTarefaWidget(
                          controller: controller,
                          index: index,
                        );
                      },
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

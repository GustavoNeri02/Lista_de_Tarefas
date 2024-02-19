import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lista_de_tarefas/app/modules/home/presentation/widgets/undo_delete_tarefa_snackbar_widget.dart';
import 'package:lista_de_tarefas/utils/keys.dart';

import '../controllers/to_do_list_controller.dart';

class ItemTarefaWidget extends StatelessWidget {
  const ItemTarefaWidget({
    Key? key,
    required this.controller,
    required this.index,
  }) : super(key: key);

  final ToDoListController controller;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Keys.itemTarefaDismissableWidget(index),
      background: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.delete,
                color: Colors.red,
                size: 40,
              ),
              Icon(
                Icons.delete,
                color: Colors.red,
                size: 40,
              )
            ],
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 5),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black,
                  blurRadius: 4,
                  spreadRadius: -3,
                  offset: Offset(0, 0))
            ],
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [Color(0XFFe2cfea), Color(0XFF8B54C9), Color(0XFF6200b3)],
              stops: [0, 0.75, 1],
              transform: GradientRotation(0.3),
              tileMode: TileMode.repeated,
            ),
          ),
          child: ListTile(
            title: Text(
              controller.toDoList[index]["title"],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.rubik(
                  fontSize: 20,
                  color: Colors.black,
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      blurRadius: 0.2,
                      offset: Offset(0, 0),
                    )
                  ]),
            ),
            trailing: Observer(builder: (_) {
              return CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 15,
                child: controller.toDoList[index]["ok"]
                    ? Icon(
                        Icons.star,
                        color: Colors.yellow,
                      )
                    : Icon(Icons.star_border),
              );
            }),
            onTap: () => controller.handleTapStar(index),
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
          ),
        ),
      ),
      direction: DismissDirection.horizontal,
      onDismissed: (direction) {
        controller.onDismissedTarefa(index);

        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          UndoDeleteTarefaSnackBar(
            lastRemoved: controller.lastRemoved,
            controller: controller,
            lastRemovedPos: controller.lastRemovedPos,
          ),
        );
      },
    );
  }
}

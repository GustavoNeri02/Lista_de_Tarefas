import 'package:flutter/material.dart';

import '../controllers/to_do_list_controller.dart';

class UndoDeleteTarefaSnackBar extends SnackBar {
  final ToDoListController controller;

  UndoDeleteTarefaSnackBar(
      {required Map<String, dynamic> lastRemoved,
      required this.controller,
      required int? lastRemovedPos})
      : super(
          content: Text("Tarefa \"${lastRemoved["title"]}\" removida!"),
          action: SnackBarAction(
            label: "Desfazer",
            onPressed: () {
              controller.undoDelete(
                lastRemovedPosition: lastRemovedPos!,
                lastRemoved: lastRemoved,
              );
            },
          ),
          duration: Duration(seconds: 2),
        );
}

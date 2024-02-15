import 'package:flutter/material.dart';

import '../../../../../utils/keys.dart';
import '../controllers/to_do_list_controller.dart';

class AddTarefaModal {
  AddTarefaModal._();
  static Future<dynamic> show({
    required BuildContext context,
    required ToDoListController toDoListController,
  }) async {
    final result = await showDialog(
      context: context,
      builder: (_) => AddTarefaModalContent(
        toDoListController: toDoListController,
      ),
    );

    return result;
  }
}

class AddTarefaModalContent extends StatelessWidget {
  const AddTarefaModalContent({
    Key? key,
    required this.toDoListController,
  }) : super(key: key);

  final ToDoListController toDoListController;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: Keys.addTarefaModal,
      title: Text("Adicionar nova tarefa"),
      content: TextField(
        key: Keys.addTarefaTitleTextField,
        controller: toDoListController.textController,
        decoration: InputDecoration(
          labelText: "Digite aqui",
        ),
      ),
      actions: [
        TextButton(
          child: Text("Cancelar"),
          key: Keys.addTarefaModalCancelarButton,
          onPressed: () {
            toDoListController.handleTapAddTarefaCancelarButton();
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: Text("Ok"),
          key: Keys.addTarefaModalOkButton,
          onPressed: () {
            toDoListController.handleTapAddTarefaOkButton();

            Navigator.pop(context);
          },
        )
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}

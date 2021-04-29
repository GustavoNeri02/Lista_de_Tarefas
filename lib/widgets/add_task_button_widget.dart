import 'package:flutter/material.dart';

class AddTaskButton extends StatefulWidget {
  final textEditingController;
  const AddTaskButton({Key key, this.textEditingController}) : super(key: key);
  @override
  _AddTaskButtonState createState() => _AddTaskButtonState();
}

class _AddTaskButtonState extends State<AddTaskButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.add),
      onPressed: () {
        widget.textEditingController.text = "";
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Adicionar nova tarefa"),
                content: TextField(
                  controller: widget.textEditingController,
                  decoration: InputDecoration(labelText: "Digite aqui"),
                ),
                actions: [
                  TextButton(
                    child: Text("Cancelar"),
                    onPressed: () {
                      widget.textEditingController.text = "";
                      Navigator.pop(context);
                    },
                  ),
                  TextButton(
                    child: Text("Ok"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            });
      },
    );
  }
}

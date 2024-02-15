import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lista_de_tarefas/controllers/to_do_list_controller.dart';
import 'package:lista_de_tarefas/utils/keys.dart';
import 'package:lista_de_tarefas/widgets/atual_date_widget.dart';
import 'package:lista_de_tarefas/widgets/icon_avatar.dart';

import '../widgets/on_empty_message_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = ToDoListController();

  Map<String, dynamic> _lastRemoved = {};
  int? _lastRemovedPos;

  Widget itemBuilder(context, index) {
    return Dismissible(
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
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
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
            trailing: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 15,
              child: controller.toDoList[index]["ok"]
                  ? Icon(
                      Icons.star,
                      color: Colors.yellow,
                    )
                  : Icon(Icons.star_border),
            ),
            onTap: () {
              setState(() {
                controller.toDoList[index]["ok"] =
                    !controller.toDoList[index]["ok"];
                controller.saveToDoList();
              });
            },
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
          ),
        ),
      ),
      direction: DismissDirection.horizontal,
      onDismissed: (direction) {
        setState(() {
          _lastRemoved = Map.from(controller.toDoList[index]);
          _lastRemovedPos = index;
          controller.toDoList.removeAt(index);

          controller.saveToDoList();

          final _snackbar = SnackBar(
            content: Text("Tarefa \"${_lastRemoved["title"]}\" removida!"),
            action: SnackBarAction(
              label: "Desfazer",
              onPressed: () {
                setState(() {
                  controller.toDoList.insert(_lastRemovedPos!, _lastRemoved);
                  controller.saveToDoList();
                });
              },
            ),
            duration: Duration(seconds: 2),
          );
          //evitar pilhas de snack bars
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(_snackbar);
        });
      },
    );
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await controller.fetchToDoList();
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
                      IconAvatarWidget(),
                      //adicionar tarefas
                      IconButton(
                        key: Keys.addTarefaButton,
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          controller.textController.text = "";
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  key: Keys.addTarefaModal,
                                  title: Text("Adicionar nova tarefa"),
                                  content: TextField(
                                    key: Keys.addTarefaTitleTextField,
                                    controller: controller.textController,
                                    decoration: InputDecoration(
                                      labelText: "Digite aqui",
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      child: Text("Cancelar"),
                                      key: Keys.addTarefaModalCancelarButton,
                                      onPressed: () {
                                        controller.textController.text = "";
                                        Navigator.pop(context);
                                      },
                                    ),
                                    TextButton(
                                      child: Text("Ok"),
                                      key: Keys.addTarefaModalOkButton,
                                      onPressed: () {
                                        if (controller.textController.text !=
                                            "") {
                                          setState(() {
                                            controller.addToDo();
                                            controller.saveToDoList();
                                          });
                                        }
                                        Navigator.pop(context);
                                      },
                                    )
                                  ],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                );
                              });
                        },
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  AtualDateWidget(),
                  SizedBox(height: 20),
                  //Lista de widgets
                  Expanded(
                    key: Keys.todoList,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: RefreshIndicator(
                          onRefresh: () async {
                            await controller.refresh();
                            setState(() {});
                          },
                          child: controller.toDoList.isEmpty
                              ? EmptyMessage()
                              : ListView.builder(
                                  physics: AlwaysScrollableScrollPhysics(
                                    parent: BouncingScrollPhysics(),
                                  ),
                                  itemCount: controller.toDoList.length,
                                  itemBuilder: itemBuilder,
                                ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lista_de_tarefas/controller_json.dart';
import 'package:lista_de_tarefas/widgets/atual_date_widget.dart';
import 'package:lista_de_tarefas/widgets/icon_avatar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textController = new TextEditingController();
  ControllerJson controllerJson = new ControllerJson();
  List toDoList = [];
  Map<String, dynamic> _lastRemoved = {};
  int? _lastRemovedPos;

  void addToDo() {
    Map<String, dynamic> newToDo = Map();
    newToDo["title"] = textController.text;
    newToDo["ok"] = false;
    toDoList.add(newToDo);
    controllerJson.saveFileData(toDoList);
  }

  Future<Null> _refresh() async {
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      toDoList.sort((a, b) {
        return a['title'].toLowerCase().compareTo(b['title'].toLowerCase());
      });
      toDoList.sort((a, b) {
        if (a["ok"] && !b["ok"])
          return 1;
        else if (!a["ok"] && b["ok"])
          return -1;
        else
          return 0;
      });
      controllerJson.saveFileData(toDoList);
    });

    return null;
  }

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
            gradient: LinearGradient(colors: [
              Color(0XFFe2cfea),
              Color(0XFF8B54C9),
              Color(0XFF6200b3)
            ], stops: [
              0,
              0.9,
              1
            ], transform: GradientRotation(0.3), tileMode: TileMode.repeated),
          ),
          child: ListTile(
            title: Text(
              toDoList[index]["title"],
              style: GoogleFonts.rubik(
                  fontSize: 20,
                  color: Colors.black,
                  shadows: [
                    Shadow(
                        color: Colors.black,
                        blurRadius: 0.5,
                        offset: Offset(0, 0))
                  ]),
            ),
            trailing: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 15,
              child: toDoList[index]["ok"]
                  ? Icon(
                      Icons.auto_awesome,
                      color: Colors.yellow,
                    )
                  : Icon(Icons.star_border),
            ),
            onTap: () {
              setState(() {
                toDoList[index]["ok"] = !toDoList[index]["ok"];
                controllerJson.saveFileData(toDoList);
              });
            },
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
          ),
        ),
      ),
      direction: DismissDirection.horizontal,
      onDismissed: (direction) {
        setState(() {
          _lastRemoved = Map.from(toDoList[index]);
          _lastRemovedPos = index;
          toDoList.removeAt(index);

          controllerJson.saveFileData(toDoList);

          final _snackbar = SnackBar(
            content: Text("Tarefa \"${_lastRemoved["title"]}\" removida!"),
            action: SnackBarAction(
              label: "Desfazer",
              onPressed: () {
                setState(() {
                  toDoList.insert(_lastRemovedPos!, _lastRemoved);
                  controllerJson.saveFileData(toDoList);
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
  void initState() {
    super.initState();

    controllerJson.readData().then((value) => {
          setState(() {
            toDoList = jsonDecode(value ?? '');
          })
        });
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
                  tileMode: TileMode.repeated),
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
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          textController.text = "";
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Adicionar nova tarefa"),
                                  content: TextField(
                                    controller: textController,
                                    decoration: InputDecoration(
                                        labelText: "Digite aqui"),
                                  ),
                                  actions: [
                                    TextButton(
                                      child: Text("Cancelar"),
                                      onPressed: () {
                                        textController.text = "";
                                        Navigator.pop(context);
                                      },
                                    ),
                                    TextButton(
                                      child: Text("Ok"),
                                      onPressed: () {
                                        if (textController.text != "") {
                                          setState(() {
                                            addToDo();
                                            controllerJson
                                                .saveFileData(toDoList);
                                          });
                                        }
                                        Navigator.pop(context);
                                      },
                                    )
                                  ],
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
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
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        child: RefreshIndicator(
                          onRefresh: _refresh,
                          child: toDoList.isEmpty
                              ? Center(
                                  child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Sua listinha ta vazia bb",
                                      style: GoogleFonts.rubik(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w200,
                                          shadows: [
                                            Shadow(
                                                color: Colors.black,
                                                offset: Offset(0, 0),
                                                blurRadius: 2)
                                          ]),
                                    ),
                                    Icon(Icons.add_task)
                                  ],
                                ))
                              : ListView.builder(
                                  itemCount: toDoList.length,
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

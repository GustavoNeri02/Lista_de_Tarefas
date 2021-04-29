import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/widgets/add_task_button_widget.dart';
import 'package:lista_de_tarefas/widgets/atual_date_widget.dart';
import 'package:lista_de_tarefas/widgets/icon_avatar.dart';
import 'package:path_provider/path_provider.dart';

class HomePage extends StatefulWidget {
  final TextEditingController textController = new TextEditingController();
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List toDoList = [];
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
                  transform: GradientRotation(0.3)),
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
                      AddTaskButton(
                          textEditingController: widget.textController),
                    ],
                  ),
                  SizedBox(height: 10),
                  AtualDateWidget()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  //Pegar arquivo .json
  Future<File> _getFile() async {
    //pegando diretorio tanto de android como de ios
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/listaData.json");
  }

  //Salvar arquivo .json
  Future<File> _saveFileData() async {
    String data = json.encode(toDoList);
    final file = await _getFile();
    return file.writeAsString(data);
  }

  //Ler arquivo .json
  Future<String> _readData() async {
    try {
      final file = await _getFile();
      return file.readAsString();
    } catch (e) {
      return null;
    }
  }
}
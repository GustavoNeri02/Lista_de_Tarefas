import 'dart:convert';

import 'package:flutter/material.dart';

import '../datasources/local_datasource.dart';

class ToDoListController {
  TextEditingController textController = new TextEditingController();
  LocalDataSource localDataSource = new LocalDataSource();

  List toDoList = [];

  void addToDo() {
    Map<String, dynamic> newToDo = Map();
    newToDo["title"] = textController.text;
    newToDo["ok"] = false;
    toDoList.add(newToDo);
    localDataSource.saveFileData(toDoList);
  }

  Future<void> refresh() async {
    await Future.delayed(Duration(seconds: 1));

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
    await localDataSource.saveFileData(toDoList);
  }

  Future<void> fetchToDoList() async {
    final String? fileData = await localDataSource.readData();
    toDoList = fileData != null ? jsonDecode(fileData) : [];
  }

  Future<void> saveToDoList() async {
    return await localDataSource.saveFileData(toDoList);
  }
}

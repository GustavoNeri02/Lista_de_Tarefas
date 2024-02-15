import 'dart:convert';

import 'package:flutter/material.dart';

import '../../data/datasources/local_datasource.dart';

import 'package:mobx/mobx.dart';
part 'to_do_list_controller.g.dart';

class ToDoListController = _ToDoListControllerBase with _$ToDoListController;

abstract class _ToDoListControllerBase with Store {
  TextEditingController textController = new TextEditingController();
  final LocalDataSource _localDataSource;

  _ToDoListControllerBase(this._localDataSource);

  @observable
  ObservableList<Map<String, dynamic>> toDoList = ObservableList();

  Map<String, dynamic> lastRemoved = {};
  int? lastRemovedPos;

  @action
  Future<void> addToDo() async {
    Map<String, dynamic> newToDo = Map();
    newToDo["title"] = textController.text;
    newToDo["ok"] = false;
    toDoList.add(newToDo);
    await _localDataSource.saveFileData(toDoList);
  }

  @action
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
    await _localDataSource.saveFileData(toDoList);
  }

  @action
  Future<void> fetchToDoList() async {
    final String? fileData = await _localDataSource.readData();
    if (fileData != null) {
      final savedList = jsonDecode(fileData);
      toDoList = List<Map<String, dynamic>>.from(savedList).asObservable();
    }
  }

  @action
  Future<void> undoDelete({
    required int lastRemovedPosition,
    required Map<String, dynamic> lastRemoved,
  }) async {
    toDoList.insert(lastRemovedPosition, lastRemoved);
    await saveToDoList();
  }

  Future<void> saveToDoList() async {
    return await _localDataSource.saveFileData(toDoList);
  }

  Future<void> onDismissedTarefa(int index) async {
    lastRemoved = Map.from(toDoList[index]);
    lastRemovedPos = index;
    toDoList.removeAt(index);

    await saveToDoList();
  }

  @action
  Future<void> handleTapStar(int index) async {
    toDoList[index]["ok"] = !toDoList[index]["ok"];
    toDoList = toDoList.asObservable();
    await saveToDoList();
  }

  Future<void> handleTapAddTarefaOkButton() async {
    if (textController.text != "") {
      await addToDo();
      await saveToDoList();
    }
  }

  @action
  Future<void> handleTapAddTarefaCancelarButton() async {
    textController.text = "";
  }
}

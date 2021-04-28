import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List toDoList = [];
  @override
  Widget build(BuildContext context) {
    return Container();
  }


  //Pegar arquivo .json
  Future<File> _getFile() async{
    //pegando diretorio tanto de android como de ios
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/listaData.json");
  }

  //Salvar arquivo .json
  Future<File> _saveFileData() async{
    String data = json.encode(toDoList);
    final file = await _getFile();
    return file.writeAsString(data);
  }

  //Ler arquivo .json
  Future<String> _readData() async{
    try{
      final file = await _getFile();
      return file.readAsString();
    }catch (e){
      return null;
    }
  }

}



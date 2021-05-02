import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class ControllerJson {

//Pegar arquivo .json
  Future<File> getFile() async {
    //pegando diretorio tanto de android como de ios
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/listaData.json");
  }

//Salvar arquivo .json
  Future<File> saveFileData(List toDoList) async {
    String data = json.encode(toDoList);
    final file = await getFile();
    return file.writeAsString(data);
  }

//Ler arquivo .json
  Future<String> readData() async {
    try {
      final file = await getFile();
      return file.readAsString();
    } catch (e) {
      return null;
    }
  }
}

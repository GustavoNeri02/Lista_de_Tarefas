import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class LocalDataSource {
  //Pegar arquivo .json
  Future<File> getFile() async {
    //pegando diretorio tanto de android como de ios
    final directory = await getApplicationDocumentsDirectory();
    final file = File("${directory.path}/listaData.json");
    return file;
  }

//Salvar arquivo .json
  Future<void> saveFileData(List toDoList) async {
    final file = await getFile();
    if (toDoList.isEmpty) {
      if (file.existsSync()) file.deleteSync();
    } else {
      String data = json.encode(toDoList);
      if (!file.existsSync()) file.createSync();
      file.writeAsString(data);
    }
  }

//Ler arquivo .json
  Future<String?> readData() async {
    try {
      final file = await getFile();
      if (!file.existsSync()) return null;

      return file.readAsString();
    } catch (e) {
      return null;
    }
  }
}

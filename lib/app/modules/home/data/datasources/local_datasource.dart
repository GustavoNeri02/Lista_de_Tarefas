import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class LocalDataSource {
  Future<File> getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File("${directory.path}/listaData.json");
    return file;
  }

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

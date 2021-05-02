import 'dart:io';

import 'package:path_provider/path_provider.dart';

class ControllerAvatar {
  Future saveImage(File image) async {

      final directory = await getApplicationDocumentsDirectory();
      image.copy("${directory.path}/image1.png");

  }

  Future<File> getImage() async {
    final directory = await getApplicationDocumentsDirectory();
    if(File("${directory.path}/image1.png").existsSync()){
      return File("${directory.path}/image1.png");
    }else{
      return null;
    }

  }

  Future deleteImage() async {
    final directory = await getApplicationDocumentsDirectory();
    if(File("${directory.path}/image1.png").exists() != null){
      File("${directory.path}/image1.png").delete(recursive: true);
      print(File("${directory.path}/image1.png"));
    }
  }
}

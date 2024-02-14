import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ControllerAvatar {
  Future<File?> handleTapAvatar() async {
    File? _image;
    try {
      final PermissionStatus permission = await Permission.storage.request();
      if (!permission.isGranted) return null;
      final pickedFile =
          await ImagePicker().getImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        _image = File(pickedFile.path);
        saveImage(_image);
      } else {
        deleteImage();
      }

      return _image;
    } catch (e) {
      return null;
    }
  }

  Future saveImage(File image) async {
    final directory = await getApplicationDocumentsDirectory();
    image.copy("${directory.path}/image1.png");
  }

  Future<File?> getImage() async {
    final directory = await getApplicationDocumentsDirectory();
    if (File("${directory.path}/image1.png").existsSync()) {
      return File("${directory.path}/image1.png");
    } else {
      return null;
    }
  }

  Future deleteImage() async {
    final directory = await getApplicationDocumentsDirectory();
    if (await File("${directory.path}/image1.png").exists()) {
      File("${directory.path}/image1.png").delete(recursive: true);
    }
  }
}

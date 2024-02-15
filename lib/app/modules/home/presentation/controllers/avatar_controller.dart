import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:mobx/mobx.dart';

part 'avatar_controller.g.dart';

class AvatarController = AvatarControllerBase with _$AvatarController;

abstract class AvatarControllerBase with Store {
  Future<File?> handleTapAvatar() async {
    File? _image;
    try {
      final PermissionStatus permission = await Permission.storage.request();
      if (!permission.isGranted) return null;
      final pickedFile =
          await ImagePicker().getImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        _image = File(pickedFile.path);
        await saveImage(_image);
      } else {
        await deleteImage();
      }

      return _image;
    } catch (e) {
      return null;
    }
  }

  Future saveImage(File image) async {
    final directory = await getApplicationDocumentsDirectory();
    image.copy("${directory.path}/image_avatar.png");
  }

  Future<File?> getImage() async {
    final directory = await getApplicationDocumentsDirectory();
    final File imageFile = File("${directory.path}/image_avatar.png");
    if (imageFile.existsSync()) {
      return imageFile;
    } else {
      return null;
    }
  }

  Future deleteImage() async {
    final directory = await getApplicationDocumentsDirectory();
    final File imageFile = File("${directory.path}/image_avatar.png");
    if (await imageFile.exists()) {
      imageFile.delete(recursive: true);
    }
  }
}

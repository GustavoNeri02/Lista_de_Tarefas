import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class IconAvatarWidget extends StatefulWidget {
  @override
  _IconAvatarWidgetState createState() => _IconAvatarWidgetState();
}

class _IconAvatarWidgetState extends State<IconAvatarWidget> {
  File _image;
  final picker = ImagePicker();

  Future _getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("Nenhuma imagem selecionada");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.black, width: 3)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: _image == null
                ? Icon(
                    Icons.person_add,
                  )
                : Image.file(
                    _image,
                    fit: BoxFit.cover,
                  ),
          )),
      onTap: () {
        _getImage();
      },
    );
  }
}

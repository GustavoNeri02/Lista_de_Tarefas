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
          height: 75,
          width: 75,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0XFF6200b3), Color(0XFF8B54C9)],
              stops: [0, 0.7],
              transform: GradientRotation(0.3),
            ),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.white, width: 3),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(47),
            child: _image == null
                ? Icon(
                    Icons.person_add,
                    color: Colors.white,
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

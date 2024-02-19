import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/app/modules/home/presentation/controllers/avatar_controller.dart';
import 'package:lista_de_tarefas/utils/keys.dart';

class IconAvatarWidget extends StatefulWidget {
  const IconAvatarWidget({required this.controller});

  @override
  Key? get key => Keys.userAvatarWidget;

  final AvatarController controller;

  @override
  _IconAvatarWidgetState createState() => _IconAvatarWidgetState();
}

class _IconAvatarWidgetState extends State<IconAvatarWidget> {
  File? _image;

  @override
  void initState() {
    super.initState();
    setState(() {
      widget.controller.getImage().then((value) => _image = value);
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
            borderRadius: BorderRadius.circular(50),
            child: _image == null
                ? Icon(Icons.person_add, color: Colors.white)
                : Image.file(
                    _image!,
                    fit: BoxFit.cover,
                    frameBuilder:
                        (context, child, frame, wasSynchronouslyLoaded) {
                      if (frame != null) return child;
                      return Center(
                          child: CircularProgressIndicator(
                        color: Colors.white,
                      ));
                    },
                  ),
          )),
      onTap: () async {
        final File? newImage = await widget.controller.handleTapAvatar();
        setState(() {
          _image = newImage;
        });
      },
    );
  }
}

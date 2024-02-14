import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyMessage extends StatelessWidget {
  const EmptyMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Não há nada aqui...",
          style: GoogleFonts.rubik(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w200,
            shadows: [
              Shadow(
                color: Colors.black,
                offset: Offset(0, 0),
                blurRadius: 2,
              )
            ],
          ),
        ),
      ],
    ));
  }
}

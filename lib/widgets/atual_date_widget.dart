import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AtualDateWidget extends StatefulWidget {
  @override
  _AtualDateWidgetState createState() => _AtualDateWidgetState();
}

class _AtualDateWidgetState extends State<AtualDateWidget> {
  List<String> _weekDays = [
    "Domingo",
    "Segunda-Feira",
    "Terça-Feira",
    "Quarta-Feira",
    "Quinta-Feira",
    "Sexta-Feira",
    "Sabado",
  ];
  List<String> _monthsYear = [
    "Janeiro",
    "Fevereiro",
    "Março",
    "Abril",
    "Maio",
    "Junho",
    "Julho",
    "Agosto",
    "Setembro",
    "Outubro",
    "Novembro",
    "Dezembro"
  ];
  DateTime now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "${now.day}",
            style: GoogleFonts.rubik(
              color: Colors.white,
              fontSize: 70,
              shadows: [
                Shadow(color: Colors.black, offset: Offset(0, 0), blurRadius: 2)
              ],
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "${_weekDays[now.weekday]}",
                style: GoogleFonts.rubik(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                          color: Colors.black,
                          offset: Offset(0, 0),
                          blurRadius: 2)
                    ]),
              ),
              Text(
                "${_monthsYear[now.month - 1]} ${now.year}",
                style: GoogleFonts.rubik(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w200,
                    shadows: [
                      Shadow(
                          color: Colors.black,
                          offset: Offset(0, 0),
                          blurRadius: 2)
                    ]),
              ),
              SizedBox(
                height: 7,
              )
            ],
          )
        ],
      ),
    );
  }
}

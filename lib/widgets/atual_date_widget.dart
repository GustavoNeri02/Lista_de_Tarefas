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
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black, offset: Offset(1, 3), blurRadius: 10)
          ],
          //border: Border.all(color: Colors.black, width: 2)
          color: Color(0xffcfb1ee)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${now.day}",
            style: GoogleFonts.overpass(color: Colors.black, fontSize: 70),
          ),
          SizedBox(
            width: 5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "${_weekDays[now.weekday]}",
                style: GoogleFonts.overpass(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Text(
                "${_monthsYear[now.month - 1]} ${now.year}\n",
                style: GoogleFonts.overpass(color: Colors.black, fontSize: 10),
              ),
            ],
          )
        ],
      ),
    );
  }
}

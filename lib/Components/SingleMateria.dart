import 'package:flutter/material.dart';
import '../Models/Lezione.dart';

class SingleMateria extends StatelessWidget {
  const SingleMateria({super.key, required this.lezione});

  final Lezione lezione;

  String printMinutes(DateTime Orario) {
    if (Orario.minute < 10) {
      return "0${Orario.minute}";
    } else {
      return "${Orario.minute}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 61, 61, 61),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            lezione.Materia,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          lezione.OrarioFine!=null?Text(
            "${lezione.OrarioInizio.hour}:${printMinutes(lezione.OrarioInizio)} - ${lezione.OrarioFine!.hour}:${printMinutes(lezione.OrarioFine!)}",
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.w300, color: Colors.white),
          ):Text(
            "${lezione.OrarioInizio.hour}:${printMinutes(lezione.OrarioInizio)}",
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.w300, color: Colors.white),
          ), 
        ],
      ),
    );
  }
}

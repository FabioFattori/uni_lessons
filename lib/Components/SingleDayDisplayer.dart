import 'package:flutter/material.dart';
import 'package:uni_lessons/Components/SingleMateria.dart';
import 'package:uni_lessons/Models/Lezione.dart';
import 'package:intl/intl.dart';

class SingleDay extends StatelessWidget {
  SingleDay({super.key, required this.Giorno, required this.ThingsToDo});
  late DateTime Giorno;

  late List<Lezione> ThingsToDo;

  String returnData(context) {
    String locale = Localizations.localeOf(context).languageCode;
    String toReturn = DateFormat.EEEE(locale).format(Giorno);
    toReturn += " " + DateFormat.d(locale).format(Giorno);
    toReturn += " " + DateFormat.MMM(locale).format(Giorno);
    toReturn += " " + DateFormat.y(locale).format(Giorno);
    return toReturn;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: Text(
              returnData(context),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurpleAccent,
              ),
            ),
          ),
          ThingsToDo.isEmpty
              ? const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Nessuna lezione Oggi",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w300,
                          color: Colors.deepPurpleAccent),
                    ),
                  ],
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: ThingsToDo.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SingleMateria(lezione: ThingsToDo[index]);
                  },
                ),
        ],
      ),
    );
  }
}

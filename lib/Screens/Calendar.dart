import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uni_lessons/Components/HeaderBar.dart';
import 'package:uni_lessons/Components/SingleDayDisplayer.dart';
import '../Models/Lezione.dart';
import 'package:excel/excel.dart';
import 'package:intl/intl.dart';

class Calendar extends StatefulWidget {
  Calendar({super.key});
  late List<DateTime> Giorni = [];
  late List<Lezione> ThingsToDo = [];
  DateTime selectedDate = DateTime.now();

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  List<Lezione> getThingsToDoForSelectedDate(DateTime selectedDate) {
    List<Lezione> result = [];
    for (var lezione in widget.ThingsToDo) {
      if (lezione.OrarioInizio.year == selectedDate.year &&
          lezione.OrarioInizio.month == selectedDate.month &&
          lezione.OrarioInizio.day == selectedDate.day) {
        result.add(lezione);
      }
    }
    return result;
  }

  bool checkIfAStringIsADay(String string) {
    if (string.contains("LUNEDI") ||
        string.contains("MARTEDI") ||
        string.contains("MERCOLEDI") ||
        string.contains("GIOVEDI") ||
        string.contains("VENERDI") ||
        string.contains("SABATO") ||
        string.contains("DOMENICA")) {
      return true;
    } else {
      return false;
    }
  }

  DateTime convertToDateTime(String input) {
    // Definisci l'elenco dei nomi dei mesi abbreviati in italiano
    List<String> monthAbbreviations = [
      "gen",
      "feb",
      "mar",
      "apr",
      "mag",
      "giu",
      "lug",
      "ago",
      "sett",
      "ott",
      "nov",
      "dic"
    ];

    // Estra il numero del giorno dal testo
    int dayNumber = int.parse(input.split(' ')[1]);

    // Estra l'abbreviazione del mese dal testo e trova l'indice del mese
    String monthAbbreviation =
        input.split(' ')[2].replaceAll('.', '').toLowerCase();
    int monthIndex = monthAbbreviations.indexOf(monthAbbreviation);

    // Ottieni l'anno corrente
    int currentYear = DateTime.now().year;

    // Crea un oggetto DateTime utilizzando le informazioni ottenute
    DateTime result = DateTime(currentYear, monthIndex + 1, dayNumber);

    return result;
  }

  void CreateLezioniFromFile(List<Data?> row) {
    int counterDays = 0;
    for (var cella in row) {
      if (cella == null) continue;

      if (checkIfAStringIsADay(cella.value.node.text)) {
        //converti in data la stringa composta in questo modo "LUNEDI 25 sett."

        widget.Giorni.add(convertToDateTime(cella.value.node.text));
      } else if (cella.value.node.text.contains("SETTIM.")) {
        widget.Giorni = [];
        counterDays = 0;
        continue;
      } else {
        for (var i = 1; i < row.length; i++) {
          if (row[i] == null) continue;
          var lezione = Lezione(
              row[i]!.value.node.text,
              DateTime.parse(widget.Giorni[counterDays].toString()).add(
                  Duration(
                      hours: int.parse(
                          cella.value.node.text.split('T')[1].split(":")[0]))));
          counterDays++;
          setState(() {
            widget.ThingsToDo.add(lezione);
          });
        }

        return;
      }
    }
  }

  void readExcel() async {
    var file = await rootBundle.load("assets/foglio.xlsx");
    var bytes = file.buffer.asUint8List();
    var excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table]!.rows) {
        CreateLezioniFromFile(row);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    readExcel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 16, 16, 24),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 16, 16, 24),
          title: const Text(
            "Benvenuta BiBi <3",
            style: TextStyle(color: Colors.deepPurpleAccent),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: widget.ThingsToDo.isEmpty
              ? [
                  const Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                          padding: EdgeInsets.all(20),
                          child: CircularProgressIndicator())
                    ],
                  ))
                ]
              : [
                  HeaderBar(
                    OnDateChanged: (newDate) => {
                      setState(
                        () {
                          if (newDate != null) {
                            widget.selectedDate = newDate;
                          }
                        },
                      )
                    },
                  ),
                  SingleDay(
                      Giorno: widget.selectedDate,
                      ThingsToDo:
                          getThingsToDoForSelectedDate(widget.selectedDate)),
                ],
        ));
  }
}
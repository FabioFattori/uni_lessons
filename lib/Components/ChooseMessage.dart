import 'dart:math';

import 'package:uni_lessons/Models/Lezione.dart';

class MyMessages {
  static String getWelcomeMessage() {
    int i = Random().nextInt(5);

    if (i == 0) {
      return "Buongiorno Amore!";
    } else if (i == 1) {
      return "Ti Stai Riposando Abbastanza?";
    } else if (i == 2) {
      return "Bentornata BB!<3";
    } else if (i == 3) {
      return "Ti Stai Riposando? Studia Capra";
    } else {
      return "Hai fatto la spesa?";
    }
  }

  static String notificationMessage(List<Lezione> lezioni) {
    int i = Random().nextInt(4);

    for (var lez in lezioni) {
      if (lez.Materia == "Matematica") i = 4;
    }

    if (lezioni.isEmpty) i = 2;

    if (i == 0) {
      return "Buongiorno Amore! Oggi hai ${lezioni.length} lezioni di ${lezioni.map((e) => e.Materia).toSet().length} materie diverse!";
    } else if (i == 4) {
      return "Ensomma Amore oggi c'è matematica";
    } else if (i == 2) {
      return "Buongiornissimo Cafffffffffffffffffffffffe?";
    } else {
      return "Buongiorno amore! Oggi hai ${lezioni.map((e) => "${e.Materia},")} stai attenta a girare <3";
    }
  }
}

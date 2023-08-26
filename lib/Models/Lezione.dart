class Lezione {
  late String Materia;
  late DateTime OrarioInizio;
  late DateTime? OrarioFine=null;

  Lezione(this.Materia, this.OrarioInizio);

  @override
  bool operator ==(Object other) {
    if (other is Lezione) {
      return Materia == other.Materia &&
          OrarioInizio == other.OrarioInizio;
    } else {
      return false;
    }
  }
}

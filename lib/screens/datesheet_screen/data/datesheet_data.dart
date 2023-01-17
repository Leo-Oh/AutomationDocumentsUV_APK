import 'dart:ffi';

class DataSheet {
  final int date;
  final String monthName;
  final String subjectName;
  final String dayName;
  final String time;

  DataSheet(
      this.date, this.monthName, this.subjectName, this.dayName, this.time);
}

List<DataSheet> dateSheet = [
  DataSheet(11, 'Diciembre', 'Tipo de Tramite', 'Constancia', '9:00am'),
  DataSheet(12, 'Diciembre', 'Tipo de Tramite', 'Constancia', '10:00am'),
  DataSheet(13, 'Diciembre', 'Tipo de Tramite', 'Constancia', '9:30am'),
  DataSheet(14, 'Diciembre', 'Tipo de Tramite', 'Constancia', '11:00am'),
  DataSheet(15, 'Diciembre', 'Tipo de Tramite', 'Constancia', '9:00am'),
  DataSheet(16, 'Diciembre', 'Tipo de Tramite', 'Constancia', '11:00am'),
];

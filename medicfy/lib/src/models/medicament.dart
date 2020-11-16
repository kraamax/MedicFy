import 'package:medicfy/src/models/frequency.dart';
import 'package:medicfy/src/models/duration.dart';

class Medicament {
  int medicamentId;
  String medicamentName;
  String units;
  Frequency frequency;
  String schedule;
  Duration duration;
  Medicament(
      {this.duration,
      this.frequency,
      this.medicamentId,
      this.medicamentName,
      this.schedule,
      this.units});
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new Map();
    map['medicamentName'] = medicamentName;
    map['units'] = units;
    map['schedule'] = schedule;
    map['medicamentId'] = medicamentId;
    map['frequency'] = frequency.toMap();
    map['duration'] = duration.toMap();
    return map;
  }

  Medicament.fromObject(dynamic obj) {
    this.medicamentId = obj['medicamentId'];
    this.medicamentName = obj['medicamentName'];
    this.units = obj['units'];
    this.frequency = new Frequency();
    this.frequency.type = obj['frequency']['type'];
    this.frequency.frequencyId = obj['frequency']['frequencyId'];
    this.frequency.daysNumber = obj['frequency']['daysNumber'];
    this.duration = new Duration();
    this.duration.initialDate = obj['duration']['initialDate'];
    this.duration.finalDate = obj['duration']['finalDate'];
    this.duration.haveFinalDate = obj['duration']['haveFinalDate'];
    this.duration.durationId = obj['duration']['durationId'];

    this.schedule = obj['schedule'];
  }
}

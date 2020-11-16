class Frequency {
  int frequencyId;
  String type;
  int daysNumber;
  Frequency({this.frequencyId, this.daysNumber, this.type});
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new Map();
    map['frequencyId'] = frequencyId;
    map['type'] = type;
    map['daysNumber'] = daysNumber;
    return map;
  }
}

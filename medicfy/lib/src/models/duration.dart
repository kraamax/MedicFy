class Duration {
  int durationId;
  String initialDate;
  String finalDate;
  bool haveFinalDate;
  Duration(
      {this.initialDate, this.finalDate, this.durationId, this.haveFinalDate});
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new Map();
    map['durationId'] = durationId;
    map['initialDate'] = initialDate;
    map['finalDate'] = finalDate;
    map['haveFinalDate'] = haveFinalDate;

    return map;
  }
}

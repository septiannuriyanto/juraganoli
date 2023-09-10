class WhProperties {
  String warehouse;
  String location;
  List<OilProperties> oilProperties = [];
  WhProperties({
    required this.warehouse,
    required this.location,
  });
}

class OilProperties {
  String jenisOli;
  double? depth;
  double? vol;

  OilProperties({
    required this.jenisOli,
    this.depth,
    this.vol,
  });
}

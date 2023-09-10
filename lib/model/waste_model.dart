class WasteModel {
  String name;
  int? conversionFactor;
  bool? isSellable;
  int? tariff;
  String? wasteCode;
  bool? logbookconversion;
  String? wasteStoreCode;

  WasteModel({
    required this.name,
    this.conversionFactor,
    this.isSellable,
    this.tariff,
    this.wasteCode,
    this.logbookconversion,
    this.wasteStoreCode,
  });

  factory WasteModel.fromJson(Map<String, dynamic> json) {
    return WasteModel(
      name: json["name"],
      conversionFactor: json["conversionfactor"],
      isSellable: json["issellable"],
      tariff: json["tariffperpack"],
      wasteCode: json["wastecode"],
      logbookconversion: json['logbookconversion'],
    );
  }
}

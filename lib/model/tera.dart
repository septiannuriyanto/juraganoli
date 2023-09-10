class Tera {
  String depth;
  String qty;

  Tera({
    required this.depth,
    required this.qty,
  });

  factory Tera.fromJson(Map<String, dynamic> jsonData) {
    return Tera(
      depth: jsonData['Depth'],
      qty: jsonData['Qty'],
    );
  }

  static Map<String, dynamic> toMap(Tera tera) => {
        'Depth': tera.depth,
        'Qty': tera.qty,
      };
}

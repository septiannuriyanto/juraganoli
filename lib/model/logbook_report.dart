class LogbookReport {
  String transType;
  String tgl;
  String supplierLimbah;
  String jenisLimbah;
  int qtyLimbah;
  String picLimbah;
  String reffNo;
  String? imgLink;
  String logbookKey;

  LogbookReport({
    required this.transType,
    required this.tgl,
    required this.supplierLimbah,
    required this.jenisLimbah,
    required this.qtyLimbah,
    required this.picLimbah,
    required this.reffNo,
    this.imgLink,
    required this.logbookKey,
  });

  static Map<String, dynamic> toJSON(LogbookReport lbr) => {
        'supplier': lbr.supplierLimbah,
        'waste_type': lbr.jenisLimbah,
        'qty_limbah': lbr.qtyLimbah,
        'pic_limbah': lbr.picLimbah,
        'reff_no': lbr.reffNo,
        'tgl': lbr.tgl,
        'tran_type': lbr.transType,
        'img_link': lbr.imgLink ?? "null",
      };

  static List<String> toGoogleSheet(LogbookReport lbr) => [
        lbr.transType,
        lbr.jenisLimbah,
        lbr.tgl,
        lbr.supplierLimbah,
        lbr.qtyLimbah.toString(),
        lbr.reffNo,
        lbr.imgLink ?? "Image Not Available",
        lbr.logbookKey
      ];
}

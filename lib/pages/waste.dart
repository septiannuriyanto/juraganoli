import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gsheets/gsheets.dart';
import 'package:juraganoli/component/custom_button.dart';
import 'package:juraganoli/component/custom_textField.dart';
import 'package:juraganoli/utils/datetime_handler.dart';
import 'package:juraganoli/constants/theme.dart';
import 'package:juraganoli/constants/waste_jsondata.dart';
import 'package:juraganoli/dialog/dialog.dart';
import 'package:juraganoli/dialog/loader_dialog.dart';
import 'package:juraganoli/model/logbook_report.dart';
import 'package:juraganoli/model/waste_model.dart';
import 'package:juraganoli/utils/formatter.dart';
import '../component/custom_datepicker.dart';
import '../dialog/cart_dialog.dart';
import '../confidential/globaldata.dart' as global;

class Waste extends StatefulWidget {
  const Waste({super.key});

  @override
  State<Waste> createState() => _WasteState();
}

DateTime chosenDate = DateTime.now();
DateTime expDate = DateTime.now();

class _WasteState extends State<Waste> {
  callback(varReturnedDate) {
    setState(() {
      chosenDate = varReturnedDate;
    });
  }

  List<bool> isWasteIn = [true];
  int conversionFactor = 0;
  String? supplier;
  int? qtyIn;
  String? pic;
  String? wasteType;
  String? reffNumber;
  List<WasteModel> wasteList = [];
  List<LogbookReport> logbookReport = [];

  final supplier_c = TextEditingController();
  final jenis_c = TextEditingController();
  final jumlah_c = TextEditingController();
  final pic_c = TextEditingController();
  final reff_c = TextEditingController();

  final supplier_c2 = TextEditingController();
  final jenis_c2 = TextEditingController();
  final jumlah_c2 = TextEditingController();
  final pic_c2 = TextEditingController();
  final reff_c2 = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for (var element in jsonWasteData) {
      WasteModel mdl = WasteModel.fromJson(element);
      mdl.wasteStoreCode = wasteStoreCode[mdl.name];
      wasteList.add(mdl);
    }
    print("Waste Data Loaded");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Theme.of(context).colorScheme.surfaceVariant,
              padding: const EdgeInsets.all(8),
              child: Center(
                child: Text(
                  "In Out Waste",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
                child: ListView(
              children: [
                CustomDatePicker(
                  callbackFunction: callback,
                  chosenDate: chosenDate,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: ToggleButtons(
                      isSelected: isWasteIn,
                      borderRadius: rads(12),
                      selectedColor: Colors.green,
                      color: Colors.redAccent.shade100,
                      fillColor: Colors.greenAccent.shade100,
                      onPressed: (index) {
                        setState(() {
                          isWasteIn[index] = !isWasteIn[index];
                          print(isWasteIn[index]);
                        });
                      },
                      selectedBorderColor: Colors.blue,
                      children: isWasteIn[0]
                          ? [
                              const Column(
                                children: [Icon(Icons.download), Text("In")],
                              ),
                            ]
                          : [
                              const Column(
                                children: [Icon(Icons.upload), Text("Out")],
                              ),
                            ],
                    ),
                  ),
                ),

                //=============================================================LIMBAH IN
                Visibility(
                  visible: isWasteIn[0],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(12),
                      width: Get.width,
                      decoration: BoxDecoration(
                          color: Colors.greenAccent.shade100.withOpacity(0.4),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12),
                          ),
                          border: Border.all(
                              color: Colors.grey.shade400, width: 1)),
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: supplier_c,
                            hint: "Supplier Limbah",
                            prefIcon: IconButton(
                                onPressed: () async {
                                  final data = await Get.dialog(ChoiceDialog(
                                      dataGroup: List.from(supplierLimbah)));
                                  if (data != null) {
                                    supplier_c.text = data;
                                    supplier = data;
                                  }
                                },
                                icon: const Icon(Icons.search_rounded)),
                            onChanged: (p0) => supplier = p0,
                          ),
                          CustomTextField(
                            controller: jenis_c,
                            hint: "Jenis Limbah",
                            prefIcon: IconButton(
                                onPressed: () async {
                                  final data = await Get.dialog(ChoiceDialog(
                                      dataGroup: List.from(wasteList.map((e) {
                                    return e.name;
                                  })).toList()));
                                  if (data != null) {
                                    jenis_c.text = data;
                                    wasteType = data;
                                    if (data == "Pelumas Bekas") {
                                      conversionFactor =
                                          wasteList[0].conversionFactor!;
                                    } else {
                                      conversionFactor = 1;
                                    }

                                    if (jumlah_c.text.isEmpty) {
                                      qtyIn = 0;
                                    } else {
                                      qtyIn = conversionFactor *
                                          int.parse(jumlah_c.text);
                                    }

                                    setState(() {});
                                  }
                                },
                                icon: const Icon(Icons.search_rounded)),
                            onChanged: (p0) => wasteType = p0,
                          ),
                          CustomTextField(
                              controller: jumlah_c,
                              hint: "Jumlah (Drum)",
                              inputFormatters: [
                                numberOnly,
                              ],
                              keyboardType: TextInputType.number,
                              onChanged: (p0) {
                                p0.isNotEmpty
                                    ? qtyIn = int.parse(p0) * conversionFactor
                                    : qtyIn = 0;
                                setState(() {});
                              }),
                          CustomTextField(
                            controller: pic_c,
                            hint: "Disetor Oleh",
                            onChanged: (p0) => pic = p0,
                            inputFormatters: [alphabetOnly],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Faktor konversi : $conversionFactor"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Qty Supply : $qtyIn",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Visibility(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Maks Penyimpanan : ${convertToIndDate(formattedDate(expDate))}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orangeAccent.shade700),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    int result = validateForm();
                                    if (result == 1) return;
                                    addToList(
                                      LogbookReport(
                                        transType: isWasteIn[0] ? "IN" : "OUT",
                                        tgl: convertToIndDate(
                                            formattedDate(chosenDate)),
                                        supplierLimbah: supplier_c.text,
                                        jenisLimbah: jenis_c.text,
                                        qtyLimbah: qtyIn!,
                                        picLimbah: pic_c.text,
                                        reffNo: isWasteIn[0]
                                            ? formattedDate(chosenDate) +
                                                supplier_c.text +
                                                wasteStoreCode[jenis_c.text]!
                                            : reff_c.text,
                                        logbookKey: isWasteIn[0]
                                            ? "IN${jenis_c.text}${formattedDateTwoStrings(chosenDate)}"
                                            : "OUT${jenis_c.text}${formattedDateTwoStrings(chosenDate)}",
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.add_circle_outline,
                                    color: Colors.green,
                                  ),
                                ),
                                Stack(
                                  children: [
                                    IconButton(
                                        onPressed: () async {
                                          final deletedIndex = await showDialog(
                                              context: context,
                                              builder: ((context) {
                                                return CartDialog(
                                                    report: logbookReport);
                                              }));
                                          if (deletedIndex != null) {
                                            print(
                                                "Deleted index $deletedIndex");
                                            setState(() {
                                              logbookReport
                                                  .removeAt(deletedIndex);
                                            });
                                          }
                                        },
                                        icon: const Icon(Icons.shopping_cart)),
                                    Container(
                                      width: 20,
                                      height: 20,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.green),
                                      child: Center(
                                          child: Text(
                                        logbookReport.length.toString(),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      )),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          CustomRRButton(
                            enabled: logbookReport.isNotEmpty,
                            borderRadius: 12,
                            color: Colors.greenAccent.shade400,
                            title: "Terima",
                            width: Get.width * 0.3,
                            onTap: () async {
                              final conf = await sendForm();
                              if (conf == "ok") {
                                LoaderDialog.showLoadingDialog("Sending Data");
                                await submitData(logbookReport);
                                Future.delayed(
                                        const Duration(seconds: 3), () {})
                                    .then((value) => Get.back());
                                setState(() {
                                  clearAllForm();
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //=============================================================LIMBAH OUT
                Visibility(
                  visible: !isWasteIn[0],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(12),
                      width: Get.width,
                      decoration: BoxDecoration(
                          color: Colors.redAccent.shade100.withOpacity(0.4),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12),
                          ),
                          border: Border.all(
                              color: Colors.grey.shade400, width: 1)),
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: supplier_c2,
                            hint: "Tujuan Penyerahan",
                            prefIcon: IconButton(
                              onPressed: () async {
                                final data = await Get.dialog(
                                    ChoiceDialog(dataGroup: List.from(tujuan)));
                                if (data != null) {
                                  supplier_c2.text = data;
                                  supplier = data;
                                }
                              },
                              icon: const Icon(Icons.search_rounded),
                            ),
                            onChanged: (p0) => supplier = p0,
                          ),
                          CustomTextField(
                            controller: jenis_c2,
                            hint: "Jenis Limbah",
                            prefIcon: IconButton(
                                onPressed: () async {
                                  final data = await Get.dialog(ChoiceDialog(
                                      dataGroup: List.from(wasteList.map((e) {
                                    return e.name;
                                  })).toList()));
                                  if (data != null) {
                                    jenis_c2.text = data;
                                    wasteType = data;
                                    if (data == "Pelumas Bekas") {
                                      conversionFactor =
                                          wasteList[0].conversionFactor!;
                                    } else {
                                      conversionFactor = 1;
                                    }

                                    if (jumlah_c2.text.isEmpty) {
                                      qtyIn = 0;
                                    } else {
                                      qtyIn = conversionFactor *
                                          int.parse(jumlah_c2.text);
                                    }

                                    setState(() {});
                                  }
                                },
                                icon: const Icon(Icons.search_rounded)),
                            onChanged: (p0) => wasteType = p0,
                          ),
                          CustomTextField(
                              controller: jumlah_c2,
                              hint: "Jumlah (Drum)",
                              inputFormatters: [
                                numberOnly,
                              ],
                              keyboardType: TextInputType.number,
                              onChanged: (p0) {
                                p0.isNotEmpty
                                    ? qtyIn = int.parse(p0) * conversionFactor
                                    : qtyIn = 0;
                                setState(() {});
                              }),
                          CustomTextField(
                            controller: pic_c2,
                            hint: "Disetor Oleh",
                            onChanged: (p0) => pic = p0,
                            inputFormatters: [alphabetOnly],
                          ),
                          CustomTextField(
                            controller: reff_c2,
                            hint: "Nomor Referensi",
                            inputFormatters: [],
                            onChanged: (p0) => reffNumber = p0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Faktor konversi : $conversionFactor"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Qty Supply : $qtyIn",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    print("Button Add Red");
                                    int result = validateForm();
                                    if (result == 1) return;
                                    addToList(
                                      LogbookReport(
                                        transType: isWasteIn[0] ? "IN" : "OUT",
                                        tgl: convertToIndDate(
                                            formattedDate(chosenDate)),
                                        supplierLimbah: supplier_c2.text,
                                        jenisLimbah: jenis_c2.text,
                                        qtyLimbah: qtyIn!,
                                        picLimbah: pic_c2.text,
                                        reffNo: isWasteIn[0]
                                            ? formattedDate(chosenDate) +
                                                supplier_c2.text +
                                                wasteStoreCode[jenis_c.text]!
                                            : reff_c2.text,
                                        logbookKey: isWasteIn[0]
                                            ? "IN${jenis_c2.text}${formattedDateTwoStrings(chosenDate)}"
                                            : "OUT${jenis_c2.text}${formattedDateTwoStrings(chosenDate)}",
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.add_circle_outline,
                                    color: Colors.red,
                                  ),
                                ),
                                Stack(
                                  children: [
                                    IconButton(
                                        onPressed: () async {
                                          final deletedIndex = await showDialog(
                                              context: context,
                                              builder: ((context) {
                                                return CartDialog(
                                                    report: logbookReport);
                                              }));
                                          if (deletedIndex != null) {
                                            print(
                                                "Deleted index $deletedIndex");
                                            setState(() {
                                              logbookReport
                                                  .removeAt(deletedIndex);
                                            });
                                          }
                                        },
                                        icon: const Icon(Icons.shopping_cart)),
                                    Container(
                                      width: 20,
                                      height: 20,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.red),
                                      child: Center(
                                          child: Text(
                                        logbookReport.length.toString(),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      )),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          CustomRRButton(
                            enabled: logbookReport.isNotEmpty,
                            borderRadius: 12,
                            color: Colors.redAccent.shade100,
                            title: "Kirim",
                            width: Get.width * 0.3,
                            onTap: () async {
                              final conf = await sendForm();
                              if (conf == "ok") {
                                LoaderDialog.showLoadingDialog("Sending Data");
                                await submitData(logbookReport);
                                Future.delayed(
                                        const Duration(seconds: 3), () {})
                                    .then((value) => Get.back());
                                clearAllForm();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }

  addToList(LogbookReport lbr) {
    setState(() {
      logbookReport.add(lbr);
    });
  }

  validateForm() {
    if (!isWasteIn[0]) {
      if (supplier_c2.text.isEmpty) return emptyFormAlert("Destination");
      if (jenis_c2.text.isEmpty) return emptyFormAlert("Jenis Limbah");
      if (jumlah_c2.text.isEmpty) return emptyFormAlert("Jumlah Limbah");
      if (pic_c2.text.isEmpty) return emptyFormAlert("PIC");
      if (reff_c2.text.isEmpty) return emptyFormAlert("Reff No");
    } else {
      if (supplier_c.text.isEmpty) return emptyFormAlert("Supplier");
      if (jenis_c.text.isEmpty) return emptyFormAlert("Jenis Limbah");
      if (jumlah_c.text.isEmpty) return emptyFormAlert("Jumlah Limbah");
      if (pic_c.text.isEmpty) return emptyFormAlert("PIC");
    }
    return 0;
  }

  emptyFormAlert(String component) {
    Get.snackbar("Empty", '$component is empty');
    return 1;
  }

  Future<String?> sendForm() async {
    String? res = await Get.defaultDialog(
      title: "Confirmation",
      content: const Text("Yakin dengan data yang anda kirimkan?"),
      textConfirm: "Ya",
      textCancel: "Tidak",
      barrierDismissible: true,
      confirm: CustomRRButton(
        borderRadius: 12,
        title: "Ya",
        width: Get.width * 0.25,
        onTap: () {
          print("Ya");
          Get.back(result: "ok");
        },
        color: Colors.greenAccent,
      ),
      cancel: CustomRRButton(
        borderRadius: 12,
        title: "Tidak",
        width: Get.width * 0.25,
        onTap: () {
          print("Tidak");
          Get.back(result: null);
        },
        color: Colors.redAccent,
      ),
    );

    return res;
  }

  void clearAllForm() {
    supplier_c.clear();
    jenis_c.clear();
    jumlah_c.clear();
    pic_c.clear();
    reff_c.clear();
    logbookReport.clear();
    supplier_c2.clear();
    jenis_c2.clear();
    jumlah_c2.clear();
    pic_c2.clear();
    reff_c2.clear();
  }

  Future<void> submitData(List<LogbookReport> logbookReport) async {
    try {
      final gsheets = GSheets(global.credentials);
      final ss = await gsheets.spreadsheet(global.wasteSpreadSheetID);
      var sheet = ss.worksheetByTitle('Rawdata');
      final dst = await sheet!.values.allRows(fromRow: 1);
      int lastRow = dst.length;

      List<List<dynamic>> dataTosend =
          logbookReport.map((e) => LogbookReport.toGoogleSheet(e)).toList();
      // print(dataTosend);
      sheet.values.insertRows(lastRow + 1, dataTosend);
    } catch (e) {
      print(e.toString());
    }
  }
}

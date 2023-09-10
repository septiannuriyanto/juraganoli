import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gsheets/gsheets.dart';
import 'package:intl/intl.dart';

import '../additive.dart';
import '../dialog/loader_dialog.dart';
import '../pages/grease.dart';
import '../constants/masterdata_constant.dart';
import '../model/oilProperties.dart';
import '../model/tera.dart';
import '../pages/oli.dart';

import '../confidential/globaldata.dart' as global;
import '../pages/waste.dart';

class DataCart extends GetxController {
  RxInt pageIndex = RxInt(0);
  RxList<WhProperties> whProps = RxList();
  RxList<WhProperties> lubcarProps = RxList();
  RxList<WhProperties> pendingReceiveProps = RxList();
  RxList<WhProperties> additiveProps = RxList();

  RxList<Widget> widgetOptions = RxList.empty();
  RxInt maxOilRecord = RxInt(0);
  RxInt oilRecord = RxInt(0);
  RxDouble percent = RxDouble(0);

  List<Tera>? teraLubcar, teraTangkiWso, additiveList;

  @override
  void onInit() {
    // TODO: implement onInit

    //get Tera
    asyncProcedures();

    //Populating warehouse
    for (int i = 0; i < warehouse.length; i++) {
      whProps
          .add(WhProperties(warehouse: warehouse[i], location: whLocation[i]));
      for (int j = 0; j < oli.length; j++) {
        whProps[i].oilProperties.add(OilProperties(jenisOli: oli[j]));
        maxOilRecord.value++;
      }
    }

    //Populating Lubcar
    for (int i = 0; i < lubcar.length; i++) {
      lubcarProps
          .add(WhProperties(warehouse: lubcar[i], location: lubcarLocation[i]));
      for (int j = 0; j < oli.length; j++) {
        lubcarProps[i].oilProperties.add(OilProperties(jenisOli: oli[j]));
        maxOilRecord.value++;
      }
    }

    //Creating Pending Receive Widget
    pendingReceiveProps
        .add(WhProperties(warehouse: "Pending Receive", location: "SM"));
    for (int j = 0; j < oli.length; j++) {
      pendingReceiveProps[0]
          .oilProperties
          .add(OilProperties(jenisOli: oli[j], depth: null, vol: null));
      maxOilRecord.value++;
    }

    //Populating Pages
    widgetOptions.add(HomeOli(
      whProps: whProps,
      lubcarProps: lubcarProps,
      pendingReceive: pendingReceiveProps,
      maxOilRecord: maxOilRecord.value,
      teraLubcar: teraLubcar,
      teraTangkiWSO: teraTangkiWso,
    ));
    widgetOptions.add(HomeGrease());
    widgetOptions.add(HomeAdditive(
      additiveProps: additiveProps,
    ));
    widgetOptions.add(Waste());

    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future<dynamic> downloadMasterConfig() async {
    final gsheets = GSheets(global.credentials);
    final ss = await gsheets.spreadsheet(global.SpreadsheetID);
    var sheet = ss.worksheetByTitle('Tera');

    final tera =
        await sheet!.values.allRows(fromRow: 2); //.allRows(fromRow: 2);

    return tera;
  }

  // Future<List<Tera>> getTeraLubcar() async {
  //   List<Tera> teraReturn = [];
  //   int depthColIndex = 0;
  //   int qtyColIndex = 1;

  //   final gsheets = GSheets(global.credentials);
  //   final ss = await gsheets.spreadsheet(global.SpreadsheetID);
  //   var sheet = ss.worksheetByTitle('Tera');

  //   final tera =
  //       await sheet!.values.allRows(fromRow: 2); //.allRows(fromRow: 2);

  //   for (int i = 0; i < tera.length; i++) {
  //     if (tera[i][depthColIndex].trim().isNotEmpty) {
  //       teraReturn.add(
  //           Tera(depth: tera[i][depthColIndex], qty: tera[i][qtyColIndex]));
  //     }
  //   }
  //   return teraReturn;
  // }

  // Future<List<Tera>> getTeraTangkiWso() async {
  //   List<Tera> teraReturn = [];
  //   int depthColIndex = 5;
  //   int qtyColIndex = 6;

  //   final gsheets = GSheets(global.credentials);
  //   final ss = await gsheets.spreadsheet(global.SpreadsheetID);
  //   var sheet = ss.worksheetByTitle('Tera');

  //   final tera =
  //       await sheet!.values.allRows(fromRow: 2); //.allRows(fromRow: 2);

  //   for (int i = 0; i < tera.length; i++) {
  //     if (tera[i][depthColIndex].trim().isNotEmpty) {
  //       teraReturn.add(
  //           Tera(depth: tera[i][depthColIndex], qty: tera[i][qtyColIndex]));
  //     }
  //   }
  //   return teraReturn;
  // }

  Future<List<Tera>> getTeraLubcar(dynamic tera) async {
    List<Tera> teraReturn = [];
    int depthColIndex = 0;
    int qtyColIndex = 1;

    for (int i = 0; i < tera.length; i++) {
      if (tera[i][depthColIndex].trim().isNotEmpty) {
        teraReturn.add(
            Tera(depth: tera[i][depthColIndex], qty: tera[i][qtyColIndex]));
      }
    }
    return teraReturn;
  }

  Future<List<Tera>> getTeraTangkiWso(dynamic tera) async {
    List<Tera> teraReturn = [];
    int depthColIndex = 5;
    int qtyColIndex = 6;

    for (int i = 0; i < tera.length; i++) {
      if (tera[i][depthColIndex].trim().isNotEmpty) {
        teraReturn.add(
            Tera(depth: tera[i][depthColIndex], qty: tera[i][qtyColIndex]));
      }
    }
    return teraReturn;
  }

  Future<List<Tera>> getAdditives(List<List<String>> tera) async {
    List<Tera> teraReturn = [];
    int depthColIndex = 9;
    int qtyColIndex = 10;

    for (int i = 0; i < 7; i++) {
      print(tera[0][i]);
      if (tera[i][depthColIndex].trim().isNotEmpty) {
        teraReturn.add(
            Tera(depth: tera[i][depthColIndex], qty: tera[i][qtyColIndex]));
      }
    }
    return teraReturn;
  }

  asyncProcedures() async {
    // try {
    final tera = await downloadMasterConfig();
    print("Tera Loaded");
    teraLubcar = await getTeraLubcar(tera);
    teraTangkiWso = await getTeraTangkiWso(tera);
    additiveList = await getAdditives(tera);
    // Populating Additives
    additiveProps
        .add(WhProperties(warehouse: "Additives", location: "IBC Storage"));
    for (int j = 0; j < additiveList!.length; j++) {
      additiveProps[0].oilProperties.add(OilProperties(
          jenisOli: additiveList![j].depth, depth: null, vol: null));
    }
    // } catch (e) {
    //   Get.snackbar("Error", e.toString());
    // }

    Get.snackbar("Success", "Tera Loaded",
        duration: const Duration(seconds: 1));
    // print(teraLubcar!.length);
  }

  Future<int> sendData(List<WhProperties> whProps,
      List<WhProperties> lubcarProps, List<WhProperties> pendingReceive) async {
    //Create Data
    List<String> dataToSend = [];
    double total15, total30, total10, total85;

    //0. Append Date as Key
    dataToSend.add(DateFormat('yyyyMMdd').format(DateTime.now()));

    //1. Append Data Pending Receive
    for (int j = 0; j < pendingReceive[0].oilProperties.length; j++) {
      dataToSend
          .add(pendingReceive[0].oilProperties[j].vol!.toStringAsFixed(0));
    }

    //2. Append Data Total Volume All WH
    total15 = 0;
    total10 = 0;
    total30 = 0;
    total85 = 0;
    for (int i = 0; i < whProps.length; i++) {
      total15 = total15 + whProps[i].oilProperties[0].vol!.toDouble();
      total10 = total10 + whProps[i].oilProperties[1].vol!.toDouble();
      total30 = total30 + whProps[i].oilProperties[2].vol!.toDouble();
      total85 = total85 + whProps[i].oilProperties[3].vol!.toDouble();
    }
    for (int i = 0; i < lubcarProps.length; i++) {
      total15 = total15 + lubcarProps[i].oilProperties[0].vol!.toDouble();
      total10 = total10 + lubcarProps[i].oilProperties[1].vol!.toDouble();
      total30 = total30 + lubcarProps[i].oilProperties[2].vol!.toDouble();
      total85 = total85 + lubcarProps[i].oilProperties[3].vol!.toDouble();
    }

    dataToSend.add(total15.toStringAsFixed(0));
    dataToSend.add(total10.toStringAsFixed(0));
    dataToSend.add(total30.toStringAsFixed(0));
    dataToSend.add(total85.toStringAsFixed(0));

    //3. Append Data Volume All WH
    for (int i = 0; i < whProps.length; i++) {
      for (int j = 0; j < whProps[i].oilProperties.length; j++) {
        dataToSend.add(whProps[i].oilProperties[j].vol!.toStringAsFixed(0));
      }
    }

    //4. Append Data Volume All Lubcar
    for (int i = 0; i < lubcarProps.length; i++) {
      for (int j = 0; j < lubcarProps[i].oilProperties.length; j++) {
        dataToSend.add(lubcarProps[i].oilProperties[j].vol!.toStringAsFixed(0));
      }
    }

    //Send Data to Sheets

    LoaderDialog.showLoadingDialog("Submitting data");

    final gsheets = GSheets(global.credentials);
    final ss = await gsheets.spreadsheet(global.SpreadsheetID);
    var sheet = ss.worksheetByTitle('DST Oli');
    final dst = await sheet!.values.allRows(fromRow: 1);
    int lastRow = dst.length;

    //Check is duplicate
    final cell = await sheet.cells.cell(row: lastRow, column: 1);
    String checkLast = cell.value;

    if (checkLast == DateFormat('yyyyMMdd').format(DateTime.now())) {
      Get.back();
      Get.snackbar(
          "Duplicate", "Anda sudah menginput hari ini, coba lagi besok");
      return 1;
    }

    try {
      await sheet.values.insertRow(lastRow + 1, dataToSend);
      Get.back();
    } catch (e) {
      Get.snackbar("Error Submitting Data", e.toString());
      return 1;
    }

    Get.snackbar("Success", "Success Submitting Data");
    return 0;
  }
}

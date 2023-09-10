import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juraganoli/color_schemes.g.dart';
import 'package:juraganoli/component/data_cart.dart';
import 'package:juraganoli/component/inputdialog.dart';
import 'package:juraganoli/model/oilProperties.dart';
import 'package:juraganoli/services/tera_services.dart';
import 'package:loading_animations/loading_animations.dart';

import '../constants/masterdata_constant.dart';
import '../model/tera.dart';

// ignore: must_be_immutable
class HomeOli extends StatefulWidget {
  List<WhProperties> whProps;
  List<WhProperties> lubcarProps;
  List<WhProperties> pendingReceive;
  int maxOilRecord;
  List<Tera>? teraLubcar;
  List<Tera>? teraTangkiWSO;
  HomeOli({
    required this.whProps,
    required this.lubcarProps,
    required this.pendingReceive,
    required this.maxOilRecord,
    required this.teraLubcar,
    required this.teraTangkiWSO,
    super.key,
  });

  @override
  State<HomeOli> createState() => _HomeOliState();
}

class _HomeOliState extends State<HomeOli> {
  final olicontroller = Get.put(DataCart());
  double percent = 0;
  int doneSonding = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  callback(int? callvar) {
    setState(() {
      if (callvar != null) {
        if (int.parse(callvar.toString()) == 1) {
          doneSonding++;
        } else {
          if (doneSonding > 0) {
            doneSonding--;
          }
        }
      }
      percent = doneSonding / olicontroller.maxOilRecord.value * 100;
      olicontroller.percent.value = percent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Theme.of(context).colorScheme.surfaceVariant,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      // "ST Oli",
                      "Stock Taking Oli (${(olicontroller.percent.value).toStringAsFixed(2)} %)",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: WarehouseWidgets(
                  whProps: widget.whProps,
                  sondingCount: doneSonding,
                  maxCount: widget.maxOilRecord,
                  callbackFunction: callback,
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: WarehouseWidgets(
                  whProps: widget.lubcarProps,
                  sondingCount: doneSonding,
                  maxCount: widget.maxOilRecord,
                  callbackFunction: callback,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: WarehouseWidgets(
                  whProps: widget.pendingReceive,
                  sondingCount: doneSonding,
                  maxCount: widget.maxOilRecord,
                  callbackFunction: callback,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text("Petunjuk : "),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text("- Tap untuk mengisi data dipping"),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text("- Double tap untuk reset data dipping"),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: olicontroller.percent.value >= 100
              ? Colors.blue.shade800
              : Colors.grey,
        ),
        child: IconButton(
          enableFeedback: olicontroller.percent.value >= 100 ? true : false,
          icon: const Icon(
            Icons.send,
            color: Colors.white,
          ),
          onPressed: () async {
            final data = await Get.defaultDialog(
              title: "Konfirmasi",
              middleText: "Anda yakin untuk mengirim data?",
              confirm: ElevatedButton(
                  onPressed: () {
                    Get.back(result: "OK");
                  },
                  child: const Text("Ya"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: lightColorScheme.inversePrimary)),
              cancel: ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("Tidak"),
              ),
              buttonColor: Colors.red,
            );

            if (data != null) {
              int status = await olicontroller.sendData(
                  widget.whProps, widget.lubcarProps, widget.pendingReceive);

              //==============================================================
              if (status == 0) {
                //Erase all data
                for (int i = 0; i < widget.whProps.length; i++) {
                  for (int j = 0;
                      j < widget.whProps[i].oilProperties.length;
                      j++) {
                    widget.whProps[i].oilProperties[j].depth = null;
                    widget.whProps[i].oilProperties[j].vol = null;
                  }
                }

                for (int i = 0; i < widget.lubcarProps.length; i++) {
                  for (int j = 0;
                      j < widget.lubcarProps[i].oilProperties.length;
                      j++) {
                    widget.lubcarProps[i].oilProperties[j].depth = null;
                    widget.lubcarProps[i].oilProperties[j].vol = null;
                  }
                }

                for (int j = 0;
                    j < widget.pendingReceive[0].oilProperties.length;
                    j++) {
                  widget.pendingReceive[0].oilProperties[j].depth = null;
                  widget.pendingReceive[0].oilProperties[j].vol = null;
                }
                percent = 0;
                doneSonding = 0;

                //==============================================================

                setState(() {});
              }
            }
          },
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class WarehouseWidgets extends StatefulWidget {
  // List<double?>? depth;

  List<WhProperties> whProps = [];
  int sondingCount;
  int maxCount;
  final Function callbackFunction;
  WarehouseWidgets({
    required this.whProps,
    required this.sondingCount,
    required this.maxCount,
    required this.callbackFunction,
  });

  @override
  State<WarehouseWidgets> createState() => _WarehouseWidgetsState();
}

class _WarehouseWidgetsState extends State<WarehouseWidgets> {
  CarouselController carousel_c = CarouselController();

  //final data_c = Get.put(DataCart(), tag: "Warehouse");

  final controller = Get.put(DataCart());
  @override
  Widget build(BuildContext context) {
    final them = Theme.of(context);
    return SizedBox(
      height: MediaQuery.of(context).size.width * 0.45,
      width: Get.width,
      child: CarouselSlider.builder(
        carouselController: carousel_c,
        itemCount: widget.whProps.length,
        itemBuilder: (context, index, realIndex) {
          return Container(
            height: MediaQuery.of(context).size.width,
            width: MediaQuery.of(context).size.width,
            color: them.colorScheme.primaryContainer,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Tooltip(
                      message: warehouseTooltip[index],
                      child: Container(
                        decoration: BoxDecoration(
                            color: them.colorScheme.primary,
                            borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(12))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.whProps[index].warehouse,
                            style: them.textTheme.labelLarge!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Lokasi : ${widget.whProps[index].location}"),
                    )
                  ],
                ),
                Expanded(
                    child: Container(
                  child: Center(
                    child: SizedBox(
                      width: double.maxFinite,
                      height: 70,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: List.generate(
                              widget.whProps[index].oilProperties.length,
                              (oliIndex) {
                            return Obx(
                              () => Ink(
                                child: InkWell(
                                  splashColor: Colors.white,
                                  child: Tooltip(
                                    message: widget
                                                .whProps[index]
                                                .oilProperties[oliIndex]
                                                .depth !=
                                            null
                                        ? 'Tinggi ${widget.whProps[index].oilProperties[oliIndex].depth.toString()}: cm\nVolume : ${widget.whProps[index].oilProperties[oliIndex].vol.toString()} liter'
                                        : 'Belum disonding',
                                    child: Obx(
                                      () => Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          color: (widget
                                                      .whProps[index]
                                                      .oilProperties[oliIndex]
                                                      .depth ==
                                                  null)
                                              ? Colors.grey
                                              : Colors.green,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Text(oli[oliIndex]),
                                        ),
                                      ),
                                    ),
                                  ),
                                  onDoubleTap: () async {
                                    if (widget.whProps[index]
                                            .oilProperties[oliIndex].depth ==
                                        null) {
                                      return;
                                    }
                                    final conf = await Get.defaultDialog(
                                      title: "Konfirmasi",
                                      middleText:
                                          "Anda yakin untuk reset data ini?",
                                      confirm: ElevatedButton(
                                          onPressed: () {
                                            Get.back(result: "OK");
                                          },
                                          child: const Text("Ya"),
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: lightColorScheme
                                                  .inversePrimary)),
                                      cancel: ElevatedButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: const Text("Tidak"),
                                      ),
                                      buttonColor: Colors.red,
                                    );

                                    if (conf != null) {
                                      setState(() {
                                        widget
                                            .whProps[index]
                                            .oilProperties[oliIndex]
                                            .depth = null;
                                        widget.callbackFunction(-1);
                                      });
                                    }
                                  },
                                  onTap: () async {
                                    bool isEditing = false;
                                    double depth, vol = 0;
                                    if (widget.whProps[index]
                                            .oilProperties[oliIndex].depth ==
                                        null) {
                                      print("Add New Data");
                                      isEditing = false;
                                    } else {
                                      print("Editing Data");
                                      isEditing = true;
                                    }
                                    dynamic data =
                                        await Get.dialog(InputDialog());

                                    if (data != null) {
                                      //replace with dot if comma inputted
                                      if (data.toString().contains(',')) {
                                        List<String> splitted =
                                            data.toString().split(',');
                                        data = "${splitted[0]}.${splitted[1]}";
                                      }
                                      //waiting terra to be loaded
                                      if (controller.teraLubcar == null ||
                                          controller.teraTangkiWso == null) {
                                        Get.snackbar("Tera not loaded",
                                            "Harap Tunggu Tabel Tera Didownload");
                                        return;
                                      }
                                      //try catch with calculation inside
                                      try {
                                        depth = double.parse(data);
                                        //case if stock taking Main Oiltank
                                        if (widget.whProps[index].warehouse ==
                                            "OTG1") {
                                          vol = Calculation.convertToLiter(data,
                                                  controller.teraTangkiWso!)
                                              .truncateToDouble();

                                          //case if stock taking IBC Storage
                                        } else if (widget
                                                .whProps[index].warehouse ==
                                            "WSO1") {
                                          vol = double.parse(data) * 1000;

                                          //case if inputting pending receive
                                        } else if (widget
                                                .whProps[index].warehouse ==
                                            "Pending Receive") {
                                          vol = double.parse(data) * 1000;

                                          //everything else uses lubcar tera
                                        } else {
                                          vol = Calculation.convertToLiter(
                                                  data, controller.teraLubcar!)
                                              .truncateToDouble();
                                        }

                                        //assigning the volume to local widget
                                        widget
                                            .whProps[index]
                                            .oilProperties[oliIndex]
                                            .depth = depth;
                                        widget.whProps[index]
                                            .oilProperties[oliIndex].vol = vol;
                                      } catch (e) {
                                        Get.snackbar("Error", e.toString());
                                        return;
                                      }
                                      setState(() {
                                        if (isEditing == false) {
                                          widget.callbackFunction(1);
                                        }
                                      });
                                    }
                                  },
                                ),
                              ),
                            );
                          })),
                    ),
                  ),
                )),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.greenAccent, shape: BoxShape.circle),
                        child: Visibility(
                          visible: index == 0 ? false : true,
                          child: IconButton(
                            enableFeedback: false,
                            onPressed: () {
                              carousel_c.previousPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            },
                            icon: Icon(
                              Icons.arrow_back_ios_rounded,
                              color: Colors.blue.shade900,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.greenAccent, shape: BoxShape.circle),
                        child: Visibility(
                          visible:
                              index == widget.whProps.length - 1 ? false : true,
                          child: IconButton(
                            onPressed: () {
                              carousel_c.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut);
                            },
                            icon: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.blue.shade900,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
        options: CarouselOptions(
          autoPlay: false,
          enlargeCenterPage: true,
          viewportFraction: 1,
          enableInfiniteScroll: false,
        ),
      ),
    );
  }
}

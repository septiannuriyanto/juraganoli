import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juraganoli/constants/theme.dart';
import 'package:juraganoli/model/logbook_report.dart';

class CartDialog extends StatelessWidget {
  List<LogbookReport> report;
  CartDialog({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: Get.width,
        // height: Get.height,
        decoration: BoxDecoration(color: Colors.white, borderRadius: rads(14)),
        child: ListView.separated(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: rads(12),
                            color: Colors.amber.shade100),
                        width: Get.width,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              report[index].transType == "OUT"
                                  ? const Icon(
                                      Icons.keyboard_double_arrow_up,
                                      color: Colors.redAccent,
                                    )
                                  : const Icon(
                                      Icons.keyboard_double_arrow_down,
                                      color: Colors.greenAccent,
                                    ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    report[index].jenisLimbah,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                  Text(
                                    report[index].reffNo,
                                    style: const TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                              Expanded(child: Container()),
                              Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(report[index].qtyLimbah.toString()),
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Get.back(result: index);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ))
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount: report.length),
      ),
    );
  }
}

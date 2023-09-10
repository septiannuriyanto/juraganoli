import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChoiceDialog extends StatelessWidget {
  ChoiceDialog({required this.dataGroup, super.key});
  List<dynamic> dataGroup;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 200,
          height: dataGroup.length * 56 > Get.width
              ? Get.width
              : dataGroup.length * 56,
          decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: const BorderRadius.all(Radius.circular(12))),
          child: ListView.builder(
            itemCount: dataGroup.length,
            itemBuilder: ((context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  hoverColor: Colors.white,
                  onTap: () {
                    Get.back(result: dataGroup.elementAt(index));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.green.shade200,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12))),
                    width: 120,
                    height: 40,
                    child: Center(
                      child: Text(dataGroup.elementAt(index)),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juraganoli/component/data_cart.dart';
import 'package:juraganoli/model/oilProperties.dart';
import 'package:loading_animations/loading_animations.dart';

class HomeAdditive extends GetView {
  List<WhProperties>? additiveProps;
  HomeAdditive({
    Key? key,
    required this.additiveProps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 0,
              child: Container(
                color: Theme.of(context).colorScheme.surfaceVariant,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "Stock Taking Additive",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
                child: additiveProps!.isEmpty || additiveProps == null
                    ? SizedBox(
                        width: Get.width,
                        height: Get.width,
                        child: LoadingBouncingGrid.square())
                    : ListView.separated(
                        itemCount: additiveProps!.length,
                        separatorBuilder: (context, index) => const Divider(),
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(additiveProps![0]
                                  .oilProperties[index]
                                  .depth
                                  .toString()),
                            ),
                          );
                        }))
          ],
        ),
      ),
    );
  }
}

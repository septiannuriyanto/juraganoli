import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../component/data_cart.dart';

class Home extends GetView<DataCart> {
  final datacon = Get.put(DataCart(), tag: "Home");
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Obx(
          () => Center(
            child: datacon.widgetOptions.elementAt(datacon.pageIndex.value),
          ),
        ),
        bottomNavigationBar: Container(
          // height: 80,
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: GNav(
                color: Colors.white,
                backgroundColor: Colors.black,
                activeColor: Colors.white,
                tabBackgroundColor: Colors.grey.shade800,
                onTabChange: (value) {
                  datacon.pageIndex.value = value;
                },
                gap: 8,
                tabs: const [
                  GButton(
                    padding: EdgeInsets.all(8),
                    icon: Icons.water_drop_rounded,
                    text: "Oli",
                  ),
                  GButton(
                    padding: EdgeInsets.all(8),
                    icon: Icons.settings_outlined,
                    text: "Grease",
                  ),
                  GButton(
                    padding: EdgeInsets.all(8),
                    icon: Icons.oil_barrel_rounded,
                    text: "Additive",
                  ),
                  GButton(
                    padding: EdgeInsets.all(8),
                    icon: Icons.delete_sweep_rounded,
                    text: "Waste",
                  ),
                ]),
          ),
        ));
  }
}

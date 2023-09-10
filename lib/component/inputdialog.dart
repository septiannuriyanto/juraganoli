import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InputDialog extends StatelessWidget {
  InputDialog({super.key});

  final inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.all(Radius.circular(12))),
        width: Get.width,
        height: 160,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text("Tinggi sonding (cm)"),
              TextField(
                autofocus: true,
                controller: inputController,
                onSubmitted: (value) {
                  Get.back(result: inputController.text);
                },
                keyboardType: TextInputType.number,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ElevatedButton(
                    onPressed: () {
                      Get.back(result: inputController.text);
                    },
                    child: const Text('Submit')),
              )
            ],
          ),
        ),
      ),
    );
  }
}

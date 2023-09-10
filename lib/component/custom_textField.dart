import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:juraganoli/constants/theme.dart';

class CustomTextField extends StatelessWidget {
  String? hint;
  CustomTextField({
    Key? key,
    this.hint,
    this.prefIcon,
    this.inputFormatters,
    this.keyboardType,
    this.controller,
    this.onChanged,
  }) : super(key: key);
  Widget? prefIcon;
  List<TextInputFormatter>? inputFormatters;
  TextInputType? keyboardType;
  TextEditingController? controller;
  Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: rads(10)),
        child: TextFormField(
          controller: controller,
          keyboardType: keyboardType ?? TextInputType.text,
          inputFormatters: inputFormatters ?? [],
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
              prefixIcon: prefIcon ??
                  const SizedBox(
                    width: 20,
                    height: 20,
                  ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              fillColor: Colors.white,
              border: InputBorder.none,
              hintText: hint ?? ""),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

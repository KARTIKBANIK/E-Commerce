import 'package:flutter/material.dart';

Widget myT_Field(
  String hintText,
  keyBoardType,
  controller,
) {
  return TextFormField(
    keyboardType: keyBoardType,
    controller: controller,
    decoration: InputDecoration(hintText: hintText),
    // validator: (value) {
    //   if (value!.isEmpty) {
    //     return "enter your birth date";
    //   }
    // },
  );
}

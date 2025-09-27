 import 'package:flutter/material.dart';
 Future<void> showDate(context , Function(dynamic) setDate)
 async {
await   showDatePicker(
       context: context,
       initialDate: DateTime.now(),
       firstDate: DateTime.parse("2023-02-01"),
       lastDate: DateTime.now().add(const Duration(days: 30)))
       .then( setDate);

 }
import 'dart:developer';

import 'package:csv/csv.dart';
import 'package:flutter/services.dart';

import '../generated/assets.dart';
import 'createDB.dart';

class Labs {
  static List<dynamic> dataLabCSV = [];
  static loadLabsCSV() async {
    final rawData = await rootBundle.loadString(Assets.csvLabs);
    List<List<dynamic>> listData = const CsvToListConverter().convert(rawData);
    dataLabCSV = listData.first.toString().replaceAll('\n', ',').split(',');
    await _insertLabs();
  }

  static _insertLabs() async {
    for (var element in dataLabCSV) {
      log("element in dataLabCSV $element");

      await database.transaction((txn) =>
          txn.rawInsert('INSERT INTO Labs(LabsName) VALUES(?)', [element]));
    }
  }
}

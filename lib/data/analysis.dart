import 'dart:developer';

import 'package:csv/csv.dart';
import 'package:flutter/services.dart';

import '../generated/assets.dart';
import 'createDB.dart';

class Analysis {
  static List<List<dynamic>> dataAnalysisCSV = [];

  static loadAnalysisCSV() async {
    final rawData = await rootBundle.loadString(Assets.csvAnlysis);
    List<List<dynamic>> listData = const CsvToListConverter().convert(rawData);
    dataAnalysisCSV = listData;
    await _insertAnalysis();
  }

  static _insertAnalysis() async {
    for (var element in dataAnalysisCSV) {
      if (element.isNotEmpty && element.length >= 2) {
        log("element in dataAnalysisCSV $element");
        await database.transaction((txn) => txn.rawInsert(
            "INSERT INTO Analysis(AnalysisName,AnalysisPrice) VALUES(?,?)",
            [element[0], element[1]]));
      }
    }
  }
}

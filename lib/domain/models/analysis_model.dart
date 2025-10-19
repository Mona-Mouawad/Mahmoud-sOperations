import 'dart:developer';

import 'package:flutter/foundation.dart';

import '../../data/createDB.dart';

class AnalysisModel with ChangeNotifier {
  List<AnalysisData> analysisList = [];

  Future getAnalysisList(
    String searchName,
  ) async {
    analysisList = [];
    await database.rawQuery('SELECT * FROM Analysis').then((value) {
      for (var element in value) {
        AnalysisData data = AnalysisData.fromJson(element);
        analysisList.add(data);
        notifyListeners();
      }
      log("AnalysisData length  ${analysisList.length}");
    }).then((value) => getAnalysisName(searchName));
  }

  deleteAnalysisById(
    int analysisId,
    String searchName,
  ) async {
    database.rawDelete('DELETE FROM Analysis  WHERE AnalysisId =?',
        [analysisId]).then((value) => getAnalysisList(searchName));
  }

  editAnalysisByID(int analysisId, String analysisName, dynamic price,
      String searchName) async {
    log("editAnalysisByID   analysisName  $analysisName   analysisId  $analysisId  ");
    await database.rawUpdate(
        'UPDATE Analysis SET AnalysisName = ?, AnalysisPrice = ? WHERE AnalysisId = ?',
        [analysisName, price, analysisId]).then((value) {
      log("editAnalysisByID   $value   $price");
      getAnalysisList(searchName);
    });
  }

  Future<void> insertNewAnalysis(
    String name,
    dynamic price,
    String searchName,
  ) async {
    await database
        .transaction((txn) => txn
                .rawInsert(
                    'INSERT INTO Analysis (AnalysisName , AnalysisPrice) VALUES("$name",$price)')
                .then((value) {
              log('Analysis $value inserted');
            }))
        .then((value) => getAnalysisList(searchName));
  }

  List<AnalysisData> analysisNameList = [];

  getAnalysisName(String name) {
    log("analysisList length   $name ${analysisList.length}");
    analysisNameList = analysisList
        .where((element) =>
            element.analysisName!.toUpperCase().contains(name.toUpperCase()))
        .toList();
    notifyListeners();
    log("getAnalysisName length   $name ${analysisNameList.length}");
  }
}

class AnalysisData {
  int? analysisId;
  String? analysisName;
  double? analysisPrice;
  int analysisQuantity = 0;

  AnalysisData(this.analysisId, this.analysisName, this.analysisPrice,
      this.analysisQuantity);

  AnalysisData.fromJson(Map<String, dynamic> json) {
    analysisId = json['AnalysisId'];
    analysisName = json['AnalysisName'] ?? "";
    analysisPrice = json['AnalysisPrice'];
    analysisQuantity = json['analysisQuantity'] ?? 0;
  }
}

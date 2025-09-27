
import 'dart:developer';
import 'package:flutter/foundation.dart';
import '../createDB.dart';

class LabReportModel with ChangeNotifier {

  List<LabsAnalysisData> labReportList = [];
  getLabsDailyReport(String day , int labId) async {
    labReportList = [];
    await database
        .rawQuery(
        'SELECT Sum(r.AnalysisPrice) AnalysisPrice ,Sum(r.analysisQuantity) analysisQuantity , r.date ,Analysis.AnalysisName '
            'FROM report r JOIN Analysis  ON r.AnalysisId = Analysis.AnalysisId '
            'group by  r.AnalysisId ,r.date , r.Labs_Id ' //
            'Having r.date = ${day.replaceAll("-", "")} and  r.Labs_Id = $labId '
            'order by Sum(r.analysisQuantity) DESC'
    )
        .then((value) {
      log('getAllReport  $value got');
      for (var element in value) {
        LabsAnalysisData data = LabsAnalysisData.fromJson(element);
        labReportList.add(data);
      }
      notifyListeners();
    });
  }

  getLabsMonthlyReport(String firstDate , String lastDate , int labId) async {
    labReportList = [];
    await database
        .rawQuery(
        'SELECT Sum(r.AnalysisPrice) AnalysisPrice ,Sum(r.analysisQuantity) analysisQuantity , r.date ,Analysis.AnalysisName'
            ' FROM report r JOIN Analysis  ON r.AnalysisId = Analysis.AnalysisId '
            'Where r.date >= ${firstDate.replaceAll("-", "")} and  r.date <= ${lastDate.replaceAll("-", "")} '
            'group by  r.AnalysisId  , r.Labs_Id ' // ,r.date
            'Having  r.Labs_Id = $labId order by Sum(r.analysisQuantity) DESC'
    )
        .then((value) {
      log('getAllReport  $value got');
      for (var element in value) {
        LabsAnalysisData data = LabsAnalysisData.fromJson(element);
        labReportList.add(data);
      }
      notifyListeners();
    });
  }

}



class LabsAnalysisData{
  int ? analysisId ;
  int ? analysisQuantity ;
  String ? analysisName ;
  double ? analysisPrice ;

  LabsAnalysisData.fromJson(Map<String,dynamic> json)
  {
    analysisId = json['AnalysisId'];
    analysisName = json['AnalysisName'];
    analysisPrice = json['AnalysisPrice'];
    analysisQuantity = json['analysisQuantity'];
  }
}
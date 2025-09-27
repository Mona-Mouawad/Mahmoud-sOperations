import 'package:flutter/foundation.dart';
import '../../domain/models/analysis_model.dart';
import '../createDB.dart';

class AnalysisReportData with ChangeNotifier{
   List<AnalysisData> reportAnalysisList = [];

   getAllReport() async {
    reportAnalysisList = [];
    await database
        .rawQuery(
          'SELECT Sum(r.AnalysisPrice) AnalysisPrice ,Sum(r.analysisQuantity) analysisQuantity , Analysis.AnalysisName FROM report r JOIN Analysis  ON r.AnalysisId = Analysis.AnalysisId '
                'group by  r.AnalysisId  '
                'order by Sum(r.analysisQuantity) DESC'
    ).then((value) {
        for (var element in value) {
        AnalysisData data = AnalysisData.fromJson(element);
        reportAnalysisList.add(data);
      }
      notifyListeners();
    });
  }
  // static List<Map> ReportRepresentative = [];
  // static double sum =0 ;
  //
  // static getReportRepresentativeWithLabsBetween( String date1, String date2, int Representatives_id) async {
  //   ReportRepresentative = [];
  //   sum =0 ;
  //   await database
  //       .rawQuery(
  //           'SELECT Sum(r.price) totalPrice ,r.Representatives_id , l.LabsName FROM report r JOIN Labs l ON r.Labs_id = l.id '
  //           'where  r.date >= ${date1.replaceAll("-", "")} and r.date <= ${date2.replaceAll("-", "")} and r.Representatives_id= $Representatives_id group by r.Labs_id')
  //       .then((value) {
  //     value.forEach((element) {
  //       ReportRepresentative.add(element);
  //       sum += element['totalPrice'] as double;
  //     });
  //   });
  // }
  //
  // static getReportRepresentativeWithAnalysisBetween( String date1, String date2, int Representatives_id) async {
  //   ReportRepresentative = [];
  //   sum =0 ;
  //   await database
  //       .rawQuery(
  //           'SELECT Sum(r.price) totalPrice ,Sum(r.quantity) quantity ,r.Analysis_id , Analysis.AnalysisName FROM report r JOIN Analysis  ON r.Analysis_id = l.AnalysisId '
  //           'where  r.date >= ${date1.replaceAll("-", "")} and r.date <= ${date2.replaceAll("-", "")} and r.Representatives_id= $Representatives_id group by r.Analysis_id')
  //       .then((value) {
  //     value.forEach((element) {
  //       ReportRepresentative.add(element);
  //       sum += element['totalPrice'] as double;
  //     });
  //   });
  // }

}

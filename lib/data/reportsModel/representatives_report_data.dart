import 'dart:developer';
import 'package:flutter/material.dart';
import '../createDB.dart';

class RepresentativesReportData with ChangeNotifier {

   List<RepresentativesLabsData> representativesLabsReport = [];
   TextEditingController chargingController = TextEditingController();
   TextEditingController transmissionController = TextEditingController();

   double transValue =0 ;
   double chargingValue =0 ;
   double sum =0 ;

  void clear()
   {
     representativesLabsReport = [];
      chargingController.clear();
      transmissionController.clear();
      transValue =0 ;
      chargingValue =0 ;
      sum =0 ;
     notifyListeners();
   }

   void calculateTotal() {
     sum =   representativesLabsReport.fold(0, (previousValue, element) =>
     previousValue + (element.analysisPrice!)
     );
     sum -= chargingValue ;
     sum -=  transValue ;
     // notifyListeners() ;
   }
 Future<void> getRepresentativesDailyReport(String day , int representativesId) async {
    representativesLabsReport = [];
    await database
        .rawQuery(
            'SELECT Sum(r.AnalysisPrice) AnalysisPrice ,Sum(r.analysisQuantity) analysisQuantity , r.date ,Labs.LabsName ,r.Labs_Id '
                ' FROM report r JOIN Labs  ON r.Labs_Id = Labs.LabsId '
                'group by  r.Labs_Id ,r.date , r.Representatives_Id ' //
                'Having r.date = ${day.replaceAll("-", "")} and  r.Representatives_Id = $representativesId'
    ).then((value) async {
      log('getRepresentativesDailyReport  $value got');
      for (var element in value) {
        RepresentativesLabsData data = RepresentativesLabsData.fromJson(element);
        representativesLabsReport.add(data);
           }
      await database
          .rawQuery(
          'SELECT * FROM RepresentativesDayCost '
              'where date = ${day.replaceAll("-", "")} and  Representatives_Id = $representativesId'
      ).then((value) async {
        log(" value get all RepresentativesDayCost $value");
        if(value.isEmpty){
          transValue =  4.0 * representativesLabsReport.length  ;
          chargingValue = 0;
          await setRepresentativesDayCost(day, representativesId);
        }
        else{
          transValue  = (value[0]['transmission'] ?? (4.0 * representativesLabsReport.length) )as double;
          chargingValue = (value[0]['charging'] ?? 0 ) as double;
          transValue = (transValue == 0)? (4.0 * representativesLabsReport.length) :  transValue ;
          log(" chargingValue  $transValue");
          await updateRepresentativesDayCost(value[0]['id']);
         }
        notifyListeners();
        chargingController.text = chargingValue.toString() ;
        transmissionController.text = transValue.toString() ;
        log(" transmissionController  $transValue");
        log(" chargingController  $chargingValue");
      }).catchError((onError){
        transValue =  4.0 * representativesLabsReport.length  ;
        chargingValue = 0;
        chargingController.text = chargingValue.toString() ;
        transmissionController.text = transValue.toString() ;
        notifyListeners();
      });
      notifyListeners();
    });
  }


   Future<void> setRepresentativesDayCost(String date , int representativesId )async  {
    await database.transaction((txn) =>
        txn.rawInsert(
            'INSERT INTO RepresentativesDayCost(date,transmission,charging,Representatives_Id ) '
                'VALUES(${date.replaceAll("-", "")},$transValue,$chargingValue,$representativesId )')
    ).then((value) => log("value  setRepresentativesDayCost  $value"));
  }

   Future<void> updateRepresentativesDayCost(id)async
  {
    await database.rawUpdate(
            'UPDATE  RepresentativesDayCost SET transmission =? ,charging =?  WHERE id =? ',
                [transValue,chargingValue,id ])
    .then((value) => log("value  updateRepresentativesDayCost  $value"));

  }
   Future<void> checkRepresentativesDayCost(String date , int representativesId ) async {
    await database
        .rawQuery(
        'SELECT id FROM RepresentativesDayCost '
            'where date = ${date.replaceAll("-", "")} and Representatives_Id = $representativesId'
    ).then((value) async {
     if(value.isEmpty) {
       log("setRepresentativesDayCost");
      await setRepresentativesDayCost(date, representativesId);
     }
     else {
       log("updateRepresentativesDayCost  ${value[0]['id']}");
       await updateRepresentativesDayCost(value[0]['id']);
      }
    });

  }

  getRepresentativesMonthlyReport(String firstDate , String lastDate , int representativesId) async {
    representativesLabsReport = [];
    await database
        .rawQuery(
            'SELECT Sum(r.AnalysisPrice) AnalysisPrice ,Sum(r.analysisQuantity) analysisQuantity , r.date ,Labs.LabsName FROM report r JOIN Labs  ON r.Labs_Id = Labs.LabsId '
                'Where r.date >= ${firstDate.replaceAll("-", "")} and  r.date <= ${lastDate.replaceAll("-", "")} '
               'group by  r.Labs_Id  , r.Representatives_Id ' // ,r.date
                'Having  r.Representatives_Id = $representativesId'
    )
        .then((value) {
      log('getRepresentativesMonthlyReport  $value got');
      for (var element in value) {
        RepresentativesLabsData data = RepresentativesLabsData.fromJson(element);
        representativesLabsReport.add(data);
      }
      notifyListeners();
    }).then((value) async {
      await database
          .rawQuery(
          'SELECT Sum(transmission) transmission, Sum(charging) charging  FROM RepresentativesDayCost '
              'where date >= ${firstDate.replaceAll("-", "")} and  date <= ${lastDate.replaceAll("-", "")} and  Representatives_Id = $representativesId'
      ).then((value) {
        log(" value det all RepresentativesDayCost $value");
        if(value.isEmpty){
          transValue =  4.0 * representativesLabsReport.length  ;
          chargingValue = 0;
        }
        else{
          transValue  = (value[0]['transmission'] ?? (4.0 * representativesLabsReport.length) )as double;
          chargingValue = (value[0]['charging'] ?? 0 ) as double;
          transValue =   ( transValue == 0) ? 4.0 * representativesLabsReport.length :  transValue ;
        }
        notifyListeners();
        chargingController.text = chargingValue.toString() ;
        transmissionController.text = transValue.toString() ;
        log(" transmissionController  $transValue");
        log(" chargingController  $chargingValue");
      }).catchError((onError){
        transValue =  4.0 * representativesLabsReport.length  ;
        chargingValue = 0;

        chargingController.text = chargingValue.toString() ;
        transmissionController.text = transValue.toString() ;
        notifyListeners();
      });
    });
  }
}


class RepresentativesLabsData{
  int ? labId ;
  int ? analysisQuantity ;
  String ? labName ;
  double ? analysisPrice ;

  RepresentativesLabsData.fromJson(Map<String,dynamic> json)
  {
    labId = json['Labs_Id'];
    labName = json['LabsName'];
    analysisPrice = json['AnalysisPrice'];
    analysisQuantity = json['analysisQuantity'];
  }
}

import 'dart:developer';

import 'package:new_app_mahmoud/data/reportsModel/representatives_report_data.dart';
import 'package:provider/provider.dart';

import '../domain/models/analysis_model.dart';
import '../presentation/resources/constants_manager.dart';
import '../presentation/resources/strings_manager.dart';
import 'createDB.dart';

class InsertTotDB {


  static Future addRequest(context,{
    required String date,
    required int representativesId,
    required int labsId,
    required  List<AnalysisData> analysisSelectedList
  }) async
  {
    RepresentativesReportData reportData =Provider.of<RepresentativesReportData>(context,listen: false);
    log("addRequest transValue = ${reportData.transValue}  chargingValue = ${reportData.chargingValue}") ;
    for (var element in analysisSelectedList) {
       database.transaction((txn) =>
          txn.rawInsert(
              'INSERT INTO report(date,analysisQuantity,Labs_Id,Representatives_Id,AnalysisId,AnalysisPrice) '
               'VALUES(${date.replaceAll("-", "")},${element.analysisQuantity},$labsId,$representativesId,${element.analysisId},${element.analysisQuantity *element.analysisPrice!})')
      ).then((value) async {
        AppConstants.myToast(context: context, text: AppStrings.entryDone, state: ToastStates.success);
      } );
    }
    await database
        .rawQuery(
        'SELECT * FROM RepresentativesDayCost '
            'where date = ${date.replaceAll("-", "")} and Representatives_Id = $representativesId'
    ).then((value) async {
      if(value.isEmpty){
        reportData.transValue = 4.0 ;
        reportData.chargingValue = 0;
        await reportData.setRepresentativesDayCost(date, representativesId);
        log("addRequest set transValue = ${reportData.transValue}  chargingValue = ${reportData.chargingValue}") ;
      }
      else{
        reportData.transValue =    (value[0]['transmission'] ?? 0 )as double;
        reportData.chargingValue = (value[0]['charging'] ?? 0 ) as double;
        reportData.transValue =  (reportData.transValue == 0) ?  4.0 : reportData.transValue + 4 ;
        await reportData.updateRepresentativesDayCost(value[0]['id']);
        log("addRequest update transValue = ${reportData.transValue}  chargingValue = ${reportData.chargingValue}") ;
      }
      log("addRequest transValue = ${reportData.transValue}  chargingValue = ${reportData.chargingValue}") ;
    });
  }

  static Future removeRequest(context,{
    required String date,
    required int representativesId,
    required int labsId,
    required  List<AnalysisData> analysisSelectedList
  }) async
  {
    for (var element in analysisSelectedList) {
       database.transaction((txn) =>
          txn.rawInsert(
              'INSERT INTO report(date,analysisQuantity,Labs_Id,Representatives_Id,AnalysisId,AnalysisPrice) '
               'VALUES(${date.replaceAll("-", "")},-${element.analysisQuantity},$labsId,$representativesId,${element.analysisId},-${element.analysisQuantity *element.analysisPrice!})')
      ).then((value) => AppConstants.myToast(context: context, text: AppStrings.entryDone, state: ToastStates.success));
    }
  }

}
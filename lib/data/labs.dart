import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import '../generated/assets.dart';
import 'createDB.dart';

class Labs {

  static  List<List<dynamic>> dataLabCSV = [];
  static loadLabsCSV() async {
    final rawData = await rootBundle.loadString(Assets.csvLabs);
    List<List<dynamic>> listData = const CsvToListConverter().convert(rawData);
    dataLabCSV = listData;
    _insertLabs();
  }

 static   _insertLabs() async  {
    for (var element in dataLabCSV) {
       database.transaction((txn) => txn
          .rawInsert(
          'INSERT INTO Labs(LabsName) VALUES("${element[0]}")')
        );
    }
  }


}
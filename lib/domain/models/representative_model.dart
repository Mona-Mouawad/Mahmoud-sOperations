
import 'dart:developer';
import 'package:flutter/foundation.dart';
import '../../data/createDB.dart';

  class RepresentativeModel with ChangeNotifier{
    List <RepresentativeData> representativeList =[] ;
     getRepresentatives() async {
      await database.rawQuery('SELECT * FROM Representatives').then((value) {
        representativeList = [];
        for (var element in value) {
          RepresentativeData data = RepresentativeData.fromJson(element);
          representativeList.add(data);
        }
      }).then((value) {
        log("representativeList length  ${representativeList.length}") ;
        notifyListeners();});
    }
    getRepresentativeByName(String name) async {
      representativeList = [];
      log("RepresentativeData data  getRepresentativesByName}");
      if(name.isNotEmpty) {
        await database
            .rawQuery('SELECT * FROM Representatives where RepresentativesName like "%$name%"')
            .then((value) {
          for (var element in value) {
            RepresentativeData data = RepresentativeData.fromJson(element);
            representativeList.add(data);
          }
        }).then((value) =>   notifyListeners());
      }
    }
  }

  class RepresentativeData{

    int ? representativeId ;
    String ? representativeName ;


    RepresentativeData.fromJson(Map<String,dynamic> json)
    {
      representativeId = json['RepresentativesId'];
      representativeName = json['RepresentativesName'];
    }
  }
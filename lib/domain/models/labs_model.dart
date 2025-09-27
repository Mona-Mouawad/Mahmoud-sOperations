
import 'dart:developer';
import 'package:flutter/foundation.dart';
import '../../data/createDB.dart';

class LabModel with ChangeNotifier{
  List <LabData> labsList =[] ;

 Future getLabsList() async {
    labsList = [];
    log("LabData data  getLabsList}");
    await database.rawQuery('SELECT * FROM Labs').then((value) {
      for (var element in value) {
        LabData data = LabData.fromJson(element);
        labsList.add(data);
        // log("LabData data  ${data.labName}");
      }
    }).then((value) =>  notifyListeners());
  }

  getLabsByName(String name) async {
    log("LabData data  getLabsByName");
    if(name.isNotEmpty) {
      labsList = [];
      await database
          .rawQuery('SELECT * FROM Labs where LabsName like "$name%"')
          .then((value) {
        for (var element in value) {
          LabData data = LabData.fromJson(element);
          labsList.add(data);
          notifyListeners();
        }
      }).then((value) =>   notifyListeners());
    }
    else{
      getLabsList();
    }
    notifyListeners();
  }

  deleteLabById(int labsId ,String searchName , ) async {
    database.rawDelete('DELETE FROM Labs  WHERE LabsId =?',
        [labsId]).then((value) => getLabsByName(searchName));
  }

 Future editLabByID(int labsId ,String labsName,String searchName ) async {    log("editLabByID   labsName  $labsName   labsId  $labsId  ");
  await  database.rawUpdate('UPDATE Labs SET LabsName = ? WHERE LabsId =?',
        [labsName,labsId]).then((value) async {
          log("editLabByID $value  ");
    await getLabsByName(searchName);
  });
  }

  Future<void> insertNewLabs(String name,String searchName) async {
    await database.transaction((txn) =>
        txn.rawInsert('INSERT INTO Labs (LabsName) VALUES("$name")')
            .then((value) {
          log('Labs $value inserted');
          getLabsByName(searchName);
        }));
  }

}

class LabData{
  int ? labId ;
  String ? labName ;

  LabData.fromJson(Map<String,dynamic> json)
  {
    labId = json['LabsId'];
    labName = json['LabsName'];
  }
}
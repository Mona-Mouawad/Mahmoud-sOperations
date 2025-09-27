
import 'dart:developer';
import 'createDB.dart';

class Representatives{

  static  Future insertRepresentatives() async {
    await database.transaction((txn) =>
        txn.rawInsert('INSERT INTO Representatives(RepresentativesName) VALUES("محمود فتحي داود")')
            .then((value) {
          log('$value inserted');
        }));
    await database.transaction((txn) =>
        txn.rawInsert('INSERT INTO Representatives(RepresentativesName) VALUES("أحمد بيومي منير")')
            .then((value) {
          log('$value inserted');
        }));
    await database.transaction((txn) =>
        txn.rawInsert('INSERT INTO Representatives(RepresentativesName) VALUES("يوسف مجدي حسانين")')
            .then((value) {
          log('$value inserted');
        }));
    await database.transaction((txn) =>
        txn.rawInsert('INSERT INTO Representatives(RepresentativesName) VALUES("علي فايق حسونة")')
            .then((value) {
          log('$value inserted');
        }));
    await database.transaction((txn) =>
        txn.rawInsert('INSERT INTO Representatives(RepresentativesName) VALUES("محمد خيري نافع")')
            .then((value) {
          log('$value inserted');
        }));
    await database.transaction((txn) =>
        txn.rawInsert('INSERT INTO Representatives(RepresentativesName) VALUES("شريف اشرف شحاته")')
            .then((value) {
          log('$value inserted');
        }));
    await database.transaction((txn) =>
        txn.rawInsert('INSERT INTO Representatives(RepresentativesName) VALUES("محمد سعيد بنها")')
            .then((value) {
          log('$value inserted');
        }));
    await database.transaction((txn) =>
        txn.rawInsert('INSERT INTO Representatives(RepresentativesName) VALUES("مصطفى ياسر بنها")')
            .then((value) {
          log('$value inserted');
        }));
  }

 static Future editRepresentative(int representativesId ,String representativesName ) async  {
    log("editRepresentative  $representativesId  $representativesName") ;
    database.rawUpdate('UPDATE Representatives SET RepresentativesName = ? WHERE RepresentativesId =?',
        [representativesName,representativesId]).then((value) => log( "editRepresentative  value $value"));
  }
 static Future addRepresentative(String representativesName ) async  {
    await database.transaction((txn) =>
        txn.rawInsert('INSERT INTO Representatives(RepresentativesName) VALUES("$representativesName")')
            .then((value) {
          log('$value inserted');
        }));
  }
 static Future deleteRepresentativesById(int representativesId ,) async {
    database.rawDelete('DELETE FROM Representatives  WHERE RepresentativesId =?',
        [representativesId]);
  }

// static List<Map<String,dynamic>> RepresentativesList = [];
  // static getRepresentativesID(String Name) async {
  //   var Representative = (RepresentativesList.firstWhere((Representatives) => Representatives['name'] == Name));
  // print ( Representative['id']) ;
  // return  Representative['id'] ;
  // }

}
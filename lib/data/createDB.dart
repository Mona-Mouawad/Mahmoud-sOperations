import 'dart:developer';
import '../App/share_preference.dart';
import '../presentation/resources/constants_manager.dart';
import '../data/representatives.dart';
import 'package:sqflite/sqflite.dart';
import 'analysis.dart';
import 'labs.dart';

late Database database;

createDatabase() async
{
  database = await openDatabase('labs.db', version: 1,
      onCreate: (database, version) async
      {
    await database
        .execute(
            'CREATE TABLE Representatives(RepresentativesId INTEGER PRIMARY KEY, RepresentativesName TEXT)')
        .then((value) {
      log('create Representative db');

    });
    await database
        .execute(
            'CREATE TABLE Analysis(AnalysisId INTEGER PRIMARY KEY, AnalysisName TEXT ,AnalysisPrice REAL)')
        .then((value) => log('create Analysis db'));


    await database
        .execute('CREATE TABLE Labs(LabsId INTEGER PRIMARY KEY , LabsName TEXT )')
        .then((value) => log('create Labs db'));

    await database
        .execute(
            'CREATE TABLE report(id INTEGER PRIMARY KEY , date INTEGER ,analysisQuantity INTEGER ,'
                'AnalysisPrice REAL ,Labs_Id INTEGER ,'
                'Representatives_Id INTEGER,AnalysisId INTEGER,'
            'FOREIGN KEY(Labs_Id) REFERENCES Labs (id),'
            'FOREIGN KEY(AnalysisId) REFERENCES Labs (AnalysisId),'
            'FOREIGN KEY(Representatives_Id) REFERENCES Representatives (id) )')
        .then((value) => log('create report db'));




    await database
        .execute(
            'CREATE TABLE RepresentativesDayCost(id INTEGER PRIMARY KEY , date INTEGER ,transmission REAL ,charging REAL ,'
                'Representatives_Id INTEGER,'
            'FOREIGN KEY(Representatives_Id) REFERENCES Representatives (id) )')
        .then((value) => log('create RepresentativesDayCost db'));
  },
      onOpen: (database) async {
        try {
          final result = await database.rawQuery(
              "PRAGMA table_info(report)"
          );

          final columnExists = result.any(
                  (col) => col['name'] == 'PatientName'
          );

          if (!columnExists) {
            await database.execute(
                'ALTER TABLE report ADD COLUMN PatientName TEXT'
            );
            log('PatientName column added successfully');
          } else {
            log('PatientName column already exists');
          }
        } catch (e) {
          log('Error: $e');
        }

  }).then((value) async => database = value

   );



  // // await Labs.DeleteLabs();
  if(AppConstants.appFirstOpen==false){
    await Labs.loadLabsCSV();
    await Representatives.insertRepresentatives();
    await Analysis.loadAnalysisCSV();
    CacheHelper.saveData();
  }

}


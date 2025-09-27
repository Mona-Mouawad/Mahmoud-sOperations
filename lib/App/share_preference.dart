
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import '../presentation/resources/constants_manager.dart';

class CacheHelper{
  static late SharedPreferences _shared ;

  static init()async{
    _shared = await SharedPreferences.getInstance();
    AppConstants.appFirstOpen = _shared.getBool("AppFristOpen") ?? false ;
      }

static saveData (){
     _shared.setBool("AppFristOpen",true);
     log("_shared.getBool  AppFirstOpen true");
}


}
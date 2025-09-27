import 'package:flutter/material.dart';
import 'App/my_app.dart';
import 'App/share_preference.dart';
import 'data/createDB.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await createDatabase();
  runApp(const MyApp());
}

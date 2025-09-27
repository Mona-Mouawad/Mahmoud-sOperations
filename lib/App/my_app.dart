import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/reportsModel/analysis_report_data.dart';
import '../data/reportsModel/representatives_report_data.dart';
import '../data/reportsModel/lab_report_data.dart';
import '../domain/models/analysis_model.dart';
import '../domain/models/labs_model.dart';
import '../domain/models/representative_model.dart';
import '../presentation/Screens/home.dart';
import '../presentation/resources/routes_manger.dart';
import '../presentation/resources/theme_manager.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: LabReportModel()..getLabsDailyReport("2023-12-21", 1)),
        ChangeNotifierProvider.value(value: RepresentativeModel()..getRepresentatives()),
        ChangeNotifierProvider.value(value: AnalysisModel()),
        ChangeNotifierProvider.value(value: LabModel()),
        ChangeNotifierProvider.value(value: AnalysisReportData()..getAllReport()),
        ChangeNotifierProvider.value(value: RepresentativesReportData()),
    // Provider<LabReportData>( create: (context) => LabReportData(),)
      ],
    child: MaterialApp(
          theme: getTheme(),
          home: const MainRoute(),
          // initialRoute: Routes.mainRout,
          onGenerateRoute: RouteGenerator.getRoute,
          debugShowCheckedModeBanner: false,
        ),
    );
  }
}

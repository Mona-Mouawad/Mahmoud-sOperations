import 'package:flutter/material.dart';

import '../Screens/AnalysisScreen/analysis_list_screens.dart';
import '../Screens/AnalysisScreen/analysis_report_screen.dart';
import '../Screens/AnalysisScreen/analysis_screens.dart';
import '../Screens/LabsScreens/lab_day_report_screen.dart';
import '../Screens/LabsScreens/lab_monthly_report_screen.dart';
import '../Screens/LabsScreens/labs_list_screens.dart';
import '../Screens/LabsScreens/labs_screens.dart';
import '../Screens/addRequestsScreen/new_request_screen.dart';
import '../Screens/home.dart';
import '../Screens/representativesScreens/representative_day_report_screen.dart';
import '../Screens/representativesScreens/representative_monthly_report_screen.dart';
import '../Screens/representativesScreens/representatives_list_screens.dart';
import '../Screens/representativesScreens/representatives_screens.dart';
import '../resources/strings_manager.dart';

class Routes {
  static const String mainRout = '/main';

  static const String representativesScreens = "/representativesScreens";
  static const String representativesListScreens =
      "/representativesListScreens";
  static const String labsScreens = "/labsScreens";
  static const String labsListScreens = "/labsListScreens";
  static const String analysisScreens = "/analysisScreens";
  static const String analysisListScreens = "/analysisListScreens";
  static const String searchWidgetFilter = "/searchWidgetFilter";
  static const String analysisReportScreen = "/analysisReportScreen";
  static const String representativeDayReportScreen =
      "/RepresentativeDayReportScreen";
  static const String representativeMonthlyReportScreen =
      "/representativeMonthlyReportScreen";
  static const String labDayReportScreen = "/LabDayReportScreen";
  static const String labMonthlyReportScreen = "/labMonthlyReportScreen";
  // static const String printerScreen = "/PrinterScreen";
}

class RouteGenerator {
  // BuildContext context
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.mainRout:
        return MaterialPageRoute(builder: (_) => const MainRoute());

      case Routes.representativesScreens:
        return MaterialPageRoute(
            builder: (_) => const RepresentativesScreens());

      case Routes.representativesListScreens:
        return MaterialPageRoute(
            builder: (_) => const RepresentativesListScreens());

      case Routes.labsScreens:
        return MaterialPageRoute(builder: (_) => const LabsScreens());

      case Routes.labsListScreens:
        return MaterialPageRoute(builder: (_) => const LabsListScreens());

      case Routes.analysisListScreens:
        return MaterialPageRoute(builder: (_) => AnalysisListScreens());
      case Routes.analysisScreens:
        return MaterialPageRoute(builder: (_) => const AnalysisScreens());

      case Routes.searchWidgetFilter:
        return MaterialPageRoute(builder: (_) => const NewRequest());

      case Routes.analysisReportScreen:
        return MaterialPageRoute(builder: (_) => const AnalysisReportScreen());

      case Routes.representativeDayReportScreen:
        return MaterialPageRoute(
            builder: (_) => const RepresentativeDayReportScreen());

      case Routes.representativeMonthlyReportScreen:
        return MaterialPageRoute(
            builder: (_) => const RepresentativeMonthlyReportScreen());

      case Routes.labDayReportScreen:
        return MaterialPageRoute(builder: (_) => const LabDayReportScreen());

      case Routes.labMonthlyReportScreen:
        return MaterialPageRoute(
            builder: (_) => const LabMonthlyReportScreen());

      // case Routes.printerScreen:
      //   return MaterialPageRoute(builder: (_) => printerScreen());

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => const Scaffold(
              body: Center(child: Text(AppStrings.noRouteFound)),
            ));
  }
}

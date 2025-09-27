import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/reportsModel/representatives_report_data.dart';
import '../../Widgets/list_tile_items.dart';
import '../../Widgets/menu_appbar.dart';
import '../../Widgets/my_drawer.dart';
import '../../resources/routes_manger.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';
import 'overlays.dart';

class RepresentativesScreens extends StatelessWidget {
  const RepresentativesScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: menuAppBar(context, title: AppStrings.representatives),
        drawer: const MyDrawer(),
        body: Center(
          child: Card(
            margin: const EdgeInsets.all(AppMargin.m30),
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p8, vertical: AppPadding.p16),
              height: AppSize.s270,
              child: ListView(
                children: [
                  listTileItems(context, AppStrings.representatives, () {
                    Navigator.pushNamed(
                        context, Routes.representativesListScreens);
                  }),
                  listTileItems(context, AppStrings.addRepresentatives, () {
                    showAddItemOverLay(context, AppStrings.addRepresentatives);
                  }),
                  listTileItems(context, AppStrings.representativesReportDaily,
                      () {
                    Provider.of<RepresentativesReportData>(context,
                            listen: false)
                        .clear();
                    Navigator.pushNamed(
                        context, Routes.representativeDayReportScreen);
                  }),
                  listTileItems(
                      context, AppStrings.representativesReportMonthly, () {
                    Provider.of<RepresentativesReportData>(context,
                            listen: false)
                        .clear();
                    Navigator.pushNamed(
                        context, Routes.representativeMonthlyReportScreen);
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

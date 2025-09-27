import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/reportsModel/lab_report_data.dart';
import '../../Widgets/list_tile_items.dart';
import '../../Widgets/menu_appbar.dart';
import '../../Widgets/my_drawer.dart';
import '../../resources/routes_manger.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';
import 'overlays_labs.dart';

class LabsScreens extends StatelessWidget {
  const LabsScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: menuAppBar(context, title: AppStrings.labs),
        drawer: const MyDrawer(),
        body: Center(
          child: Card(
            margin: const EdgeInsets.all(AppMargin.m30),
            child: Container(
              padding: const EdgeInsets.all(AppPadding.p8),
              height: AppSize.s250,
              child: ListView(
                children: [
                  listTileItems(context, AppStrings.labs, () {
                    Navigator.pushNamed(context, Routes.labsListScreens);
                  }),
                  listTileItems(context, AppStrings.addNewLab, () {
                    showAddLabItemOverLay(context, AppStrings.addNewLab, "");
                  }),
                  listTileItems(context, AppStrings.labReportDaily, () {
                    Provider.of<LabReportModel>(context, listen: false)
                        .labReportList = [];
                    Navigator.pushNamed(context, Routes.labDayReportScreen);
                  }),
                  listTileItems(context, AppStrings.labReportMonthly, () {
                    Provider.of<LabReportModel>(context, listen: false)
                        .labReportList = [];
                    Navigator.pushNamed(context, Routes.labMonthlyReportScreen);
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

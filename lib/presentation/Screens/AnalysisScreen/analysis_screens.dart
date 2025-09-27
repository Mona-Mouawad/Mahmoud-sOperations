import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/analysis_model.dart';
import '../../Widgets/list_tile_items.dart';
import '../../Widgets/menu_appbar.dart';
import '../../Widgets/my_drawer.dart';
import '../../resources/routes_manger.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';
import 'show_add_analysis_overlay.dart';

class AnalysisScreens extends StatelessWidget {
  const AnalysisScreens({super.key});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: menuAppBar(context, title: AppStrings.analysis),
        drawer: const MyDrawer(),
        body: Center(
          child: Container(
            margin: const EdgeInsets.all(AppMargin.m20),
            padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.p8, vertical: AppPadding.p28),
            // height: AppSize.s80 *2,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p8, vertical: AppPadding.p20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    listTileItems(context, AppStrings.analysis, () {
                      Provider.of<AnalysisModel>(context, listen: false)
                          .getAnalysisName("");
                      Navigator.pushNamed(context, Routes.analysisListScreens);
                    }),
                    listTileItems(context, AppStrings.addNewAnalysis, () {
                      showAddAnalysisOverLay(context, "");
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

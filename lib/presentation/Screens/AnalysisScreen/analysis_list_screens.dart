import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../domain/models/analysis_model.dart';
import '../../resources/color_manager.dart';
import '../../Widgets/my_drawer.dart';
import '../../Widgets/menu_appbar.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';
import 'card_analysis.dart';
import 'show_add_analysis_overlay.dart';

class AnalysisListScreens extends StatelessWidget {

  final TextEditingController _itemNameController = TextEditingController();

  AnalysisListScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          // extendBodyBehindAppBar: true,
          resizeToAvoidBottomInset: true,
          // resizeToAvoidBottomInset: false,
          appBar: menuAppBar(context, title: AppStrings.analysis),
          drawer: MyDrawer(),
          body: Consumer<AnalysisModel>(
            builder: (context, analysis, _) {
              log(
                  "analysis.analysisList  ${analysis.analysisList.length}");
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppPadding.p20,
                        vertical: AppPadding.p20),
                    child: TextFormField(
                      controller: _itemNameController,
                      decoration: const InputDecoration(
                        labelText: AppStrings.analysisName,
                      ),
                      onChanged: (val) {
                        log("_itemNameController  ${_itemNameController.text}");
                        analysis.getAnalysisName(_itemNameController.text);
                        // Provider.of<AnalysisModel>(context,listen: false).getLabsByName(_itemNameController.text);
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: analysis.analysisNameList
                          .map((item) => CardAnalysis(
                              data: item,
                              onEditPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: ShowEditAnalysisOverLay(
                                            item,
                                            _itemNameController.text),
                                      );
                                    });
                              },
                              onDeletePressed: () {
                                analysis.deleteAnalysisById(
                                    item.analysisId!, _itemNameController.text);
                              }))
                          .toList(),
                    ),
                  ),
                ],
              );
            },
          ),
          floatingActionButton: CircleAvatar(
            radius: AppSize.s28,
            backgroundColor: AppColors.primary,
            child: IconButton(
              icon:
                  Icon(Icons.add, color: AppColors.white, size: AppSize.s28),
              onPressed: () {
                showAddAnalysisOverLay(
                    context,_itemNameController.text);
              },
            ),
          ),
        ));
  }
}

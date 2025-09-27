import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/reportsModel/analysis_report_data.dart';
import '../../../domain/models/analysis_model.dart';
import '../../Widgets/menu_appbar.dart';
import '../../Widgets/my_drawer.dart';
import '../../Widgets/show_date_picker.dart';
import '../../resources/color_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';

class AnalysisReportScreen extends StatefulWidget {
  const AnalysisReportScreen({super.key});

  @override
  State<AnalysisReportScreen> createState() => _AnalysisReportScreenState();
}

class _AnalysisReportScreenState extends State<AnalysisReportScreen> {
  String _day = DateTime.now().toString().split(" ")[0];
  _getDay(DateTime dateTime) {
    var date = dateTime.toString().split(" ");
    _day = date[0];
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          // extendBodyBehindAppBar: true,
          resizeToAvoidBottomInset: true,
          // resizeToAvoidBottomInset: false,
          appBar: menuAppBar(context, title: AppStrings.analysis),
          drawer: const MyDrawer(),
          body: Consumer<AnalysisReportData>(
            builder: (context, analysis, _) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: AppPadding.p20, horizontal: AppPadding.p8),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: AppSize.s60,
                          child: Text(AppStrings.today,
                              textDirection: TextDirection.ltr,
                              style: Theme.of(context).textTheme.displayLarge),
                        ),
                        const SizedBox(
                          width: AppSize.s8,
                        ),
                        InkWell(
                          onTap: () async {
                            await showDate(context, (value) => _getDay(value!))
                                .then((value) => setState(() {}));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width - 135,
                            height: 48,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(AppSize.s20),
                                color: AppColors.grey200
                                // color: ColorManager.lightPrimary
                                ),
                            child: Center(
                              child: Text(
                                _day,
                                textAlign: TextAlign.center,
                                textDirection: TextDirection.ltr,
                                style:
                                    Theme.of(context).textTheme.headlineLarge,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: AppSize.s10,
                    ),
                    Expanded(
                      child: ListView(
                        children: analysis.reportAnalysisList
                            .map((item) => cardAnalysis(item))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ));
  }

  Widget cardAnalysis(AnalysisData data) {
    return Container(
      height: AppSize.s60,
      margin: const EdgeInsets.symmetric(
          vertical: AppMargin.m8, horizontal: AppMargin.m14),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s20),
          color: AppColors.white),
      clipBehavior: Clip.hardEdge,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 1),
        elevation: AppSize.s2,
        child: Row(
          children: [
            Container(
                width: AppSize.s6,
                height: double.infinity - 2,
                color: AppColors.primary),
            const SizedBox(
              width: AppSize.s10,
            ),
            SizedBox(
              width: AppSize.s160,
              child: Text(
                data.analysisName!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: AppSize.s50,
              child: Text(
                data.analysisQuantity.toString(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: AppSize.s80,
              child: Text(
                data.analysisPrice.toString(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:new_app_mahmoud/data/reportsModel/lab_report_data.dart';
import 'package:provider/provider.dart';

// import 'package:screenshot/screenshot.dart';
import '../../../domain/models/labs_model.dart';
import '../../Widgets/my_drawer.dart';
import '../../Widgets/show_date_picker.dart';
import '../../resources/color_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';
import 'printer_screen.dart';

class LabMonthlyReportScreen extends StatefulWidget {
  const LabMonthlyReportScreen({super.key});

  @override
  State<LabMonthlyReportScreen> createState() => _LabMonthlyReportScreenState();
}

class _LabMonthlyReportScreenState extends State<LabMonthlyReportScreen> {
  String firstDay = DateTime.now().toString().split(" ")[0];
  String lastDay = DateTime.now().toString().split(" ")[0];
  TextEditingController labNameController = TextEditingController();
  LabData? labData;
  bool labToggle = false;
  final TextEditingController firstDayController = TextEditingController();
  final TextEditingController lastDayController = TextEditingController();
  double sumPrice = 0;
  int sumQuantity = 0;
  _calculateTotalPrice(LabReportModel report) {
    sumPrice = report.labReportList.fold(0,
        (previousValue, element) => previousValue + (element.analysisPrice!));
  }

  _calculateTotalQuantity(LabReportModel report) {
    sumQuantity = report.labReportList.fold(
        0,
        (previousValue, element) =>
            previousValue + (element.analysisQuantity!));
  }
  // final ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstDayController.text = firstDay;
    lastDayController.text = lastDay;
  }

  @override
  Widget build(BuildContext context) {
    // Provider.of<LabReportModel>(context).getAllRepresentativesLabsReport(_day);
    return Directionality(
      textDirection: TextDirection.rtl,
      // child:  Screenshot(
      //   controller: screenshotController,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leadingWidth: AppSize.s80,
          title: const Text(AppStrings.labReportMonthly),
          actions: [
            IconButton(
                onPressed: () {
                  if (labData != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => PrinterScreen(
                            labName: labData!.labName ?? "",
                            day1: firstDay,
                            day2: lastDay,
                            sumQuantity: sumQuantity.toString(),
                            sumPrice: sumPrice.toString()),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.print))
          ],
        ),
        //menuAppBar(context, title: AppStrings.analysis),
        drawer: const MyDrawer(),
        body: Consumer<LabReportModel>(
          builder: (context, report, _) {
            log("analysis.analysisList  ${report.labReportList.length}");
            _calculateTotalPrice(report);
            _calculateTotalQuantity(report);
            return Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: AppPadding.p20, horizontal: AppPadding.p10),
              child: Column(
                children: [
                  labWidget(report),
                  const SizedBox(
                    height: AppSize.s20,
                  ),
                  selectedDays(report),
                  Padding(
                    padding: const EdgeInsets.all(AppPadding.p10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(AppStrings.total),
                        Text("$sumQuantity"),
                        Text("$sumPrice"),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: report.labReportList
                          .map((item) => cardReport(item))
                          .toList(),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      // )
    );
  }

  Widget selectedDays(LabReportModel report) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 2 - AppSize.s30,
          child: Card(
            child: TextFormField(
              controller: firstDayController,
              decoration: const InputDecoration(labelText: AppStrings.from),
              readOnly: true,
              onTap: () {
                setState(() {
                  showDate(context, (value) {
                    var date0 = value.toString().split(" ");
                    firstDay = date0[0];
                    firstDayController.text = firstDay;
                    if (labData != null) {
                      report.getLabsMonthlyReport(
                          firstDay, lastDay, labData!.labId!);
                    }
                  });
                });
              },
            ),
          ),
        ),
        Card(
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 2 - AppSize.s30,
            child: TextFormField(
              controller: lastDayController,
              decoration: const InputDecoration(labelText: AppStrings.to),
              readOnly: true,
              onTap: () async {
                await showDate(context, (value) {
                  var date = value.toString().split(" ");
                  lastDay = date[0];
                  lastDayController.text = lastDay;
                  if (labData != null) {
                    report.getLabsMonthlyReport(
                        firstDay, lastDay, labData!.labId!);
                  }
                }).then((value) => setState(() {}));
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget cardReport(LabsAnalysisData data) {
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

  Widget labWidget(LabReportModel report) {
    return Consumer<LabModel>(builder: (context, item, _) {
      return Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: (labToggle)
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(AppSize.s14),
                      topRight: Radius.circular(AppSize.s14))
                  : BorderRadius.circular(AppSize.s14),
            ),
            child: TextFormField(
                controller: labNameController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppSize.s14),
                        borderSide: BorderSide(
                          color: AppColors.primary,
                          //     width: AppSize.s1_5,
                        )),
                    //  focusColor: AppColors.primary,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: (labToggle)
                            ? const BorderRadius.only(
                                topLeft: Radius.circular(AppSize.s14),
                                topRight: Radius.circular(AppSize.s14))
                            : BorderRadius.circular(AppSize.s14),
                        borderSide: BorderSide(
                          color: AppColors.primary,
                          // width: AppSize.s2,
                        )),
                    prefixIcon: SizedBox(
                      height: AppSize.s40,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: AppPadding.p5,
                            horizontal: AppPadding.p20),
                        child: Icon(
                          Icons.search,
                          size: AppSize.s28,
                          color: AppColors.grey,
                        ),
                        // SvgPicture.asset(ImageAssets.location_tick,
                        //     width: AppSize.s25),
                      ),
                    ),
                    suffix: InkWell(
                      child: Icon(
                        Icons.clear,
                        color: AppColors.grey,
                      ),
                      onTap: () {
                        labNameController.clear();
                        labData = null;
                      },
                    ),
                    labelText: AppStrings.labName),
                onChanged: (v) {
                  item.getLabsByName(labNameController.text);
                },
                onTap: () {
                  Future.delayed(
                    const Duration(milliseconds: 30),
                    () {
                      setState(() {
                        labToggle = true;
                      });
                    },
                  );
                }),
          ),
          if (labToggle)
            Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: AppMargin.m8, vertical: AppMargin.m0),
              decoration: BoxDecoration(
                  color: AppColors.white,
                  border: Border.all(color: AppColors.primary),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(AppSize.s8),
                      bottomRight: Radius.circular(AppSize.s8))),
              height: AppSize.s300,
              child: ListView.builder(
                  //  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      itemINLabsList(item.labsList[index], report),
                  itemCount: item.labsList.length),
            ),
        ],
      );
    });
  }

  Widget itemINLabsList(LabData data, LabReportModel report) {
    return InkWell(
      onTap: () {
        setState(() {
          labNameController.text = data.labName!;
          labToggle = false;
          labData = data;
          report.getLabsMonthlyReport(firstDay, lastDay, data.labId!);
        });
      },
      child: Container(
        height: AppSize.s40,
        margin: const EdgeInsets.symmetric(
            horizontal: AppMargin.m30, vertical: AppMargin.m8),
        child: Card(
          child: Center(
            child: Text(
              data.labName!,
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
        ),
      ),
    );
  }
}

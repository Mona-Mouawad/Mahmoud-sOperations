import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import 'package:screenshot/screenshot.dart';
import '../../../data/reportsModel/representatives_report_data.dart';
import '../../../domain/models/representative_model.dart';
import '../../Widgets/my_drawer.dart';
import '../../Widgets/show_date_picker.dart';
import '../../resources/color_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';
import 'printer_representative_report.dart';

class RepresentativeDayReportScreen extends StatefulWidget {
  const RepresentativeDayReportScreen({super.key});

  @override
  State<RepresentativeDayReportScreen> createState() =>
      _RepresentativeDayReportScreenState();
}

class _RepresentativeDayReportScreenState
    extends State<RepresentativeDayReportScreen> {
  final TextEditingController _day = TextEditingController();
  final TextEditingController representativeNameController =
      TextEditingController();
  RepresentativeData? representativeData;
  bool representativeToggle = false;
  // final ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _day.text = DateTime.now().toString().split(" ")[0];
  }

  @override
  Widget build(BuildContext context) {
    // Provider.of<RepresentativesReportData>(context).getAllRepresentativesLabsReport(_day);
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            leadingWidth: AppSize.s80,
            title: const Text(AppStrings.representativesReportDaily),
            actions: [
              IconButton(
                  onPressed: () {
                    // ScreenShot_Share();
                    if (representativeData != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              PrinterRepresentativeReportScreen(
                            representativeName:
                                representativeData!.representativeName ?? "",
                            day1: _day.text,
                          ),
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.print))
            ],
          ),
          drawer: const MyDrawer(),
          body: SingleChildScrollView(
            // child: Screenshot(
            //   controller: screenshotController,
            child: Consumer<RepresentativesReportData>(
              builder: (context, report, _) {
                log("analysis.analysisList  ${report.representativesLabsReport.length}");
                report.calculateTotal();
                return Container(
                  color: AppColors.white,
                  padding: const EdgeInsets.symmetric(
                      vertical: AppPadding.p20, horizontal: AppPadding.p10),
                  child: Column(
                    children: [
                      Card(
                        child: TextFormField(
                          controller: _day,
                          decoration: InputDecoration(
                            labelText: AppStrings.today,
                            prefixIcon: SizedBox(
                              height: AppSize.s40,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: AppPadding.p5,
                                    horizontal: AppPadding.p20),
                                child: Icon(
                                  Icons.calendar_month,
                                  size: AppSize.s20,
                                  color: AppColors.grey,
                                ),
                                // SvgPicture.asset(ImageAssets.location_tick,
                                //     width: AppSize.s25),
                              ),
                            ),
                          ),
                          readOnly: true,
                          onTap: () async {
                            await showDate(context, (value) {
                              var date = value.toString().split(" ");
                              _day.text = date[0];
                              if (representativeData != null) {
                                report
                                    .getRepresentativesDailyReport(_day.text,
                                        representativeData!.representativeId!)
                                    .then((value) => setState(() {}));
                              }
                            }).then((value) => setState(() {}));
                          },
                        ),
                      ),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      representativeWidget(report),
                      //      const SizedBox(height: AppSize.s10,),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     Container(
                      //       width: AppSize.s60,
                      //       child: Text(AppStrings.charging,
                      //           textDirection: TextDirection.ltr,
                      //           style: Theme.of(context).textTheme.displayLarge),
                      //     ),
                      //     SizedBox(
                      //       width: AppSize.s8,
                      //     ),
                      //     Card(
                      //       child: SizedBox(
                      //         width: MediaQuery.of(context).size.width - 135,
                      //         height: 48,
                      //         child: TextFormField(
                      //           controller: report.chargingController,
                      //           keyboardType: TextInputType.number,
                      //           onChanged: (val) {
                      //             setState(() {
                      //               report.chargingValue =double.parse(val.isEmpty ? "0" : val);
                      //               report.calculateTotal();
                      //               if(representativeData !=null) {
                      //                 report.checkRepresentativesDayCost(
                      //                     _day.text , representativeData!.representativeId!);
                      //               }
                      //             });
                      //           },
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // const SizedBox(height: AppSize.s10,),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     Container(
                      //       width: AppSize.s60,
                      //       child: Text(AppStrings.transmission,
                      //           textDirection: TextDirection.ltr,
                      //           style: Theme.of(context).textTheme.displayLarge),
                      //     ),
                      //     SizedBox(
                      //       width: AppSize.s8,
                      //     ),
                      //     Card(
                      //       child: SizedBox(
                      //         width: MediaQuery.of(context).size.width - 135,
                      //         height: 48,
                      //         child: TextFormField(
                      //           controller: report.transmissionController,
                      //           keyboardType: TextInputType.number,
                      //           onChanged: (val) {
                      //             setState(() {
                      //               report.transmissionValue =double.parse(val.isEmpty ? "0" : val);
                      //               report.calculateTotal();
                      //               if(representativeData !=null) {
                      //                 report.checkRepresentativesDayCost(
                      //                     _day.text , representativeData!.representativeId!);
                      //               }
                      //             });
                      //           },
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2 -
                                AppSize.s30,
                            child: Card(
                              child: TextFormField(
                                controller: report.chargingController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    labelText: AppStrings.charging),
                                onChanged: (val) {
                                  setState(() {
                                    report.chargingValue =
                                        double.parse(val.isEmpty ? "0" : val);
                                    report.calculateTotal();
                                    if (representativeData != null) {
                                      report.checkRepresentativesDayCost(
                                          _day.text,
                                          representativeData!
                                              .representativeId!);
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                          Card(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 2 -
                                  AppSize.s30,
                              child: TextFormField(
                                controller: report.transmissionController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: AppStrings.transmission,
                                  // hintText: report.transmissionController.toString(),
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    report.transValue =
                                        double.parse(val.isEmpty ? "0" : val);
                                    report.calculateTotal();
                                    if (representativeData != null) {
                                      report.checkRepresentativesDayCost(
                                          _day.text,
                                          representativeData!
                                              .representativeId!);
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(AppPadding.p10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(AppStrings.total),
                            Text("${report.sum}"),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: AppSize.s76 *
                            report.representativesLabsReport.length,
                        child: ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: report.representativesLabsReport
                              .map((item) => cardReport(item))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            // ),
          ),
        ));
  }

  Widget cardReport(RepresentativesLabsData data) {
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
                data.labName!,
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

  Widget representativeWidget(RepresentativesReportData report) {
    return Consumer<RepresentativeModel>(builder: (context, item, _) {
      return Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: (representativeToggle)
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(AppSize.s14),
                      topRight: Radius.circular(AppSize.s14))
                  : BorderRadius.circular(AppSize.s14),
            ),
            child: TextFormField(
                controller: representativeNameController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppSize.s14),
                        borderSide: BorderSide(
                          color: AppColors.primary,
                          //     width: AppSize.s1_5,
                        )),
                    //  focusColor: AppColors.primary,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: (representativeToggle)
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
                          size: AppSize.s20,
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
                        representativeNameController.clear();
                        representativeData = null;
                      },
                    ),
                    labelText: AppStrings.representativeName),
                onChanged: (v) {
                  item.getRepresentativeByName(
                      representativeNameController.text);
                },
                onTap: () {
                  Future.delayed(
                    const Duration(milliseconds: 30),
                    () {
                      setState(() {
                        representativeToggle = true;
                      });
                    },
                  );
                }),
          ),
          if (representativeToggle)
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
                  itemBuilder: (context, index) => itemINRepresentativesList(
                      item.representativeList[index], report),
                  itemCount: item.representativeList.length),
            ),
        ],
      );
    });
  }

  Widget itemINRepresentativesList(
      RepresentativeData data, RepresentativesReportData report) {
    return InkWell(
      onTap: () {
        setState(() {
          representativeNameController.text = data.representativeName!;
          representativeToggle = false;
          representativeData = data;
          if (representativeData != null) {
            report
                .getRepresentativesDailyReport(
                    _day.text, representativeData!.representativeId!)
                .then((value) => setState(() {}));
          }
        });
      },
      child: Container(
        height: AppSize.s40,
        margin: const EdgeInsets.symmetric(
            horizontal: AppMargin.m30, vertical: AppMargin.m8),
        child: Card(
          child: Center(
            child: Text(
              data.representativeName!,
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
        ),
      ),
    );
  }

  // ScreenShot_Share() async {
  //   await screenshotController.capture(delay: const Duration(milliseconds: 10))
  //       .then((image) async {
  //     if (image != null) {
  //       final directory = await getApplicationDocumentsDirectory();
  //       final imagePath = await File('${directory.path}/image.png').create();
  //       await imagePath.writeAsBytes(image);
  //
  //       /// Share Plugin
  //       await Share.shareFiles([imagePath.path]);
  //     }
  //   });
  // }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:screenshot/screenshot.dart';
import '../../../data/reportsModel/lab_report_data.dart';
import '../../../domain/models/labs_model.dart';
import '../../Widgets/show_date_picker.dart';
import '../../resources/color_manager.dart';
import '../../Widgets/my_drawer.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';
import 'dart:ui' as ui;
import 'printer_screen.dart';

class LabDayReportScreen extends StatefulWidget {
  const LabDayReportScreen({super.key});

  @override
  State<LabDayReportScreen> createState() => _LabDayReportScreenState();
}

class _LabDayReportScreenState extends State<LabDayReportScreen> {

  final TextEditingController _day =TextEditingController();
  final TextEditingController labNameController = TextEditingController();
  LabData? labData ;
  bool labToggle = false;

  double sumPrice =0 ;


  @override
  void initState() {
    super.initState();
    _day.text =DateTime.now().toString().split(" ")[0];
  }

  _calculateTotal(LabReportModel report) {
    sumPrice =   report.labReportList.fold(0, (previousValue, element) =>
    previousValue + (element.analysisPrice!)
    );
  }
  int sumQuantity =0 ;
  _calculateTotalQuantity(LabReportModel report) {
    sumQuantity =   report.labReportList.fold(0, (previousValue, element) =>
    previousValue + (element.analysisQuantity!)
    );
  }
  // final ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: ui.TextDirection.rtl,
        // child:  Screenshot(
        //   controller: screenshotController,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              leadingWidth: AppSize.s80,
              title:const Text(AppStrings.labReportDaily),
              actions: [
                IconButton(onPressed: () async {
                  if(labData !=null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => PrinterScreen(
                              labName: labData!.labName ?? "",
                                day1: _day.text,
                                sumQuantity: sumQuantity.toString(),
                                sumPrice: sumPrice.toString()),
                          ),
                        );
                      }
                    }, icon: const Icon(Icons.print))
              ],
            ),
            drawer: MyDrawer(),
            body: Padding(
              padding: const EdgeInsets.symmetric( vertical: AppPadding.p20,horizontal: AppPadding.p10 ),
              child: Consumer<LabReportModel>(
                builder: (context, report, _) {
                   _calculateTotal(report);
                  _calculateTotalQuantity(report);
                  return Column(
                    children: [  Card(
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
                              child:  Icon(Icons.calendar_month ,size:AppSize.s20 ,
                                color: AppColors.grey,
                              ) ,
                              // SvgPicture.asset(ImageAssets.location_tick,
                              //     width: AppSize.s25),
                            ),
                          ),
                        ),
                        readOnly: true,
                        onTap: () async {
                         await showDate(context , (value) {
                              var date = value.toString().split(" ");
                              _day.text = date[0];
                              if(labData !=null ) {
                                report.getLabsDailyReport(
                                    _day.text, labData!.labId!);
                              }
                            }).then((value) => setState((){  }));
                        },
                      ),
                    ),
                      const SizedBox(height: AppSize.s10,),
                      labWidget(report),
                      const  SizedBox(height: AppSize.s10,),
                      Padding(
                        padding: const EdgeInsets.all(AppPadding.p10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const  Text(AppStrings.total),
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
                  );
                },
              ),
            ),
          ),
        // )
    );
  }


  Widget cardReport( LabsAnalysisData data )  {
    return Container(
      height: AppSize.s60,
      margin: const EdgeInsets.symmetric(
          vertical: AppMargin.m8,
          horizontal: AppMargin.m14),
      decoration: BoxDecoration(
          borderRadius:
          BorderRadius.circular(AppSize.s20),
          color: AppColors.white),
      clipBehavior: Clip.hardEdge,
      child: Card(
        margin:const EdgeInsets.symmetric(vertical: 1),
        elevation: AppSize.s2,
        child: Row(
          children: [
            Container(
                width: AppSize.s6,
                height: double.infinity -2,
                color: AppColors.primary),
            const  SizedBox(
              width: AppSize.s10,
            ),
            SizedBox(width: AppSize.s160,
              child: Text(
                data.analysisName!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 2,overflow:TextOverflow.ellipsis ,
              ),
            ),
            const Spacer(),
            SizedBox(width: AppSize.s50,
              child: Text(
                data.analysisQuantity.toString(), textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const Spacer(),
            SizedBox(width: AppSize.s80,
              child: Text(
                data.analysisPrice.toString(), textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const  Spacer(),
          ],
        ),
      ),
    ) ;
  }

  Widget labWidget(LabReportModel report) {
    return   Consumer<LabModel>(
        builder: (context ,item  ,_) {
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
                            child:  Icon(Icons.search ,size:AppSize.s28 ,
                              color: AppColors.grey,
                            ) ,
                            // SvgPicture.asset(ImageAssets.location_tick,
                            //     width: AppSize.s25),
                          ),
                        ),
                        suffix: InkWell(child: Icon(Icons.clear,color: AppColors.grey,),
                          onTap: (){
                            labNameController.clear();
                            labData = null ;
                          },),
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
                  margin: const EdgeInsets.symmetric(horizontal: AppMargin.m8,vertical: AppMargin.m0),
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
                      itemBuilder: (context, index) => itemINLabsList(item.labsList[index],report),
                      itemCount: item.labsList.length),
                ),
            ],
          );
        }
    );
  }


  Widget itemINLabsList(LabData data ,LabReportModel report ) {
    return InkWell(
      onTap: () {
        setState(() {
          labNameController.text = data.labName!;
          labToggle = false;
          labData =data ;
          report.getLabsDailyReport(
              _day.text, data.labId!);
        });
      },
      child: Container(
        height: AppSize.s40,
        margin: const EdgeInsets.symmetric(
            horizontal: AppMargin.m30,
            vertical: AppMargin.m8),
        child: Card(
          child: Center(
            child: Text(data.labName!,
              style: Theme.of(context)
                  .textTheme
                  .displayLarge,
            ),
          ),
        ),
      ),
    );
  }


}

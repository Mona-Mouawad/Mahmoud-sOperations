import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:screenshot/screenshot.dart';
import '../../../data/reportsModel/representatives_report_data.dart';
import '../../../domain/models/representative_model.dart';
import '../../Widgets/show_date_picker.dart';
import '../../resources/color_manager.dart';
import '../../Widgets/my_drawer.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';
import 'printer_representative_report.dart';

class RepresentativeMonthlyReportScreen extends StatefulWidget {
  const RepresentativeMonthlyReportScreen({super.key});

  @override
  State<RepresentativeMonthlyReportScreen> createState() => _RepresentativeMonthlyReportScreenState();
}

class _RepresentativeMonthlyReportScreenState extends State<RepresentativeMonthlyReportScreen> {

  String firstDay =DateTime.now().toString().split(" ")[0];
  String lastDay =DateTime.now().toString().split(" ")[0];
  TextEditingController representativeNameController = TextEditingController();
  RepresentativeData? representativeData ;
  TextEditingController firstDayController = TextEditingController();
  TextEditingController lastDayController = TextEditingController();
  bool representativeToggle = false;

  // final ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstDayController.text = firstDay ;
    lastDayController.text = lastDay ;
  }

  @override
  Widget build(BuildContext context) {
    // Provider.of<RepresentativesReportData>(context).getAllRepresentativesLabsReport(_day);
    return Directionality(
        textDirection: TextDirection.rtl,
        child:  Scaffold(
           appBar: AppBar(
            leadingWidth: AppSize.s80,
            title: const Text(AppStrings.representativesReportMonthly),
            actions: [
              IconButton(onPressed: (){
                // ScreenShot_Share();
                if(representativeData !=null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => PrinterRepresentativeReportScreen(
                        representativeName: representativeData!.representativeName ?? "",
                        day1: firstDay, day2: lastDay, ),
                    ),
                  );
                }
              }, icon: const Icon(Icons.print))
            ],
          ),
          //menuAppBar(context, title: AppStrings.analysis),
          drawer: MyDrawer(),
          body:  SingleChildScrollView(
            // child: Screenshot(
            // controller: screenshotController,
              child: Consumer<RepresentativesReportData>(
                builder: (context, report, _) {
                  report.calculateTotal();
                  return Container(
                    color: AppColors.white,
                    padding: const EdgeInsets.symmetric( vertical: AppPadding.p20,horizontal: AppPadding.p10 ),
                    child: Column(
                      children: [
                        representativeWidget(report),
                        const  SizedBox(height: AppSize.s10,),
                        selectedDays(report),
                        const  SizedBox(height: AppSize.s10,),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                          SizedBox(width:  MediaQuery.of(context).size.width /2 -AppSize.s30,
                            child: Card(
                              child: TextFormField(
                                controller: report.chargingController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    labelText: AppStrings.charging
                                ),
                                onChanged: (val){
                                  if(val.isNotEmpty ){
                                    report.chargingValue =double.parse(val) ;
                                    report.calculateTotal();
                                  }
                                },
                              ),
                            ),
                          ),
                          Card(
                            child: SizedBox(width:  MediaQuery.of(context).size.width /2 -AppSize.s30,
                              child: TextFormField(
                                controller: report.transmissionController,
                                keyboardType: TextInputType.number,
                                // readOnly: true,
                                decoration:const InputDecoration(
                                    labelText: AppStrings.transmission
                                ),onChanged: (val){
                                if(val.isNotEmpty ){
                                  report.transValue =double.parse(val) ;
                                  report.calculateTotal();
                                }
                              },
                              ),
                            ),
                          ),
                        ],),
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
                          height: AppSize.s76 * report.representativesLabsReport.length,
                          child: ListView(
                            physics:const NeverScrollableScrollPhysics(),
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
            ),
          // ),
        ));
  }


  Widget selectedDays(RepresentativesReportData report){
    return   Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(width:  MediaQuery.of(context).size.width /2 -AppSize.s30,
          child: Card(
            child: TextFormField(
              controller: firstDayController,
              decoration:const InputDecoration(
                  labelText: AppStrings.from
              ),
              readOnly: true,
              onTap: () {
                setState(() {
                  showDate(context , (value) {
                    var date0 = value.toString().split(" ");
                    firstDay = date0[0];
                    firstDayController.text = firstDay ;
                    if(representativeData !=null ) {
                      report.getRepresentativesMonthlyReport(
                          firstDay,lastDay, representativeData!.representativeId!);
                    }
                  });
                });
              },
            ),
          ),
        ),
        Card(
          child: SizedBox(width:  MediaQuery.of(context).size.width /2 -AppSize.s30,
            child: TextFormField(
              controller: lastDayController,
              decoration:const InputDecoration(
                  labelText: AppStrings.to
              ),
              readOnly: true,
              onTap: () {
                setState(() {
                  showDate(context , (value) {
                    var date = value.toString().split(" ");
                    lastDay = date[0];
                    lastDayController.text = lastDay ;
                    if(representativeData !=null ) {
                      report.getRepresentativesMonthlyReport(
                          firstDay, lastDay, representativeData!.representativeId!);
                    }
                  });
                });
              },
            ),
          ),
        ),
      ],);
  }

  Widget cardReport( RepresentativesLabsData data )  {
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
            const SizedBox(
              width: AppSize.s10,
            ),
            SizedBox(width: AppSize.s160,
              child: Text(
                data.labName!,
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
            const Spacer(),
          ],
        ),
      ),
    ) ;
  }

  Widget representativeWidget(RepresentativesReportData report) {
    return Consumer<RepresentativeModel>(
        builder: (context ,item  ,_) {
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
                            child:  Icon(Icons.search ,size:AppSize.s28 ,
                              color: AppColors.grey,
                            ) ,
                            // SvgPicture.asset(ImageAssets.location_tick,
                            //     width: AppSize.s25),
                          ),
                        ),
                        suffix: InkWell(child: Icon(Icons.clear,color: AppColors.grey,),
                          onTap: (){
                            representativeNameController.clear();
                            representativeData = null ;
                          },),
                        labelText: AppStrings.representativeName),
                    onChanged: (v) {
                      item.getRepresentativeByName(representativeNameController.text);
                    },
                    onTap: () {
                      Future.delayed(
                        const  Duration(milliseconds: 30),
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
                      itemBuilder: (context, index) => itemINRepresentativesList(item.representativeList[index],report),
                      itemCount: item.representativeList.length),
                ),
            ],
          );
        }
    );
  }


  Widget itemINRepresentativesList(RepresentativeData data ,RepresentativesReportData report) {
    return InkWell(
      onTap: () {
        setState(() {
          representativeNameController.text = data.representativeName!;
          representativeToggle = false;
          representativeData = data ;
          if(representativeData !=null ) {
            report.getRepresentativesMonthlyReport(
                firstDay,lastDay, representativeData!.representativeId!);
          }
        });
      },
      child: Container(
        height: AppSize.s40,
        margin: const EdgeInsets.symmetric(
            horizontal: AppMargin.m30,
            vertical: AppMargin.m8),
        child: Card(
          child: Center(
            child: Text(data.representativeName!,
              style: Theme.of(context)
                  .textTheme
                  .displayLarge,
            ),
          ),
        ),
      ),
    );
  }
  //
  // ScreenShot_Share() async {
  //   await _ScreenshotController.capture(delay: const Duration(milliseconds: 10))
  //       .then((image) async {
  //     if (image != null) {
  //       final directory = await getApplicationDocumentsDirectory();
  //       final imagePath = await File('${directory.path}/image.png').create();
  //       await imagePath.writeAsBytes(image);
  //       /// Share Plugin
  //       await Share.shareFiles([imagePath.path]);
  //     }
  //   });
  // }
}

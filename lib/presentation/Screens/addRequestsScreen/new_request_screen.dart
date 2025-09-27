import 'package:flutter/material.dart';
import 'package:new_app_mahmoud/data/request.dart';
import 'package:new_app_mahmoud/presentation/Widgets/my_drawer.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/analysis_model.dart';
import '../../../domain/models/labs_model.dart';
import '../../../domain/models/representative_model.dart';
import '../../Widgets/menu_appbar.dart';
import '../../Widgets/my_button.dart';
import '../../Widgets/show_date_picker.dart';
import '../../resources/color_manager.dart';
import '../../resources/constants_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';

class NewRequest extends StatefulWidget {
  final bool delete;

  const NewRequest({super.key, this.delete = false});

  @override
  State<NewRequest> createState() => _NewRequestState();
}

class _NewRequestState extends State<NewRequest> {
  TextEditingController representativeNameController = TextEditingController();
  TextEditingController labNameController = TextEditingController();
  TextEditingController analysisNameController = TextEditingController();
  bool labToggle = false;
  bool representativeToggle = false;
  bool analysisToggle = false;
  RepresentativeData? representativeData;

  LabData? labData;

  String _day = DateTime.now().toString().split(" ")[0];

  _getDay(DateTime dateTime) {
    var date = dateTime.toString().split(" ");
    _day = date[0];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AnalysisModel>(context, listen: false).getAnalysisList("");
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: menuAppBar(context,
            title: widget.delete
                ? AppStrings.deleteRequest
                : AppStrings.addRegister),
        drawer: const MyDrawer(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p20),
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
                            borderRadius: BorderRadius.circular(AppSize.s20),
                            color: AppColors.grey200
                            // color: ColorManager.lightPrimary
                            ),
                        child: Center(
                          child: Text(
                            _day,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.ltr,
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                Consumer<RepresentativeModel>(builder: (context, item, _) {
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
                                    borderRadius:
                                        BorderRadius.circular(AppSize.s14),
                                    borderSide: BorderSide(
                                      color: AppColors.primary,
                                      //     width: AppSize.s1_5,
                                    )),
                                //  focusColor: AppColors.primary,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: (representativeToggle)
                                        ? const BorderRadius.only(
                                            topLeft:
                                                Radius.circular(AppSize.s14),
                                            topRight:
                                                Radius.circular(AppSize.s14))
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
                                    labToggle = false;
                                    analysisToggle = false;
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
                              itemBuilder: (context, index) =>
                                  itemINRepresentativesList(
                                      item.representativeList[index]),
                              itemCount: item.representativeList.length),
                        ),
                    ],
                  );
                }),
                const SizedBox(
                  height: AppSize.s20,
                ),
                Consumer<LabModel>(builder: (context, item, _) {
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
                                    borderRadius:
                                        BorderRadius.circular(AppSize.s14),
                                    borderSide: BorderSide(
                                      color: AppColors.primary,
                                      //     width: AppSize.s1_5,
                                    )),
                                //  focusColor: AppColors.primary,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: (labToggle)
                                        ? const BorderRadius.only(
                                            topLeft:
                                                Radius.circular(AppSize.s14),
                                            topRight:
                                                Radius.circular(AppSize.s14))
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
                                    representativeToggle = false;
                                    analysisToggle = false;
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
                                  itemINLabsList(item.labsList[index]),
                              itemCount: item.labsList.length),
                        ),
                    ],
                  );
                }),
                const SizedBox(
                  height: AppSize.s20,
                ),
                Consumer<AnalysisModel>(builder: (context, item, _) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: (analysisToggle)
                                    ? const BorderRadius.only(
                                        topLeft: Radius.circular(AppSize.s14),
                                        topRight: Radius.circular(AppSize.s14))
                                    : BorderRadius.circular(AppSize.s14),
                              ),
                              child: TextFormField(
                                controller: analysisNameController,
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(AppSize.s14),
                                        borderSide: BorderSide(
                                          color: AppColors.primary,
                                          //     width: AppSize.s1_5,
                                        )),
                                    //  focusColor: AppColors.primary,
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: (analysisToggle)
                                            ? const BorderRadius.only(
                                                topLeft: Radius.circular(
                                                    AppSize.s14),
                                                topRight: Radius.circular(
                                                    AppSize.s14))
                                            : BorderRadius.circular(
                                                AppSize.s14),
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
                                        analysisNameController.clear();
                                        // _analysisData = null ;
                                      },
                                    ),
                                    labelText: AppStrings.analysisName),
                                onChanged: (v) {
                                  item.getAnalysisName(
                                      analysisNameController.text);
                                  setState(() {
                                    analysisToggle = true;
                                    representativeToggle = false;
                                    labToggle = false;
                                  });
                                },
                                onTap: () {
                                  setState(() {
                                    analysisToggle = true;
                                    representativeToggle = false;
                                    labToggle = false;
                                  });
                                },
                              ),
                            ),
                          ),
                          if (analysisToggle)
                            SizedBox(
                              width: AppSize.s30,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    analysisToggle = false;
                                  });
                                },
                                child: Icon(
                                  Icons.check_circle,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                        ],
                      ),
                      if (analysisToggle)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: AppMargin.m8,
                                    vertical: AppMargin.m0),
                                decoration: BoxDecoration(
                                    color: AppColors.white,
                                    border:
                                        Border.all(color: AppColors.primary),
                                    borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(AppSize.s8),
                                        bottomRight:
                                            Radius.circular(AppSize.s8))),
                                height: AppSize.s300,
                                child: ListView.builder(
                                    //  shrinkWrap: true,
                                    physics: const ClampingScrollPhysics(),
                                    itemBuilder: (context, index) =>
                                        itemINAnalysisList(
                                            item.analysisNameList[index]),
                                    itemCount: item.analysisNameList.length),
                              ),
                            ),
                            const SizedBox(
                              width: AppSize.s30,
                            ),
                          ],
                        ),
                    ],
                  );
                }),
                const SizedBox(
                  height: AppSize.s20,
                ),
                SizedBox(
                  height: AppSize.s100 * _analysisSelectedList.length,
                  width: double.infinity,
                  child: ListView.builder(
                      // shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => _selectedAnalysisList(
                          _analysisSelectedList[index], index),
                      itemCount: _analysisSelectedList.length),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(AppStrings.total),
                    Text("$sum"),
                  ],
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                myAppButton(context, AppStrings.done, () {
                  if (representativeData == null) {
                    AppConstants.myToast(
                        context: context,
                        text: AppStrings.representativeError,
                        state: ToastStates.error);
                  } else if (labData == null) {
                    AppConstants.myToast(
                        context: context,
                        text: AppStrings.labError,
                        state: ToastStates.error);
                  } else if (_analysisSelectedList.isEmpty) {
                    AppConstants.myToast(
                        context: context,
                        text: AppStrings.analysisError,
                        state: ToastStates.error);
                  } else {
                    widget.delete
                        ? InsertTotDB.removeRequest(context,
                                date: _day,
                                representativesId:
                                    representativeData!.representativeId!,
                                labsId: labData!.labId!,
                                analysisSelectedList: _analysisSelectedList)
                            .then((value) {
                            setState(() {
                              representativeData = null;
                              labData = null;
                              representativeNameController.clear();
                              labNameController.clear();
                              analysisNameController.clear();
                              _analysisSelectedList = [];
                              representativeToggle = false;
                              labToggle = false;
                              sum = 0;
                              analysisToggle = false;
                            });
                          })
                        : InsertTotDB.addRequest(context,
                                date: _day,
                                representativesId:
                                    representativeData!.representativeId!,
                                labsId: labData!.labId!,
                                analysisSelectedList: _analysisSelectedList)
                            .then((value) {
                            setState(() {
                              representativeData = null;
                              labData = null;
                              representativeNameController.clear();
                              labNameController.clear();
                              analysisNameController.clear();
                              _analysisSelectedList = [];
                              representativeToggle = false;
                              labToggle = false;
                              sum = 0;
                              analysisToggle = false;
                            });
                          });
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget itemINRepresentativesList(RepresentativeData data) {
    return InkWell(
      onTap: () {
        setState(() {
          representativeNameController.text = data.representativeName!;
          representativeToggle = false;
          representativeData = data;
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

  Widget itemINLabsList(LabData data) {
    return InkWell(
      onTap: () {
        setState(() {
          labNameController.text = data.labName!;
          labToggle = false;
          labData = data;
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

  List<AnalysisData> _analysisSelectedList = [];

  Widget itemINAnalysisList(AnalysisData data) {
    return InkWell(
      onTap: () {
        setState(() {
          if (_analysisSelectedList
              .any((element) => element.analysisId == data.analysisId)) {
            int index = _analysisSelectedList
                .indexWhere((element) => element.analysisId == data.analysisId);
            AnalysisData element = _analysisSelectedList.elementAt(index);
            _analysisSelectedList.add(AnalysisData(
                element.analysisId,
                element.analysisName,
                element.analysisPrice,
                element.analysisQuantity + 1));
            _analysisSelectedList.removeAt(index);
          } else {
            _analysisSelectedList.add(AnalysisData(
                data.analysisId, data.analysisName, data.analysisPrice, 1));
          }
          _calculateTotal();
        });
      },
      child: Container(
        height: AppSize.s40,
        margin: const EdgeInsets.symmetric(
            horizontal: AppMargin.m30, vertical: AppMargin.m8),
        child: Row(
          children: [
            Expanded(
              child: Card(
                child: Center(
                  child: Text(
                    data.analysisName!,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
              ),
            ),
            if (_analysisSelectedList
                .any((element) => element.analysisId == data.analysisId))
              SizedBox(
                  width: AppSize.s30,
                  child: Text(
                      "${_analysisSelectedList.firstWhere((element) => element.analysisId == data.analysisId).analysisQuantity}")),
          ],
        ),
      ),
    );
  }

  Widget _selectedAnalysisList(AnalysisData data, int index) {
    final TextEditingController analysisQuantityController =
        TextEditingController();
    String analysisPriceController = data.analysisPrice.toString();
    analysisQuantityController.text = data.analysisQuantity.toString();
    return Container(
      height: AppSize.s80,
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
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                width: AppSize.s6,
                // height: double.infinity -2,
                color: AppColors.primary),
            const SizedBox(
              width: AppSize.s8,
            ),
            Expanded(
              //width: AppSize.s100,
              child: Text(
                data.analysisName!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              width: AppSize.s12,
            ),
            //flex: 2
            SizedBox(
              width: 56,
              child: TextFormField(
                style: Theme.of(context).textTheme.titleMedium,
                initialValue: analysisPriceController,
                keyboardType: TextInputType.number,
                onChanged: (val) {
                  // setState(() {
                  analysisPriceController = val;
                  _analysisSelectedList.insert(
                      index,
                      AnalysisData(
                          data.analysisId,
                          data.analysisName,
                          double.parse(analysisPriceController),
                          int.parse(analysisQuantityController.text)));
                  _analysisSelectedList.removeAt(index + 1);
                  // });
                  setState(() {
                    _calculateTotal();
                  });
                },
              ),
            ),
            const SizedBox(
              width: AppSize.s12,
            ),
            SizedBox(
              width: AppSize.s40,
              child: TextFormField(
                style: Theme.of(context).textTheme.titleMedium,
                controller: analysisQuantityController,
                keyboardType: TextInputType.number,
                onChanged: (val) {
                  analysisQuantityController.text = val;
                  _analysisSelectedList.insert(
                      index,
                      AnalysisData(
                          data.analysisId,
                          data.analysisName,
                          double.parse(analysisPriceController),
                          int.parse(analysisQuantityController.text)));
                  _analysisSelectedList.removeAt(index + 1);

                  setState(() {
                    _calculateTotal();
                  });
                },
              ),
            ),
            const SizedBox(
              width: AppSize.s12,
            ),
            SizedBox(
              //width: AppSize.s100,
              child: Text(
                "${data.analysisQuantity * data.analysisPrice!}",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              width: AppSize.s12,
            ),
            SizedBox(
              width: AppSize.s30,
              child: IconButton(
                onPressed: () {
                  _analysisSelectedList.removeWhere(
                      (element) => element.analysisId == data.analysisId);
                  setState(() {
                    _calculateTotal();
                  });
                },
                icon: Icon(
                  Icons.delete,
                  color: AppColors.error,
                ),
                splashColor: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  double sum = 0;

  _calculateTotal() {
    sum = _analysisSelectedList.fold(
        0,
        (previousValue, element) =>
            previousValue +
            (element.analysisQuantity * element.analysisPrice!));
  }
}

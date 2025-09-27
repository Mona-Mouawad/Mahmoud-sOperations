// LabsListScreens

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/labs_model.dart';
import '../../Widgets/menu_appbar.dart';
import '../../Widgets/my_drawer.dart';
import '../../resources/color_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';
import 'overlays_labs.dart';

// class LabsListScreens extends StatelessWidget {
//   const LabsListScreens({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

class LabsListScreens extends StatefulWidget {
  const LabsListScreens({super.key});

  @override
  State<LabsListScreens> createState() => _LabsListScreensState();
}

class _LabsListScreensState extends State<LabsListScreens> {
  final TextEditingController _labNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: menuAppBar(context, title: AppStrings.labs),
          drawer: const MyDrawer(),
          body: Consumer<LabModel>(
            builder: (context, labs, _) {
              log("labs.labsList  ${labs.labsList.length}");
              // labs.getLabsByName(_labNameController.text);
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppPadding.p20, vertical: AppPadding.p20),
                    child: TextFormField(
                      controller: _labNameController,
                      decoration: const InputDecoration(
                        labelText: AppStrings.labName,
                      ),
                      onChanged: (val) {
                        log("_labNameController  ${_labNameController.text}");
                        labs.getLabsByName(_labNameController.text);
                        // Provider.of<LabModel>(context,listen: false).getLabsByName(_labNameController.text);
                      },
                      onTap: () {},
                      // onEditingComplete: (){},
                      onSaved: (val) {
                        log("_labNameController  ${_labNameController.text}");
                      },
                      onFieldSubmitted: (val) {
                        log(" onFieldSubmitted  _labNameController  ${_labNameController.text}");
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: labs.labsList
                          .map((item) => cardItem(context, title: item.labName!,
                                  onEditPressed: () {
                                showEditItemOverLay(
                                    context,
                                    AppStrings.editRepresentativeName,
                                    item,
                                    _labNameController.text);
                              }, onDeletePressed: () {
                                labs.deleteLabById(
                                    item.labId!, _labNameController.text);
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
              icon: Icon(Icons.add, color: AppColors.white, size: AppSize.s28),
              onPressed: () {
                showAddLabItemOverLay(
                    context, AppStrings.addNewLab, _labNameController.text);
              },
            ),
          ),
        ));
  }
}

Widget cardItem(
  context, {
  required String title,
  required VoidCallback onEditPressed,
  required VoidCallback onDeletePressed,
}) {
  return Container(
    height: AppSize.s60,
    margin: const EdgeInsets.symmetric(
        vertical: AppMargin.m8, horizontal: AppMargin.m20),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s20),
        color: AppColors.white),
    clipBehavior: Clip.hardEdge,
    child: Row(
      children: [
        Container(
            width: AppSize.s6,
            height: double.infinity,
            color: AppColors.primary),
        const SizedBox(
          width: AppSize.s10,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const Spacer(flex: 5),
        IconButton(
          onPressed: onEditPressed,
          icon: Icon(
            Icons.edit,
            color: AppColors.primary,
          ),
          splashColor: AppColors.white,
        ),
        const Spacer(),
        IconButton(
          onPressed: onDeletePressed,
          icon: Icon(
            Icons.delete,
            color: AppColors.error,
          ),
          splashColor: AppColors.white,
        ),
      ],
    ),
  );
}

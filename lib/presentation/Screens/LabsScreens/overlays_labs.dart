import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../domain/models/labs_model.dart';
import '../../Widgets/my_button.dart';
import '../../resources/color_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';

showEditItemOverLay(context ,String title , LabData item , String searchName , ){
  TextEditingController controller =TextEditingController() ;
  controller.text = item.labName! ;
  return showDialog(context: context, builder: (context){
    return AlertDialog(
      content: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,style: Theme.of(context).textTheme.displayMedium,),
            Container(width: AppSize.s60,height: AppSize.s4,color: AppColors.primary,),
            const  SizedBox(height: AppSize.s30,),
            TextFormField(
              controller: controller,
            ),
            const SizedBox(height: AppSize.s30,),
            myAppButton(context, AppStrings.save, () {
               Provider.of<LabModel>(context,listen: false).editLabByID(item.labId!,  controller.text , searchName ).then((value) =>    Navigator.pop(context));
           
            })
          ],
        ),
      ),
    );
  });
}

showAddLabItemOverLay(context ,String title ,String searchName  ){
  TextEditingController controller =TextEditingController() ;
  return showDialog(context: context, builder: (context){
    return AlertDialog(
      content: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,style: Theme.of(context).textTheme.displayMedium,),
            Container(width: AppSize.s60,height: AppSize.s4,color: AppColors.primary,),
           const SizedBox(height: AppSize.s20,),
            TextFormField(
              controller: controller,
            ),
            const SizedBox(height: AppSize.s20,),
            myAppButton(context, AppStrings.save, () {
             Provider.of<LabModel>(context,listen: false).insertNewLabs(controller.text , searchName);
              Navigator.pop(context);
            })
          ],
        ),
      ),
    );
  });
}
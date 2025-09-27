import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/representatives.dart';
import '../../../domain/models/representative_model.dart';
import '../../Widgets/my_button.dart';
import '../../resources/color_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';

showEditItemOverLay(context ,String title , RepresentativeData item ){
  TextEditingController controller =TextEditingController() ;
  controller.text = item.representativeName! ;
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

              Representatives.editRepresentative(item.representativeId! , controller.text).then((value) =>
                  Provider.of<RepresentativeModel>(context,listen: false).getRepresentatives() );
              Navigator.pop(context);
            })
          ],
        ),
      ),
    );
  });
}

showAddItemOverLay(context ,String title , ){
 final TextEditingController controller =TextEditingController() ;
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
              Representatives.addRepresentative(controller.text).then((value) =>
                  Provider.of<RepresentativeModel>(context).getRepresentatives() );
              Navigator.pop(context);
            })
          ],
        ),
      ),
    );
  });
}
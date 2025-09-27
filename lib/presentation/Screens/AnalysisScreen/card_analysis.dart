 import 'package:flutter/material.dart';
import '../../../domain/models/analysis_model.dart';
import '../../resources/color_manager.dart';
import '../../resources/values_manager.dart';

class CardAnalysis extends StatelessWidget {
  final AnalysisData data ;
  final VoidCallback onEditPressed;
  final VoidCallback onDeletePressed ;

  const CardAnalysis({super.key, required this.data, required this.onDeletePressed ,required this.onEditPressed});

   @override
   Widget build(BuildContext context) {
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
         margin: const EdgeInsets.symmetric(vertical: 1),
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
                 data.analysisName!,
                 style: Theme.of(context).textTheme.bodySmall,
                 maxLines: 2,overflow:TextOverflow.ellipsis ,
               ),
             ),
             const SizedBox(
               width: AppSize.s20,
             ),
             Text(
               data.analysisPrice.toString(),
               style: Theme.of(context).textTheme.titleMedium,
             ),
             const Spacer( flex: 5),
             IconButton(onPressed: onEditPressed , icon: Icon(Icons.edit,color: AppColors.primary,),
               splashColor: AppColors.white,
             ),
             const Spacer(),
             IconButton(onPressed: onDeletePressed , icon: Icon(Icons.delete ,color: AppColors.error,),
               splashColor: AppColors.white,),
           ],
         ),
       ),
     ) ;
   }
 }

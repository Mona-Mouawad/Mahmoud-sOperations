import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../domain/models/analysis_model.dart';
import '../../Widgets/my_button.dart';
import '../../resources/color_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';

class ShowEditAnalysisOverLay extends StatefulWidget {
 final AnalysisData item;
 final String searchName ;

const  ShowEditAnalysisOverLay(this.item,this.searchName, {super.key}) ;

  @override
  State<ShowEditAnalysisOverLay> createState() => _ShowEditAnalysisOverLayState();
}

class _ShowEditAnalysisOverLayState extends State<ShowEditAnalysisOverLay> {
 final TextEditingController _nameController =TextEditingController() ;

 final TextEditingController _priceController =TextEditingController() ;

 @override
  void dispose() {
   _nameController.dispose();
   _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _nameController.text = widget.item.analysisName! ;
    _priceController.text = widget.item.analysisPrice.toString() ;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text( AppStrings.editAnalysis,style: Theme.of(context).textTheme.displayMedium,),
          Container(width: AppSize.s60,height: AppSize.s4,color: AppColors.primary,),
          const SizedBox(height: AppSize.s30,),
          TextFormField(
            controller: _nameController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
                labelText: AppStrings.analysisName
            ),
          ),
          const SizedBox(height: AppSize.s20,),
          TextFormField(
            controller: _priceController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
                labelText: AppStrings.price
            ),
          ),
          const SizedBox(height: AppSize.s30,),
          myAppButton(context, AppStrings.save, () {
            Provider.of<AnalysisModel>(context,listen: false).editAnalysisByID(widget.item.analysisId!, _nameController.text  ,
                double.parse(_priceController.text), widget.searchName );
            Navigator.pop(context);
          })
        ],
      ),
    );
  }
}



showAddAnalysisOverLay(context ,String searchName  ){
 final TextEditingController nameController =TextEditingController() ;
 final TextEditingController priceController =TextEditingController() ;
  return showDialog(context: context, builder: (context){
    return AlertDialog(
      content: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppStrings.addNewAnalysis,style: Theme.of(context).textTheme.displayMedium,),
            Container(width: AppSize.s60,height: AppSize.s4,color: AppColors.primary,),
            const SizedBox(height: AppSize.s20,),
            TextFormField(
              controller: nameController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  labelText: AppStrings.analysisName
              ),
            ),
            const SizedBox(height: AppSize.s20,),
            TextFormField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: AppStrings.price
              ),
            ),
            const SizedBox(height: AppSize.s20,),
            myAppButton(context, AppStrings.save, () {
             Provider.of<AnalysisModel>(context,listen: false).insertNewAnalysis(nameController.text ,
                 double.parse(priceController.text), searchName
             );
              Navigator.pop(context);
            })
          ],
        ),
      ),
    );
  });
}
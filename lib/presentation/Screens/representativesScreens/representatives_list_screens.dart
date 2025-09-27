import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/representatives.dart';
import '../../../domain/models/representative_model.dart';
import '../../resources/color_manager.dart';
import '../../Widgets/my_drawer.dart';
import '../../Widgets/menu_appbar.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';
import 'overlays.dart';

class RepresentativesListScreens extends StatelessWidget {
  const RepresentativesListScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: menuAppBar(context, title: AppStrings.representatives),
          drawer: MyDrawer(),
          body: Consumer<RepresentativeModel>(
            builder: (context, representative, _) {
              //  representative.getRepresentatives();
              return ListView(
                children: representative.representativeList
                    .map((item) =>cardItem(context,
                    title:  item.representativeName!, onEditPressed: (){
                      showEditItemOverLay(context, AppStrings.editRepresentativeName,item) ;
                    }, onDeletePressed: (){
                      Representatives.deleteRepresentativesById(item.representativeId!).then((value) => representative.getRepresentatives());
                    }) )
                    .toList(),
              );
            },
          ),
          floatingActionButton: CircleAvatar(
            radius: AppSize.s28,
            backgroundColor: AppColors.primary,
            child: IconButton(
              icon: Icon(Icons.add ,color: AppColors.white,size: AppSize.s28),
              onPressed: (){
                showAddItemOverLay(context, AppStrings.addRepresentatives);
              },
            ),
          ),
        ));
  }



}


Widget cardItem( context ,{required String title ,required VoidCallback onEditPressed,required VoidCallback onDeletePressed ,})
{
  return Container(
    height: AppSize.s60,
    margin: const EdgeInsets.symmetric(
        vertical: AppMargin.m8,
        horizontal: AppMargin.m20),
    decoration: BoxDecoration(
        borderRadius:
        BorderRadius.circular(AppSize.s20),
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
        const Spacer( flex: 5),
        IconButton(onPressed: onEditPressed , icon: Icon(Icons.edit,color: AppColors.primary,),
          splashColor: AppColors.white,
        ),
        const Spacer(),
        IconButton(onPressed: onDeletePressed , icon: Icon(Icons.delete ,color: AppColors.error,),
          splashColor: AppColors.white,),
      ],
    ),
  ) ;
}


import 'package:flutter/material.dart';
import '../../domain/models/analysis_model.dart';
import '../../domain/models/representative_model.dart';
import '../../generated/assets.dart';
import '../Widgets/my_drawer.dart';
import 'package:provider/provider.dart';
import '../../domain/models/labs_model.dart';
import '../Widgets/menu_appbar.dart';
import '../resources/color_manager.dart';
import '../resources/routes_manger.dart';
import '../resources/strings_manager.dart';
import '../resources/values_manager.dart';

class MainRoute extends StatefulWidget {
  const MainRoute({super.key});

  @override
  State<MainRoute> createState() => _MainRouteState();
}

class _MainRouteState extends State<MainRoute> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  return Directionality(
        textDirection: TextDirection.rtl,
      child: Scaffold(
       appBar: menuAppBar(context),
        backgroundColor: AppColors.white.withOpacity(.96),
        drawer: MyDrawer(),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    textDirection: TextDirection.rtl,
                    children: [
                      item(text: AppStrings.addRegister, function: () {
                        Provider.of<LabModel>(context,listen: false).getLabsList();
                        Navigator.pushNamed(context, Routes.searchWidgetFilter);
                      }, image: Assets.imagesRegister ,context: context),
                      item(text: AppStrings.labs, function: () {
                        Provider.of<LabModel>(context,listen: false).getLabsList();
                        Navigator.pushNamed(context, Routes.labsScreens);
                      }, image: Assets.imagesLabs ,context: context),
                    ],
                  ),
                  const SizedBox(height: AppSize.s20,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    textDirection: TextDirection.rtl,
                    children: [
                      item(text: AppStrings.representatives,  function: () {
                        Provider.of<RepresentativeModel>(context,listen: false).getRepresentatives();
                        Navigator.pushNamed(context, Routes.representativesScreens);
                      }, image: Assets.imagesRepresentative ,context: context),
                      item(text:
                      AppStrings.analysis, function: () {
                        Provider.of<AnalysisModel>(context,listen: false).getAnalysisList("");
                        Navigator.pushNamed(context, Routes.analysisScreens);
                      }, image: Assets.imagesAnalysis ,context: context),
                    ],
                  ),
                ],
              ),
            ),

          ),
        ),
      ),
    );
  }

  Widget item({required text, required function, required image,required context}) =>
      Expanded(
        child: InkWell(
          onTap: function,
          child: SizedBox( height: AppSize.s190,
            child: Card(
              child: Padding(
                padding:  const EdgeInsets.symmetric( horizontal: AppPadding.p14), //vertical: AppPadding.p20 ,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image: AssetImage(image), height: AppSize.s83, width: double.infinity),
                    const SizedBox(height: AppSize.s12,),
                    Center(child: Text(text, textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayLarge,)),
                  ],
                ),
              ),
            ),
          ),
        ),
      );


}

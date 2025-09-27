import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/reportsModel/representatives_report_data.dart';
import '../../data/reportsModel/lab_report_data.dart';
import '../../domain/models/labs_model.dart';
import '../../generated/assets.dart';
import '../Screens/addRequestsScreen/new_request_screen.dart';
import '../resources/color_manager.dart';
import '../resources/routes_manger.dart';
import '../resources/strings_manager.dart';
import '../resources/values_manager.dart';

class MyDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
//    log("FilePATH  ${FilePATH}");
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.7,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              height: AppSize.s60,
              color: AppColors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                      heightFactor: 0.5,
                      alignment: AlignmentDirectional.topEnd,
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.close))),
                  Text(
                    "محمود داود",  style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ],
              ),
            ),
            //  SizedBox(height: AppSize.s6),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    minLeadingWidth: AppSize.s30,
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, Routes.mainRout, (route) => false);
                    },
                    leading: Icon(Icons.home_outlined,
                        size: AppSize.s28, color: AppColors.primary),
                    title: Text(AppStrings.home,
                        style: Theme.of(context).textTheme.titleSmall,
                        textAlign: TextAlign.start),
                  ),
                  listTitle(context , onTap: () {
                      Navigator.popAndPushNamed(  context, Routes.searchWidgetFilter);
                    },title: AppStrings.addRegister,image: Assets.imagesAddReqest,
                  ),
                  ListTile(
                    minLeadingWidth: AppSize.s30,
                    onTap: () {
                      Provider.of<LabModel>(context,listen: false).getLabsList();
                      Provider.of<RepresentativesReportData>(context,listen: false).representativesLabsReport=[] ;
                      Provider.of<RepresentativesReportData>(context,listen: false).chargingValue=0 ;
                      Provider.of<RepresentativesReportData>(context,listen: false).transValue=0 ;
                      Navigator.popAndPushNamed(  context, Routes.representativeDayReportScreen);
                    },
                    leading: Image.asset( Assets.imagesUserReport,
                        width: AppSize.s28,  height: AppSize.s28),
                    title: Text( AppStrings.representativesReportDaily ,
                        style: Theme.of(context).textTheme.titleSmall,
                        textAlign: TextAlign.start),
                  ),
                  ListTile(
                    minLeadingWidth: AppSize.s30,
                    onTap: () {
                      Provider.of<LabModel>(context,listen: false).getLabsList();
                      Provider.of<RepresentativesReportData>(context,listen: false).clear();
                      Navigator.popAndPushNamed(  context, Routes.representativeMonthlyReportScreen);
                    },
                    leading: Image.asset( Assets.imagesUserReport,
                        width: AppSize.s28,  height: AppSize.s28),
                    title: Text( AppStrings.representativesReportMonthly ,
                        style: Theme.of(context).textTheme.titleSmall,
                        textAlign: TextAlign.start),
                  ),
                 listTitle(context , onTap: () {
                    Provider.of<LabReportModel>(context,listen: false).labReportList=[] ;
                    Navigator.pushNamed(context, Routes.labDayReportScreen);
                    },title: AppStrings.labReportDaily,image: Assets.imagesLabReport,
                  ),
                  listTitle(context , onTap: () {
                    Provider.of<LabReportModel>(context,listen: false).labReportList=[] ;
                    Navigator.pushNamed(context, Routes.labMonthlyReportScreen);
                    },title: AppStrings.labReportMonthly,image: Assets.imagesLabReport,
                  ),
                  listTitle(context , onTap: () {
                      Navigator.popAndPushNamed(  context, Routes.representativesListScreens);
                    },title: AppStrings.representatives,image: Assets.imagesFastDelivery,),
                  listTitle(context , onTap: () {
                      Navigator.popAndPushNamed(  context, Routes.labsListScreens);
                    },title: AppStrings.labs,image: Assets.imagesLabsIcon,
                  ),
                  listTitle(context , onTap: () {
                      Navigator.popAndPushNamed(  context, Routes.analysisListScreens);
                    },title: AppStrings.analysis,image: Assets.imagesAnalysisIcon,
                  ),
                  ListTile(
                    minLeadingWidth: AppSize.s30,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(  context,  MaterialPageRoute (
                        builder: (BuildContext context) => NewRequest(delete: true),
                      ), );
                    },
                    leading: Icon(Icons.bookmark_remove_outlined,
                        size: AppSize.s28, color: AppColors.primary),
                    title: Text(AppStrings.deleteRequest,
                        style: Theme.of(context).textTheme.titleSmall,
                        textAlign: TextAlign.start),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  }

  ListTile listTitle (BuildContext context ,
      {required VoidCallback onTap,required String title,required String image})
{
  return   ListTile(
    minLeadingWidth: AppSize.s30,
    onTap: onTap ,
    leading: Image.asset(image,
        width: AppSize.s28,  height: AppSize.s28, color: AppColors.primary),
    title: Text( title ,
        style: Theme.of(context).textTheme.titleSmall,
        textAlign: TextAlign.start),
  );
}




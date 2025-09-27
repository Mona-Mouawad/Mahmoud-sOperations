
import 'package:flutter/cupertino.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'color_manager.dart';
import 'values_manager.dart';

class AppConstants{
  static  bool appFirstOpen = false;
  static const int sliderAnimationTime = 300;

  static Widget bottomSheet =  const Padding(
    padding: EdgeInsets.symmetric(vertical:AppPadding.p5 , horizontal: AppPadding.p8 ),
    child: Row(
      children: [
        Text(
          'By: Mona Mouawad',
          style: TextStyle(fontSize: 10),
        ),
        Spacer(),
        SizedBox(
          width: 5,
        ),
        Text(
          'mona.mouawad21@gmail.com',
          style: TextStyle(fontSize: 10),
        ),
      ],
    ),
  ) ;

 static Widget myDivider() => Padding(
    padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p35, vertical: AppPadding.p18),
    child: Container(
      height:AppSize.s1,
      color: AppColors.grey,
    ),
  );

  static void myToast({
    required BuildContext context ,
    required String text,
    required ToastStates state
  })=>showToast( text ,
      context: context,
      animation: StyledToastAnimation.fade,
      reverseAnimation: StyledToastAnimation.slideToBottomFade,
      startOffset:const Offset(0.0, 3.0),
      reverseEndOffset:const Offset(0.0, 3.0),
      position:const StyledToastPosition(
          align: Alignment.center, offset: 0.0),
      duration:const Duration(seconds: 4),
      //Animation duration   animDuration * 2 <= duration
      animDuration:const Duration(milliseconds: 400),
      curve: Curves.linearToEaseOut,
      reverseCurve: Curves.fastOutSlowIn,
      backgroundColor: toastColor(state)
  );


}
enum ToastStates{success,error,warning}

Color toastColor(ToastStates state){

  switch (state) {
    case ToastStates.success :
      return AppColors.green;
    case ToastStates.error :
      return AppColors.error;
    default:
      return AppColors.lightOrange;
  }
}

import 'package:flutter/cupertino.dart';
import 'font_manager.dart';

TextStyle _getTextStyle(
    {required double fontSize,
    required Color color,
    required FontWeight fontWeight}) {
  return TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      fontFamily: FontFamily.fontFamily);
}

TextStyle getRegularTextStyle(
    {double fontSize = FontSize.s12,
    required Color color,
    FontWeight fontWeight = FontWeightManager.regular}) {
  return _getTextStyle(
    fontSize: fontSize,
    color: color,
    fontWeight: fontWeight,
  );
}


TextStyle getMediumTextStyle(
    {double fontSize = FontSize.s12,
      required Color color,
      FontWeight fontWeight = FontWeightManager.medium}) {
  return _getTextStyle(
    fontSize: fontSize,
    color: color,
    fontWeight: fontWeight,
  );
}


TextStyle getLightTextStyle(
    {double fontSize = FontSize.s12,
      required Color color,
      FontWeight fontWeight = FontWeightManager.light}) {
  return _getTextStyle(
    fontSize: fontSize,
    color: color,
    fontWeight: fontWeight,
  );
}

TextStyle getBoldTextStyle(
    {double fontSize = FontSize.s12,
      required Color color,
      FontWeight fontWeight = FontWeightManager.bold}) {
  return _getTextStyle(
    fontSize: fontSize,
    color: color,
    fontWeight: fontWeight,
  );
}


TextStyle getSemiBoldTextStyle(
    {double fontSize = FontSize.s12,
      required Color color,
      FontWeight fontWeight = FontWeightManager.semiBold}) {
  return _getTextStyle(
    fontSize: fontSize,
    color: color,
    fontWeight: fontWeight,
  );
}
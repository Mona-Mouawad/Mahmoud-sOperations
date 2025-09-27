
import 'package:flutter/material.dart';
import '../resources/color_manager.dart';
import '../resources/values_manager.dart';

ListTile listTileItems(context , String title ,VoidCallback onTab)
{
  return ListTile(
    minLeadingWidth: AppSize.s30,
    onTap: onTab ,
    trailing: Icon(Icons.arrow_forward_ios,
        size: AppSize.s28, color: AppColors.black),
    title: Text(title,
        style: Theme.of(context).textTheme.titleMedium,
        textAlign: TextAlign.start),
  );
}
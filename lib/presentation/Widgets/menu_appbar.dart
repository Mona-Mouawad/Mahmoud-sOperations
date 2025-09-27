
 import 'package:flutter/material.dart';

import '../resources/values_manager.dart';

 PreferredSizeWidget  menuAppBar(BuildContext context, {String title = ""})
{
  return AppBar(
      leadingWidth: AppSize.s80,
      title: Text(title),
  leading: Builder(
      builder: (context) => IconButton(
        icon:
         const Icon(Icons.menu, textDirection: TextDirection.rtl,),//),
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
    ),
  );
}

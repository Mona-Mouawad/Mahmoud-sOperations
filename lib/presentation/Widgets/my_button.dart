
import 'package:flutter/material.dart';

Widget myAppButton(context ,title ,VoidCallback onPressed)
{
  return   SizedBox(
    width: MediaQuery.of(context).size.width - 135,
    height: 48,
    child: ElevatedButton(
      onPressed: onPressed ,
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    ),
  );
}
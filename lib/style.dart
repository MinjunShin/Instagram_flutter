import 'package:flutter/material.dart';

final theme = ThemeData(
  iconTheme: IconThemeData(
      color: Colors.blue
  ),
  // textTheme: TextTheme(
  //   bodyText2: TextStyle( color : Colors.grey)
  // ),
  appBarTheme: AppBarTheme(
      color: Colors.white,
      elevation: 1,
      titleTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w700,
          fontSize: 25
      ),
      actionsIconTheme: IconThemeData(
          color: Colors.black
      ),
  ),
);
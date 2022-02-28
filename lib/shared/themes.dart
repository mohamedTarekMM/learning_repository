import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'colors.dart';

ThemeData light_Theme = ThemeData(

  drawerTheme: const DrawerThemeData(
    backgroundColor: Colors.white,
  ),
  textTheme: const TextTheme(
    headline6: TextStyle(
      color: Colors.black,
    ),
    bodyText2: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    bodyText1: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  ),
  primarySwatch: Colors.teal,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme:  const AppBarTheme(
    backgroundColor: Colors.white,
    iconTheme: const IconThemeData(
      color: Colors.black,
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.black,
    ),
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.teal,
  ),
);
ThemeData dark_Theme = ThemeData(

  iconTheme: IconThemeData(
      color: Colors.white
  ),
  drawerTheme: DrawerThemeData(
    backgroundColor: HexColor('333739'),
  ),
  textTheme: const TextTheme(
    headline6: TextStyle(
      color: Colors.white,
    ),
    bodyText2: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    bodyText1: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
  primarySwatch: Colors.teal,
  scaffoldBackgroundColor: darkHeaderClr,
  appBarTheme: AppBarTheme(
    actionsIconTheme: IconThemeData(
      color: Colors.black,
    ),
    backgroundColor: darkHeaderClr,
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    elevation: 0.0,
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739'),
      statusBarIconBrightness: Brightness.light,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.white,
    backgroundColor: HexColor('333739'),
    unselectedItemColor: Colors.grey,
  ),
);
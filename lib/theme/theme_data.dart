import 'package:flutter/material.dart';
import 'package:tunitacos_flutter/theme/colors.dart';

const cardTheme = CardTheme(
  surfaceTintColor: Colors.transparent,
  color: MyColors.primaryColor50,
);
//const filedButtonScheme = FilledButtonThemeData(style: TextButton.styleFrom( ));
const colorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: MyColors.primaryColor500,
  onPrimary: Colors.white,
  secondary: MyColors.secondaryColor500,
  onSecondary: Colors.white,
  tertiary: MyColors.ternaryColor500,
  onTertiary: Colors.white,
  error: Colors.red,
  onError: Colors.white,
  background: MyColors.ternaryColor100,
  onBackground: Colors.black,
  surface: Colors.white,
  onSurface: Colors.black,
);
const tabBarTheme = TabBarTheme(
  indicatorColor: MyColors.ternaryColor300,
  labelStyle: TextStyle(fontWeight: FontWeight.bold),
  labelColor: Color(0xffffffff),
  unselectedLabelColor: Color(0xfff3f3f3),
);

const bottomNavigationBarTheme = BottomNavigationBarThemeData(
  unselectedItemColor: MyColors.primaryColor600,
  type: BottomNavigationBarType.shifting,
  landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
  selectedItemColor: MyColors.ternaryColor500,
  showUnselectedLabels: true,
);
const appBarTheme = AppBarTheme(
  backgroundColor: MyColors.secondaryColor500,
  titleTextStyle: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
    color: Color(0xffffffff),
  ),
);

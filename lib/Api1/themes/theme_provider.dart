import 'package:api/Api1/themes/dark_mode.dart';
import 'package:api/Api1/themes/light_mode.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{

  // initial light mode
  ThemeData _themeData = lightMode;

  // get theme
  ThemeData get themeData => _themeData;

  // is dark mode
  bool get isDarkMode => _themeData == darkMode;

  // set theme
   set themeData(ThemeData themeData){
     _themeData = themeData;
     // update Ui
     notifyListeners();
   }

   void toggleTheme(){
     if(_themeData == lightMode){
       themeData = darkMode;
     }else{
       themeData = lightMode;
     }
   }

}
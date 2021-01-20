import 'dart:collection';

import 'package:flutter/material.dart';

const String TXT_HIDE = "GO HIDE";
const String LANG_EN = "ENG";
const String LANG_VI = "VI";

class AppLoc {
  AppLoc._privateConstructor();
  static final AppLoc instance = AppLoc._privateConstructor();

  String _appLanguage = LANG_VI;

  static final Map<String, Map<String, String>> appTexts = {
    //ENGLISH
    'EN': {
      TXT_HIDE: 'Go Hide!',
    },
    //VIETNAMESE
    'VI': {
      TXT_HIDE: 'Đi trốn!',
    }
  };

  String get(String key) {
    return appTexts[_appLanguage][key];
  }
}

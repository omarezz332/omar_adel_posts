import 'package:flutter/material.dart';
import 'package:omar_adel_posts/theme/text_styles.dart';

import '../helpers/enums.dart';
import 'app_colors.dart';
import 'dimensions.dart';


final _themeData = ThemeData();

ThemeData getThemeData(ThemeFlavor themeFlavor, {required bool isAr}) {
  final isLight = themeFlavor == ThemeFlavor.light;
  return ThemeData(
    fontFamily: isAr ? 'Almarai' : 'segoe',
    primaryColor:isLight? kPrimaryColor:kDarkPrimaryColor ,
    backgroundColor: isLight ? kGreyColor : kDarkBackgroundColor,
    scaffoldBackgroundColor: kBackgroundColor,
    canvasColor: kCanvasColor,
    errorColor: kErrorColor,
    dividerColor: kDividerColor,
    selectedRowColor: kSelectedColor,
    disabledColor: kDisabledColor,
    hintColor: kHintColor,
    hoverColor: kHoverColor,
    indicatorColor: kIndicatorColor,
    shadowColor: kShadowColor,
    unselectedWidgetColor: kUnselectedWidgetColor,
    iconTheme: IconThemeData(
      color: isLight ? kIconColor : kDarkIconColor,
    ),
    colorScheme: _themeData.colorScheme.copyWith(
      secondary: isLight ? kSecondaryColor : kDarkSecondaryColor,
      error: isLight ? kErrorColor : kDarkErrorColor,
      background: isLight ? kBackgroundColor : kDarkBackgroundColor,
      primary: isLight ? kPrimaryColor : kDarkPrimaryColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(kRadiusLarge),
        borderSide: BorderSide(color: isLight ? kHoverColor : kDarkHoverColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(kRadiusLarge),
        borderSide: BorderSide(color: isLight ? kHoverColor : kDarkHoverColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(kRadiusLarge),
        borderSide: BorderSide(color: isLight ? kHoverColor : kDarkHoverColor),
      ),
    ),
    textTheme: TextTheme(
      headline1: headLine1,
      headline2: headLine2,
      subtitle2: subtitle2,
      button: button,
      overline: overLine,
      caption: caption,
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as intl;

import '../theme/dimensions.dart';

/// *** Extensions on BuildContext class *** ----------------
extension SugarExt on BuildContext {
  //* MediaQuery
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  //* Dimensions Extensions
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;

  double heightR(double value) => MediaQuery.of(this).size.height * value;
  double widthR(double value) => MediaQuery.of(this).size.width * value;

  //* Device Breakpoints
  bool get isMobile => width <= 600;
  bool get isTablet => width > 600;
  bool get isDesktop => width > 950;
  bool get isLargeMobile => isMobile && height > 750;
  bool get isSmallMobile => isMobile && height < 550;

  //* Locale Extensions
  bool get isRTL =>
      intl.Bidi.isRtlLanguage(Localizations.localeOf(this).languageCode);

  //* Theme Extensions
  TextTheme get textTheme => Theme.of(this).textTheme;
  ThemeData get theme => Theme.of(this);

  TextStyle get textButtonUnderLine =>
      Theme.of(this).textTheme.headline5!.copyWith(
            color: Theme.of(this).errorColor,
            decoration: TextDecoration.underline,
          );

  TextStyle get hardTitle => Theme.of(this).textTheme.headline5!.copyWith(
        color: Theme.of(this).unselectedWidgetColor,
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
      );

  InputDecoration get normalInputDecoration => InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kRadiusSmall),
          borderSide: BorderSide(color: theme.hoverColor),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kRadiusSmall),
          borderSide: BorderSide(color: theme.hoverColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kRadiusSmall),
          borderSide: BorderSide(color: theme.hoverColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kRadiusSmall),
          borderSide: BorderSide(color: theme.hoverColor),
        ),
      );

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  void closeKeyboard() {
    FocusScope.of(this).requestFocus(FocusNode());
  }
}

extension TextThemeExtension on TextStyle {
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);
  TextStyle get semiBold =>
      copyWith(fontWeight: FontWeight.w600, color: const Color(0xFF505050));
  TextStyle get grays => copyWith(color: const Color(0xFF505050));
  TextStyle get hidden =>
      copyWith(color: const Color(0xFF505050).withOpacity(0.5), fontSize: 8.sp);
  TextStyle get title17 =>
      copyWith(fontWeight: FontWeight.w600, fontSize: 17.sp);
  TextStyle get bold17 => copyWith(
        fontWeight: FontWeight.bold,
        fontSize: 17.sp,
      );
  TextStyle withColor(Color? color) => copyWith(color: color);
}

extension Padd on Widget {
  Widget bottomPadding(double value) => Padding(
        padding: EdgeInsets.only(bottom: value),
        child: this,
      );
}

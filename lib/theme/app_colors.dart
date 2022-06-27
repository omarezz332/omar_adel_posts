import 'package:flutter/cupertino.dart';

Color kPrimaryColor = Color(fromHex("#15567C"));
Color kSecondaryColor = Color(fromHex("#F26D33"));
Color kBackgroundColor = Color(fromHex("#F5F5F5"));
Color kCanvasColor = Color(fromHex("#F5F5F5"));
Color kGreyColor = Color(fromHex("#9CB3BE"));
Color kDarkGreyColor = Color(fromHex("#585858"));
const Color kErrorColor = Color(0xFFFF1572);
const Color kIconColor = Color(0xFF707070);
const Color kDividerColor = Color(0xFFE2E2E2);
const Color kSelectedColor = Color(0xFF46B11F);
const Color kDisabledColor = Color(0xFF818181);
const Color kHintColor = Color(0xFFC4C3C3);
const Color kHoverColor = Color(0xFFDBD8D8);
const Color kShadowColor = Color(0xFFB9B9B9);
const Color kIndicatorColor = Color(0xFFB2B2B2);
const Color kUnselectedWidgetColor = Color(0xFF303336);
const Color kDarkPrimaryColor = Color(0xFFC4C3C3);
const Color kDarkSecondaryColor = Color(0xFF707070);
const Color kDarkBackgroundColor = Color(0xFF707070);
const Color kDarkCanvasColor = Color(0xFF707070);
const Color kDarkErrorColor = Color(0xFF707070);
const Color kDarkIconColor = Color(0xFF707070);
const Color kDarkDividerColor = Color(0xFF707070);
const Color kDarkSelectedColor = Color(0xFF707070);
const Color kDarkDisabledColor = Color(0xFF023566);
const Color kDarkHintColor = Color(0xFF023566);
const Color kDarkHoverColor = Color(0xFF023566);

int fromHex(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return int.parse(buffer.toString(), radix: 16);
}

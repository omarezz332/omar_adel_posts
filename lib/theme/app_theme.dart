import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omar_adel_posts/helpers/extensions.dart';

import 'app_theme_data.dart';
import 'app_theme_provider.dart';

class AppTheme extends StatelessWidget {
  final Widget navigator;

  const AppTheme({Key? key, required this.navigator}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, ref, __) {
         final currentThemeFlavor = ref.watch(appThemeProvider).themeFlavor;
        return Theme(
          data: getThemeData(
            currentThemeFlavor,
            isAr: context.isRTL,
          ), //     <-----     Theme
          child: navigator,
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../helpers/app_shared_prefs.dart';
import '../helpers/enums.dart';
import '../helpers/storage_keys.dart';

final appThemeProvider = ChangeNotifierProvider((ref) => AppThemeProvider());

class AppThemeProvider extends ChangeNotifier {
  //* State
  ThemeFlavor _themeFlavor = ThemeFlavor.light;

  //* Getters
  ThemeFlavor get themeFlavor => _themeFlavor;
  bool get isDarkTheme => _themeFlavor == ThemeFlavor.dark;

  //* Constructor and Methods
  AppThemeProvider() {
    // Load Theme as soon as the provider is created
    load();
  }

  Future<void> setThemeFlavor(ThemeFlavor flavor) async {
    _themeFlavor = flavor;
    AppSharedPrefs.instance.setInt(kTheme, flavor.index);
    notifyListeners();
  }

  Future<void> load() async {
    final int? userFlavor = AppSharedPrefs.instance.getInt(kTheme);
    if (userFlavor == null) {
      setThemeFlavor(ThemeFlavor.light); // <----- Default Theme Flavor
    } else {
      setThemeFlavor(ThemeFlavor.values[userFlavor]);
    }
  }
}

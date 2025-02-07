import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageChangeController with ChangeNotifier {
  Locale? _appLocale;

  Locale get appLocale => _appLocale ?? Locale('en'); // Default to English

  LanguageChangeController({required Locale initialLocale}) {
    _loadSavedLanguage(); // Load saved language when controller is created
  }

  Future<void> _loadSavedLanguage() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? languageCode = sp.getString('language_code');
    if (languageCode != null) {
      _appLocale = Locale(languageCode);
      notifyListeners();
    }
  }

  void changeLanguage(Locale type) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    _appLocale = type;
    await sp.setString('language_code', type.languageCode);
    notifyListeners();
  }
}

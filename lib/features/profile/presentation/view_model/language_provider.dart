import 'package:breast_cancer/features/profile/presentation/views/widgets/language_view_body.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider with ChangeNotifier {
  static const String _languageKey = 'selected_language';

  ChoosingLanguage _selectedLanguage = ChoosingLanguage.englishUS;

  LanguageProvider() {
    _loadLanguage();
  }

  ChoosingLanguage get selectedLanguage => _selectedLanguage;

  void setLanguage(ChoosingLanguage language) async {
    _selectedLanguage = language;
    notifyListeners();
    await _saveLanguage();
  }

  String get languageName {
    switch (_selectedLanguage) {
      case ChoosingLanguage.englishUS:
        return 'English (US)';
      case ChoosingLanguage.arabic:
        return 'العربية';
      case ChoosingLanguage.mandarin:
        return 'Mandarin';
      case ChoosingLanguage.hindi:
        return 'Hindi';
      case ChoosingLanguage.spanish:
        return 'Spanish';
      case ChoosingLanguage.french:
        return 'French';
      case ChoosingLanguage.englishUk:
        return 'English (UK)';
      case ChoosingLanguage.russian:
        return 'Russian';
      case ChoosingLanguage.indonesia:
        return 'Indonesia';
      case ChoosingLanguage.vietnamese:
        return 'Vietnamese';
      default:
        return 'English (US)';
    }
  }

  Locale get locale {
    switch (_selectedLanguage) {
      case ChoosingLanguage.arabic:
        return const Locale('ar');
      case ChoosingLanguage.mandarin:
        return const Locale('zh');
      case ChoosingLanguage.hindi:
        return const Locale('hi');
      case ChoosingLanguage.spanish:
        return const Locale('es');
      case ChoosingLanguage.french:
        return const Locale('fr');
      case ChoosingLanguage.englishUk:
        return const Locale('en', 'GB');
      case ChoosingLanguage.russian:
        return const Locale('ru');
      case ChoosingLanguage.indonesia:
        return const Locale('id');
      case ChoosingLanguage.vietnamese:
        return const Locale('vi');
      default:
        return const Locale('en', 'US');
    }
  }

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final lang = prefs.getString(_languageKey) ?? 'englishUS';
    _selectedLanguage = ChoosingLanguage.values.firstWhere(
      (element) => element.toString().split('.').last == lang,
      orElse: () => ChoosingLanguage.englishUS,
    );
    notifyListeners();
  }

  Future<void> _saveLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        _languageKey, _selectedLanguage.toString().split('.').last);
  }
}

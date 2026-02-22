import '../config/ai_language.dart';

class LanguageDetector {
  static AiLanguage detect(String text) {
    if (_contains(r'[\u0980-\u09FF]', text)) {
      return AiLanguage.bengali;
    }

    if (_contains(r'[\u0600-\u06FF]', text)) {
      return AiLanguage.arabic;
    }

    if (_contains(r'[\u0900-\u097F]', text)) {
      return AiLanguage.hindi;
    }

    if (_contains(r'[\u4E00-\u9FFF]', text)) {
      return AiLanguage.chinese;
    }

    if (_contains(r'[\u3040-\u30FF]', text)) {
      return AiLanguage.japanese;
    }

    return AiLanguage.english;
  }

  static bool _contains(String pattern, String text) {
    return RegExp(pattern).hasMatch(text);
  }
}
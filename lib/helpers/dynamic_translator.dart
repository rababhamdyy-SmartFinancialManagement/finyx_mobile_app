import 'package:translator/translator.dart';

class DynamicTranslator {
  static final Map<String, Map<String, String>> _cache = {};
  static final GoogleTranslator _translator = GoogleTranslator(); 

  static Future<String> getTranslated(String word, String targetLang) async {
    if (_cache[word] != null && _cache[word]![targetLang] != null) {
      return _cache[word]![targetLang]!;
    }

    final translation = await _translator.translate(word, to: targetLang);
    _cache[word] = {
      ...?_cache[word],
      targetLang: translation.text,
    };
    return translation.text;
  }
}

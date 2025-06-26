import 'package:finyx_mobile_app/helpers/dynamic_translator.dart';
import 'package:finyx_mobile_app/models/applocalization.dart';

Future<String> translateSmart(String key, AppLocalizations loc, String langCode) async {
  if (loc.has(key)) {
    return loc.translate(key);
  } else {
    return await DynamicTranslator.getTranslated(key, langCode);
  }
}

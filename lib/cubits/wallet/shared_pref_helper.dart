import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static Future<Map<String, double>> loadPrices() async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, double> prices = {};
    prefs.getKeys().forEach((key) {
      final value = prefs.getDouble(key);
      if (value != null) prices[key] = value;
    });
    return prices;
  }

  static Future<void> savePrices(Map<String, double> prices) async {
    final prefs = await SharedPreferences.getInstance();
    for (var key in prefs.getKeys()) {
      if (!prices.containsKey(key)) {
        prefs.remove(key);
      }
    }
    prices.forEach((key, value) {
      prefs.setDouble(key, value);
    });
  }

  static Future<void> setDialogShown(String label, bool shown) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('dialog_shown_$label', shown);
  }
  static Future<void> saveUserType(String userType) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user_type', userType); 
  }
  static Future<String?> getUserType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_type'); 
  }
}


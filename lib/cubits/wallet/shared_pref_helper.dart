import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  // Loads all prices stored in SharedPreferences and returns them as a Map
  static Future<Map<String, double>> loadPrices() async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, double> prices = {};

    // Iterate through all keys in SharedPreferences and retrieve the corresponding price values
    prefs.getKeys().forEach((key) {
      final value = prefs.get(key);
      if (value is double) {
        prices[key] = value;
      }
    });

    return prices;
  }

  // Saves the provided prices Map to SharedPreferences
  static Future<void> savePrices(Map<String, double> prices) async {
    final prefs = await SharedPreferences.getInstance();

    // Remove any existing keys that are not in the new prices map
    for (var key in prefs.getKeys()) {
      if (!prices.containsKey(key)) {
        prefs.remove(key); // Remove keys that no longer have a price
      }
    }

    // Store each price in SharedPreferences
    prices.forEach((key, value) {
      prefs.setDouble(key, value);
    });
  }

  // Stores whether the dialog for a specific label has been shown in SharedPreferences
  static Future<void> setDialogShown(String label, bool shown) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(
      'dialog_shown_$label',
      shown,
    ); // Save dialog visibility status
  }

  static Future<void> saveUserType(String userType) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('user_type', userType);
  // عند تغيير نوع المستخدم، نقوم بمسح جميع الأسعار القديمة
  await resetAllPrices();
}

static Future<String?> getUserType() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('user_type');
}

  static Future<void> saveLoginState(bool loggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_logged_in', loggedIn);
  }

  static Future<bool> getLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('is_logged_in') ?? false;
  }

  static Future<void> resetAllPrices() async {
    final prefs = await SharedPreferences.getInstance();
    final allKeys = prefs.getKeys();

    for (var key in allKeys) {
      if (prefs.get(key) is double) {
        await prefs.remove(key);
      }
    }
  }

  static Future<void> setLastResetDate(DateTime date) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('last_reset_date', date.toIso8601String());
  }

  static Future<DateTime?> getLastResetDate() async {
    final prefs = await SharedPreferences.getInstance();
    final dateString = prefs.getString('last_reset_date');
    return dateString != null ? DateTime.parse(dateString) : null;
  }

}

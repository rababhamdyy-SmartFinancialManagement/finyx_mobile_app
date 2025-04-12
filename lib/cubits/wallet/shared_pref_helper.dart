import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  // Loads all prices stored in SharedPreferences and returns them as a Map
  static Future<Map<String, double>> loadPrices() async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, double> prices = {};

    // Iterate through all keys in SharedPreferences and retrieve the corresponding price values
    prefs.getKeys().forEach((key) {
      final value = prefs.getDouble(key);
      if (value != null)
        prices[key] = value; // Add to map if a valid value is found
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
    prefs.setString('user_type', userType); 
  }
  static Future<String?> getUserType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_type'); 
  }
}

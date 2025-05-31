import 'package:finyx_mobile_app/cubits/wallet/shared_pref_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PriceState {
  final Map<String, double> prices;
  final bool showError;

  // Constructor to initialize the state with prices and error flag
  PriceState({required this.prices, this.showError = false});

  // Method to copy the current state with optional changes
  PriceState copyWith({Map<String, double>? prices, bool? showError}) {
    return PriceState(
      prices: prices ?? this.prices,
      showError: showError ?? this.showError,
    );
  }
}

class PriceCubit extends Cubit<PriceState> {
  final FlutterLocalNotificationsPlugin notificationsPlugin;

  PriceCubit(this.notificationsPlugin) : super(PriceState(prices: {})) {
    _loadPrices(); // Load prices from SharedPreferences on initialization
  }

  // Loads the prices from SharedPreferences at the start of the app
  Future<void> _loadPrices() async {
    final prices = await SharedPrefsHelper.loadPrices();
    emit(state.copyWith(prices: prices));
  }

  // Updates the price for a given label if the price is valid
  void updatePrice(String label, double price) {
    if (price <= 0) {
      setShowError(true); // Show error if the price is invalid
      return;
    }

    final newPrices = Map<String, double>.from(state.prices);
    final bool isNewPrice = !state.prices.containsKey(label);
    newPrices[label] = price;

    // Save the updated prices in SharedPreferences
    SharedPrefsHelper.savePrices(newPrices);

    // Emit the new state only if the prices have actually changed
    if (newPrices.toString() != state.prices.toString()) {
      emit(state.copyWith(prices: newPrices));

      _showPriceNotification(
        isNewPrice ? 'Add New Price' : 'Price Updated',
        isNewPrice
            ? 'Added new price for $label: $price'
            : 'Updated price for $label: $price',
      );
    }
  }

  // Sets the error flag to indicate an error state
  void setShowError(bool showError) {
    emit(state.copyWith(showError: showError));
  }

  // Removes a price for a given label and saves the updated prices
  void removePrice(String label) {
    if (state.prices.containsKey(label)) {
      final newPrices = Map<String, double>.from(state.prices);
      newPrices.remove(label);

      // Save the prices after removal in SharedPreferences
      SharedPrefsHelper.savePrices(newPrices);

      emit(state.copyWith(prices: newPrices));

      _showPriceNotification(
        'Removed Price',
        'Price for $label has been removed',
      );
    }
  }

  Future<void> _showPriceNotification(String title, String message) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          'price_updates',
          'Price Updates',
          importance: Importance.high,
          priority: Priority.high,
          channelShowBadge: true,
          styleInformation: BigTextStyleInformation(''),
        );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    await notificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch.hashCode,
      title,
      message,
      notificationDetails,
    );
  }

  // Checks if the monthly prices need to be reset and resets them if necessary
  Future<void> checkAndResetMonthlyPrices() async {
    final now = DateTime.now();
    final lastResetDate = await SharedPrefsHelper.getLastResetDate();


    if (lastResetDate == null ||
        now.month != lastResetDate.month ||
        now.year != lastResetDate.year) {
      await SharedPrefsHelper.resetAllPrices();
      await SharedPrefsHelper.setLastResetDate(now);

      _showPriceNotification(
        'Monthly Reset',
        'All prices have been reset for the new month',
      );

      emit(PriceState(prices: {}));
    }
  }

  Future<void> initialize() async {
    await _loadPrices();
    await checkAndResetMonthlyPrices();
  }
}

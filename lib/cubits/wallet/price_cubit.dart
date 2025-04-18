import 'package:finyx_mobile_app/cubits/wallet/shared_pref_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  PriceCubit() : super(PriceState(prices: {})) {
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
    newPrices[label] = price;

    // Save the updated prices in SharedPreferences
    SharedPrefsHelper.savePrices(newPrices);

    // Emit the new state only if the prices have actually changed
    if (newPrices.toString() != state.prices.toString()) {
      emit(state.copyWith(prices: newPrices));
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
    }
  }
}

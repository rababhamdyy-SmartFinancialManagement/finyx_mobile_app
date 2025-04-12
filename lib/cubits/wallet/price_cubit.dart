import 'package:flutter_bloc/flutter_bloc.dart';
import 'shared_pref_helper.dart';

class PriceState {
  final Map<String, double> prices;
  PriceState({required this.prices});
}

class PriceCubit extends Cubit<PriceState> {
  PriceCubit() : super(PriceState(prices: {})) {
    _loadPrices();
  }

  void _loadPrices() async {
    final prices = await SharedPrefsHelper.loadPrices();
    emit(PriceState(prices: prices));
  }

  void updatePrice(String label, double price) async {
    final newPrices = Map<String, double>.from(state.prices);
    newPrices[label] = price;
    emit(PriceState(prices: newPrices));
    await SharedPrefsHelper.savePrices(newPrices);
  }

  void removePrice(String label) async {
    final newPrices = Map<String, double>.from(state.prices);
    newPrices.remove(label);
    emit(PriceState(prices: newPrices));
    await SharedPrefsHelper.savePrices(newPrices);
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';

class PriceState {
  final Map<String, double> prices;
  final bool showError;

  PriceState({
    required this.prices,
    this.showError = false,  // إضافة خاصية الخطأ
  });

  // دالة لنسخ الحالة مع التغييرات المطلوبة
  PriceState copyWith({
    Map<String, double>? prices,
    bool? showError,
  }) {
    return PriceState(
      prices: prices ?? this.prices,
      showError: showError ?? this.showError,
    );
  }
}

class PriceCubit extends Cubit<PriceState> {
  PriceCubit() : super(PriceState(prices: {}));

  // دالة لتحديث السعر
  void updatePrice(String label, double price) {
    final newPrices = Map<String, double>.from(state.prices);
    newPrices[label] = price;
    emit(state.copyWith(prices: newPrices));
  }

  // دالة لتغيير حالة الخطأ
  void setShowError(bool showError) {
    emit(state.copyWith(showError: showError));
  }

  // دالة لإزالة السعر
  void removePrice(String label) {
    final newPrices = Map<String, double>.from(state.prices);
    newPrices.remove(label);
    emit(state.copyWith(prices: newPrices));
  }
}

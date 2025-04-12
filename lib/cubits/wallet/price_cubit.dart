import 'package:finyx_mobile_app/cubits/wallet/shared_pref_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PriceState {
  final Map<String, double> prices;
  final bool showError;

  PriceState({required this.prices, this.showError = false});

  // دالة لنسخ الحالة مع التغييرات المطلوبة
  PriceState copyWith({Map<String, double>? prices, bool? showError}) {
    return PriceState(
      prices: prices ?? this.prices,
      showError: showError ?? this.showError,
    );
  }
}

class PriceCubit extends Cubit<PriceState> {
  PriceCubit() : super(PriceState(prices: {})) {
    _loadPrices();
  }

  // تحميل الأسعار من SharedPreferences عند بداية التشغيل
  Future<void> _loadPrices() async {
    final prices = await SharedPrefsHelper.loadPrices();
    emit(state.copyWith(prices: prices));
  }

  // دالة لتحديث السعر
  void updatePrice(String label, double price) {
    if (price <= 0) {
      setShowError(true);
      return;
    }

    final newPrices = Map<String, double>.from(state.prices);
    newPrices[label] = price;

    // حفظ الأسعار في SharedPreferences
    SharedPrefsHelper.savePrices(newPrices);

    // التأكد من أنه يوجد تغيير فعلي
    if (newPrices.toString() != state.prices.toString()) {
      emit(state.copyWith(prices: newPrices));
    }
  }

  // دالة لتغيير حالة الخطأ
  void setShowError(bool showError) {
    emit(state.copyWith(showError: showError));
  }

  // دالة لإزالة السعر
  void removePrice(String label) {
    if (state.prices.containsKey(label)) {
      final newPrices = Map<String, double>.from(state.prices);
      newPrices.remove(label);

      // حفظ الأسعار بعد الإزالة
      SharedPrefsHelper.savePrices(newPrices);

      emit(state.copyWith(prices: newPrices));
    }
  }
}

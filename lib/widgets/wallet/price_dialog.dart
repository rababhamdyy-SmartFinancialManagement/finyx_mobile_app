import 'package:flutter/material.dart';
import 'package:finyx_mobile_app/cubits/wallet/price_cubit.dart';
import 'package:finyx_mobile_app/cubits/wallet/shared_pref_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PriceDialog extends StatelessWidget {
  final TextEditingController priceController;
  final PriceCubit cubit;
  final PriceState state;
  final String label;
  final IconData icon;
  final Color iconColor;

  const PriceDialog({
    super.key,
    required this.priceController,
    required this.cubit,
    required this.state,
    required this.label,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PriceCubit, PriceState>(
      builder: (context, state) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: _buildTitle(),
          content: _buildContent(state),
          actions: _buildActions(context, state),
        );
      },
    );
  }

  Widget _buildTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: iconColor),
          ),
          child: Icon(icon, size: 40, color: iconColor),
        ),
        const SizedBox(width: 16),
        Text(
          label,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: "Poppins",
            color: iconColor,
          ),
        ),
      ],
    );
  }

  Widget _buildContent(PriceState state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: priceController,
          decoration: InputDecoration(
            hintText: 'Enter Price',
            border: OutlineInputBorder(),
            errorText: state.showError ? 'Please enter a valid price' : null,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: iconColor),
            ),
          ),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  List<Widget> _buildActions(BuildContext context, PriceState state) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              cubit.setShowError(false);
              Navigator.of(context).pop();
            },
            child: Text(
              'Cancel',
              style: TextStyle(color: iconColor, fontFamily: "Poppins"),
            ),
          ),
          const SizedBox(width: 10),
          TextButton(
            onPressed: () async {
              double? price = double.tryParse(priceController.text);
              if (price == null || price <= 0) {
                cubit.setShowError(true); // عرض رسالة الخطأ
                return;
              }
              // تحديث السعر في الـ Cubit
              cubit.updatePrice(label, price);

              // حفظ السعر في SharedPreferences
              await SharedPrefsHelper.savePrices(cubit.state.prices);

              // إخفاء رسالة الخطأ بعد الحفظ
              cubit.setShowError(false);

              // إغلاق الـ Dialog
              Navigator.of(context).pop();
            },
            child: Text(
              'Save',
              style: TextStyle(color: iconColor, fontFamily: "Poppins"),
            ),
          ),
        ],
      ),
    ];
  }
}

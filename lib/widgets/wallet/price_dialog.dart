import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/wallet/price_cubit.dart';
import '../../cubits/wallet/shared_pref_helper.dart';
import '../../models/applocalization.dart';

class PriceDialog extends StatelessWidget {
  final TextEditingController priceController;
  final PriceCubit cubit;
  final PriceState state;
  final String label; // سيتم استخدامه كمفتاح للترجمة
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
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return BlocBuilder<PriceCubit, PriceState>(
      builder: (context, state) {
        return AlertDialog(
          backgroundColor: theme.dialogTheme.backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: _buildTitle(loc),
          content: _buildContent(loc, state),
          actions: _buildActions(context, loc, state),
        );
      },
    );
  }

  Widget _buildTitle(AppLocalizations loc) {
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
          loc.translate(label), // ترجمة النص هنا
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

  Widget _buildContent(AppLocalizations loc, PriceState state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: priceController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: loc.translate("price"),
            border: const OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: iconColor),
            ),
            errorText: state.showError ? loc.translate("price_error") : null,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  List<Widget> _buildActions(
    BuildContext context,
    AppLocalizations loc,
    PriceState state,
  ) {
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
              loc.translate("cancel"),
              style: TextStyle(color: iconColor, fontFamily: "Poppins"),
            ),
          ),
          const SizedBox(width: 10),
          TextButton(
            onPressed: () async {
              final price = double.tryParse(priceController.text.trim());

              if (price == null || price <= 0) {
                cubit.setShowError(true);
                return;
              }

              // استخدام المفتاح الأصلي (label) عند الحفظ
              cubit.updatePrice(label, price);
              await SharedPrefsHelper.savePrices(cubit.state.prices);
              cubit.setShowError(false);
              Navigator.of(context).pop();
            },
            child: Text(
              loc.translate("save"),
              style: TextStyle(color: iconColor, fontFamily: "Poppins"),
            ),
          ),
        ],
      ),
    ];
  }
}

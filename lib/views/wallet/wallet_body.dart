import 'package:finyx_mobile_app/cubits/wallet/shared_pref_helper.dart';
import 'package:finyx_mobile_app/models/applocalization.dart';
import 'package:finyx_mobile_app/models/user_type.dart';
import 'package:finyx_mobile_app/widgets/wallet/price_dialog.dart';
import 'package:finyx_mobile_app/widgets/wallet/wallet_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finyx_mobile_app/cubits/wallet/price_cubit.dart';

class WalletBody extends StatelessWidget {
  final UserType userType;

  WalletBody({
    super.key,
    required this.userType,
  });

  final List<Color> iconColors = [
    Colors.orange,
    Colors.blue,
    Colors.green,
    Colors.purple,
    Colors.pink,
    Colors.teal,
    Colors.indigo,
  ];

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    List<Map<String, dynamic>> getDefaultItems() {
      if (userType == UserType.individual) {
        return [
          {'icon': Icons.flash_on, 'label': 'electricity'},
          {'icon': Icons.wifi, 'label': 'internet'},
          {'icon': Icons.fastfood_outlined, 'label': 'food'},
          {'icon': Icons.money, 'label': 'zakat'},
          {'icon': Icons.shopping_cart, 'label': 'shopping'},
          {'icon': Icons.local_gas_station, 'label': 'gas'},
          {'icon': Icons.water_drop, 'label': 'waterBill'},
        ];
      } else {
        return [
          {'icon': Icons.bar_chart, 'label': 'tRevenue'},
          {'icon': Icons.stacked_line_chart, 'label': 'tExpenses'},
          {'icon': Icons.trending_up, 'label': 'profits'},
          {'icon': Icons.trending_down, 'label': 'losses'},
          {'icon': Icons.multiple_stop_rounded, 'label': 'transfer'},
          {'icon': Icons.monetization_on_rounded, 'label': 'eSalaries'},
          {'icon': Icons.account_balance_wallet, 'label': 'loan'},
        ];
      }
    }

    String _getTranslatedLabel(String originalLabel) {
      return loc.translate(originalLabel) ?? originalLabel;
    }

    bool _isDefaultItem(String label) {
      return getDefaultItems().any((item) => item['label'] == label);
    }

    Color _getIconColor(String label, PriceCubit cubit, IconData icon) {
      final defaultItems = getDefaultItems();
      int index = defaultItems.indexWhere((item) => item['label'] == label);
      if (index != -1) {
        return iconColors[index % iconColors.length];
      } else {
        final newItemIndex = cubit.state.prices.keys.toList().indexOf(label);
        return iconColors[(newItemIndex + defaultItems.length) % iconColors.length];
      }
    }

    void _showModal(BuildContext context, String label, IconData icon) async {
      TextEditingController priceController = TextEditingController();
      final cubit = context.read<PriceCubit>();
      double? currentPrice = cubit.state.prices[label];
      if (currentPrice != null) {
        priceController.text = currentPrice.toString();
      }
      Color iconColor = _getIconColor(label, cubit, icon);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return BlocBuilder<PriceCubit, PriceState>(
            builder: (context, state) {
              return PriceDialog(
                priceController: priceController,
                cubit: cubit,
                state: state,
                label: label,
                icon: icon,
                iconColor: iconColor,
              );
            },
          );
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<PriceCubit, PriceState>(
        builder: (context, state) {
          final defaultItems = getDefaultItems();
          final entries = state.prices.entries.toList();
          
          return ListView.builder(
            itemCount: defaultItems.length + entries.length,
            itemBuilder: (context, index) {
              if (index < defaultItems.length) {
                final item = defaultItems[index];
                final originalLabel = item['label'];
                final label = _getTranslatedLabel(originalLabel);
                final icon = item['icon'];
                final price = state.prices[originalLabel] ?? state.prices[label];
                final iconColor = iconColors[index % iconColors.length];
                final bgColor = iconColor.withAlpha(15);

                return WalletListTile(
                  icon: icon,
                  label: label,
                  price: price,
                  context: context,
                  onTap: () => _showModal(context, originalLabel, icon),
                  isDeletable: false,
                  backgroundColor: bgColor,
                  iconColor: iconColor,
                );
              } else {
                final entry = entries[index - defaultItems.length];
                final label = entry.key;
                final price = entry.value;

                if (_isDefaultItem(label)) return const SizedBox.shrink();

                final iconColor = iconColors[(defaultItems.length + index) % iconColors.length];
                final bgColor = iconColor.withAlpha(15);

                return Dismissible(
                  key: Key(label),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    color: iconColor,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) {
                    context.read<PriceCubit>().removePrice(label);
                  },
                  child: WalletListTile(
                    icon: Icons.add,
                    label: label,
                    price: price,
                    context: context,
                    onTap: () => _showModal(context, label, Icons.add),
                    isDeletable: true,
                    backgroundColor: bgColor,
                    iconColor: iconColor,
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
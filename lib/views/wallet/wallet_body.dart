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

  // List of colors for icons
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

    // Default items for individual users
    final List<Map<String, dynamic>> defaultItemsIndividual = [
      {'icon': Icons.flash_on, 'label': loc.translate('electricity')},
      {'icon': Icons.wifi, 'label': loc.translate('internet')},
      {'icon': Icons.fastfood_outlined, 'label': loc.translate('food')},
      {'icon': Icons.money, 'label': loc.translate('zakat')},
      {'icon': Icons.shopping_cart, 'label': loc.translate('shopping')},
      {'icon': Icons.local_gas_station, 'label': loc.translate('gas')},
      {'icon': Icons.water_drop, 'label': loc.translate('waterBill')},
    ];

    // Default items for business users
    final List<Map<String, dynamic>> defaultItemsBusiness = [
      {'icon': Icons.bar_chart, 'label': loc.translate('tRevenue')},
      {'icon': Icons.stacked_line_chart, 'label': loc.translate('tExpenses')},
      {'icon': Icons.trending_up, 'label': loc.translate('profits')},
      {'icon': Icons.trending_down, 'label': loc.translate('losses')},
      {'icon': Icons.multiple_stop_rounded, 'label': loc.translate('transfer')},
      {'icon': Icons.monetization_on_rounded, 'label': loc.translate('eSalaries')},
      {'icon': Icons.account_balance_wallet, 'label': loc.translate('loan')},
    ];

    final defaultItems = userType == UserType.individual
        ? defaultItemsIndividual
        : defaultItemsBusiness;

    bool _isDefaultItem(String label) {
      return defaultItems.any((item) => item['label'] == label);
    }

    Color _getIconColor(String label, PriceCubit cubit, IconData icon) {
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
          final entries = state.prices.entries.toList();
          return ListView.builder(
            itemCount: defaultItems.length + entries.length,
            itemBuilder: (context, index) {
              if (index < defaultItems.length) {
                final item = defaultItems[index];
                final label = item['label'];
                final icon = item['icon'];
                final price = state.prices[label];
                final iconColor = iconColors[index % iconColors.length];
                final bgColor = iconColor.withAlpha(15);

                return WalletListTile(
                  icon: icon,
                  label: label,
                  price: price,
                  context: context,
                  onTap: () => _showModal(context, label, icon),
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
                    SharedPrefsHelper.savePrices(state.prices);
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

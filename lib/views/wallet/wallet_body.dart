import 'package:finyx_mobile_app/cubits/wallet/shared_pref_helper.dart';
import 'package:finyx_mobile_app/models/user_type.dart';
import 'package:finyx_mobile_app/widgets/wallet/price_dialog.dart';
import 'package:finyx_mobile_app/widgets/wallet/wallet_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finyx_mobile_app/cubits/wallet/price_cubit.dart';

class WalletBody extends StatelessWidget {
  final UserType userType; // The type of user (individual or business)

  WalletBody({
    super.key,
    required this.userType,
  }); // Ensure userType is passed when creating the widget

  // Default items for individual users
  final List<Map<String, dynamic>> defaultItemsIndividual = [
    {'icon': Icons.flash_on, 'label': 'Electricity'},
    {'icon': Icons.wifi, 'label': 'Internet'},
    {'icon': Icons.fastfood_outlined, 'label': 'Food'},
    {'icon': Icons.money, 'label': 'Zakat'},
    {'icon': Icons.shopping_cart, 'label': 'Shopping'},
    {'icon': Icons.local_gas_station, 'label': 'Gas'},
    {'icon': Icons.water_drop, 'label': 'WaterBill'},
  ];

  // Default items for business users
  final List<Map<String, dynamic>> defaultItemsBusiness = [
    {'icon': Icons.bar_chart, 'label': 'T Revenue'},
    {'icon': Icons.stacked_line_chart, 'label': 'T Expenses'},
    {'icon': Icons.trending_up, 'label': 'Profits'},
    {'icon': Icons.trending_down, 'label': 'Losses'},
    {'icon': Icons.multiple_stop_rounded, 'label': 'Transfer'},
    {'icon': Icons.monetization_on_rounded, 'label': 'E salaries'},
    {'icon': Icons.account_balance_wallet, 'label': 'Loan'},
  ];

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

  // Determines the default items based on the user type
  List<Map<String, dynamic>> get defaultItems {
    return userType == UserType.individual
        ? defaultItemsIndividual
        : defaultItemsBusiness;
  }

  // Shows the modal dialog to update the price of an item
  void _showModal(BuildContext context, String label, IconData icon) async {
    TextEditingController priceController = TextEditingController();
    final cubit = context.read<PriceCubit>();

    // Check if there is a saved price for the item
    double? currentPrice = cubit.state.prices[label];
    if (currentPrice != null) {
      priceController.text = currentPrice.toString();
    }

    Color iconColor = _getIconColor(
      label,
      cubit,
      icon,
    ); // Get the appropriate icon color

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocBuilder<PriceCubit, PriceState>(
          builder: (context, state) {
            // Return the price dialog
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

  // Checks if the label is a default item
  bool _isDefaultItem(String label) {
    return defaultItems.any((item) => item['label'] == label);
  }

  // Determines the icon color based on the item label
  Color _getIconColor(String label, PriceCubit cubit, IconData icon) {
    int index = defaultItems.indexWhere((item) => item['label'] == label);
    if (index != -1) {
      return iconColors[index % iconColors.length];
    } else {
      final newItemIndex = cubit.state.prices.keys.toList().indexOf(label);
      return iconColors[(newItemIndex + defaultItems.length) %
          iconColors.length];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<PriceCubit, PriceState>(
        builder: (context, state) {
          final entries = state.prices.entries.toList();
          return ListView.builder(
            itemCount: defaultItems.length + entries.length,
            itemBuilder: (context, index) {
              // Display default items first
              if (index < defaultItems.length) {
                final item = defaultItems[index];
                final label = item['label'];
                final icon = item['icon'];
                final price = state.prices[label];
                final iconColor = iconColors[index % iconColors.length];

                Color bgColor = iconColor.withAlpha(15);

                return WalletListTile(
                  icon: icon,
                  label: label,
                  price: price,
                  context: context,
                  onTap: () => _showModal(context, label, icon),
                  isDeletable: false, // Default items are not deletable
                  backgroundColor: bgColor,
                  iconColor: iconColor,
                );
              } else {
                // Display added items with swipe-to-delete functionality
                final entry = entries[index - defaultItems.length];
                final label = entry.key;
                final price = entry.value;

                if (_isDefaultItem(label)) return const SizedBox.shrink();

                final iconColor =
                    iconColors[(defaultItems.length + index) %
                        iconColors.length];
                Color bgColor = iconColor.withAlpha(15);

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
                    // Remove the item from SharedPreferences
                    SharedPrefsHelper.savePrices(state.prices);
                  },
                  child: WalletListTile(
                    icon: Icons.add, // Use an "add" icon for added items
                    label: label,
                    price: price,
                    context: context,
                    onTap: () => _showModal(context, label, Icons.add),
                    isDeletable: true, // Items added by the user are deletable
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

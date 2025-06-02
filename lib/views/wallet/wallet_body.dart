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

  final Map<String, String> moreItems = {
    'Club': 'club',
    'Mobile Credit': 'mobile_credit',
    'Car': 'car',
    'Voucher': 'voucher',
    'Assurance': 'assurance',
    'Cinema': 'cinema',
    'Association': 'association',
    'Licenses': 'licenses',
    'Accrued Interest': 'accrued_interest',
    'Admin Expenses': 'admin_expenses',
    'Shipping': 'shipping'
  };

  bool _isDefaultItem(String label) {
    return getDefaultItems().any((item) => item['label'] == label);
  }

  bool _isMoreItemValue(String label) {
    return moreItems.containsValue(label);
  }

  Future<void> _showResetConfirmationDialog(BuildContext context) async {
    final loc = AppLocalizations.of(context)!;
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(loc.translate('reset_confirmation_title') ),
          content: Text(loc.translate('reset_confirmation_message') ),
          actions: <Widget>[
            TextButton(
              child: Text(loc.translate('cancel')),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(loc.translate('yes') ?? 'Yes'),
              onPressed: () async {
                Navigator.of(context).pop();
                await context.read<PriceCubit>().checkAndResetMonthlyPrices();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    String _getDisplayLabel(String originalLabel) {
      if (_isDefaultItem(originalLabel)) {
        return loc.translate(originalLabel) ?? originalLabel;
      }

      if (_isMoreItemValue(originalLabel)) {
        return loc.translate(originalLabel) ?? originalLabel;
      }

      return originalLabel;
    }

    Color _getIconColor(String label, PriceCubit cubit) {
      final defaultItems = getDefaultItems();
      int index = defaultItems.indexWhere((item) => item['label'] == label);
      if (index != -1) {
        return iconColors[index % iconColors.length];
      } else {
        final allItems = [
          ...defaultItems.map((e) => e['label']),
          ...cubit.state.prices.keys
        ];
        final itemIndex = allItems.indexWhere((item) => item == label);
        return iconColors[itemIndex % iconColors.length];
      }
    }

    void _showModal(BuildContext context, String label, IconData icon) async {
      TextEditingController priceController = TextEditingController();
      final cubit = context.read<PriceCubit>();
      double? currentPrice = cubit.state.prices[label];
      if (currentPrice != null) {
        priceController.text = currentPrice.toString();
      }
      Color iconColor = _getIconColor(label, cubit);

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
      child: Column(
        children: [
          // الجزء المعدل: النص في الوسط والريفريش أيقونة على اليمين
          Container(
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: Text(
                  loc.translate('start_fresh_or_enter_new_expenses') ,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey,
                      ),
                ),
                ),
                Positioned(
                  right: 0,
                  child: IconButton(
                    icon: const Icon(Icons.refresh, size: 18),
                    onPressed: () => _showResetConfirmationDialog(context),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    iconSize: 18,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: BlocBuilder<PriceCubit, PriceState>(
              builder: (context, state) {
                final defaultItems = getDefaultItems();
                final defaultLabels = defaultItems.map((item) => item['label']).toSet();

                final customEntries = state.prices.entries
                    .where((entry) => !defaultLabels.contains(entry.key))
                    .toList();

                final itemsToShow = [
                  ...defaultItems.map((item) => {
                        'type': 'default',
                        'label': item['label'],
                        'icon': item['icon']
                      }),
                  ...customEntries.map((entry) => {
                        'type': 'custom',
                        'label': entry.key,
                        'icon': Icons.add
                      })
                ];

                return ListView.builder(
                  itemCount: itemsToShow.length,
                  itemBuilder: (context, index) {
                    final item = itemsToShow[index];
                    final originalLabel = item['label'];
                    final label = _getDisplayLabel(originalLabel);
                    final icon = item['icon'];
                    final price = state.prices[originalLabel] ?? 0.0;
                    final iconColor = _getIconColor(originalLabel, context.read<PriceCubit>());
                    final bgColor = iconColor.withAlpha(15);

                    if (item['type'] == 'default') {
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
                      return Dismissible(
                        key: Key(originalLabel),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          color: iconColor,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (_) {
                          context.read<PriceCubit>().removePrice(originalLabel);
                        },
                        child: WalletListTile(
                          icon: icon,
                          label: label,
                          price: price,
                          context: context,
                          onTap: () => _showModal(context, originalLabel, icon),
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
          ),
        ],
      ),
    );
  }
}

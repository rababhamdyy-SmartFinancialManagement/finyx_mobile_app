import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finyx_mobile_app/cubits/wallet/price_cubit.dart';
import 'package:finyx_mobile_app/cubits/wallet/shared_pref_helper.dart';

class WalletBody extends StatelessWidget {
  WalletBody({super.key});

  final List<Map<String, dynamic>> defaultItems = [
    {'label': 'House Rent', 'icon': Icons.home},
    {'label': 'Dining', 'icon': Icons.local_dining},
    {'label': 'Groceries', 'icon': Icons.shopping_cart},
    {'label': 'Services', 'icon': Icons.gesture},
    {'label': 'Transport', 'icon': Icons.car_rental},
    {'label': 'Wallet', 'icon': Icons.account_balance_wallet},
  ];

  final List<Color> backgroundColors = [
    Colors.blue.shade50,
    Colors.green.shade50,
    Colors.orange.shade50,
    Colors.purple.shade50,
    Colors.teal.shade50,
    Colors.red.shade50,
  ];

  final List<Color> iconColors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.red,
  ];

  void _showModal(BuildContext context, String label, IconData icon) async {
    TextEditingController priceController = TextEditingController();
    bool showError = false;

    double? currentPrice = context.read<PriceCubit>().state.prices[label];
    if (currentPrice != null) {
      priceController.text = currentPrice.toString();
    }

    // تحديد اللون للعناصر الجديدة بناءً على القائمة المتعرفة
    int index = defaultItems.indexWhere((item) => item['label'] == label);

    // إذا كان العنصر موجودًا في العناصر المتعرفة، نستخدم الألوان المتعرفة
    Color bgColor;
    Color iconColor;

    if (index != -1) {
      bgColor = backgroundColors[index % backgroundColors.length];
      iconColor = iconColors[index % iconColors.length];
    } else {
      // إذا كان العنصر جديدًا، نستخدم نفس الآلية للتعيين باستخدام فهرس العنصر
      final newItemIndex = context.read<PriceCubit>().state.prices.keys.toList().indexOf(label);
      bgColor = backgroundColors[(newItemIndex + defaultItems.length) % backgroundColors.length];
      iconColor = iconColors[(newItemIndex + defaultItems.length) % iconColors.length];
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: iconColor),
                    ),
                    child: Icon(
                      icon,
                      size: 40,
                      color: iconColor,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: iconColor, // التأكد من استخدام اللون الصحيح هنا
                    ),
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: priceController,
                    decoration: InputDecoration(
                      hintText: 'Enter Price',
                      border: OutlineInputBorder(),
                      errorText: showError ? 'Please enter a valid price' : null,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: iconColor), // التأكد من تحديد اللون بشكل صحيح هنا
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: iconColor, // التأكد من تطبيق اللون بشكل صحيح هنا
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    TextButton(
                      onPressed: () async {
                        double? price = double.tryParse(priceController.text);
                        if (price == null || price <= 0) {
                          setState(() => showError = true);
                          return;
                        }
                        context.read<PriceCubit>().updatePrice(label, price);
                        await SharedPrefsHelper.setDialogShown(label, true);
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: iconColor, // التأكد من تطبيق اللون بشكل صحيح هنا
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  bool _isDefaultItem(String label) {
    return defaultItems.any((item) => item['label'] == label);
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
              if (index < defaultItems.length) {
                final item = defaultItems[index];
                final label = item['label'];
                final icon = item['icon'];
                final price = state.prices[label];
                final bgColor = backgroundColors[index % backgroundColors.length];
                final iconColor = iconColors[index % iconColors.length];

                return _buildListTile(
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

                // تخصيص الألوان للعناصر الجديدة بناءً على القيم المتعرفة
                final bgColor = backgroundColors[(defaultItems.length + index) % backgroundColors.length];
                final iconColor = iconColors[(defaultItems.length + index) % iconColors.length];

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
                  child: _buildListTile(
                    icon: Icons.star,
                    label: label,
                    price: price,
                    context: context,
                    onTap: () => _showModal(context, label, Icons.star),
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

  Widget _buildListTile({
    required IconData icon,
    required String label,
    required double? price,
    required BuildContext context,
    required VoidCallback onTap,
    required bool isDeletable,
    required Color backgroundColor,
    required Color iconColor,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        tileColor: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        leading: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: iconColor),
          ),
          child: Icon(icon, size: 30, color: iconColor),
        ),
        title: Text(label, style: const TextStyle(fontSize: 16)),
        trailing: GestureDetector(
          onTap: onTap,
          child: Container(
            width: 140,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: iconColor),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              price != null ? 'EGP $price/month' : 'Enter Price',
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

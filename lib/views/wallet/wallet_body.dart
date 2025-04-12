import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finyx_mobile_app/cubits/wallet/price_cubit.dart';
import 'package:finyx_mobile_app/cubits/wallet/shared_pref_helper.dart';

class WalletBody extends StatelessWidget {
  WalletBody({super.key});

  final List<Map<String, dynamic>> defaultItems = [
    {'icon': Icons.flash_on, 'label': 'Electricity'},
    {'icon': Icons.wifi, 'label': 'Internet'},
    {'icon': Icons.fastfood_outlined, 'label': 'Food'},
    {'icon': Icons.money, 'label': 'Zakat'},
    {'icon': Icons.shopping_cart, 'label': 'Shopping'},
    {'icon': Icons.local_gas_station, 'label': 'Gas'},
    {'icon': Icons.water_drop, 'label': 'WaterBill'},
  ];

  final List<Color> iconColors = [
    Colors.orange,
    Colors.blue,
    Colors.green,
    Colors.purple,
    Colors.pink,
    Colors.teal,
    Colors.indigo,
  ];

  void _showModal(BuildContext context, String label, IconData icon) async {
    TextEditingController priceController = TextEditingController();
    final cubit = context.read<PriceCubit>();

    double? currentPrice = cubit.state.prices[label];
    if (currentPrice != null) {
      priceController.text = currentPrice.toString();
    }

    int index = defaultItems.indexWhere((item) => item['label'] == label);
    Color iconColor;

    if (index != -1) {
      iconColor = iconColors[index % iconColors.length];
    } else {
      final newItemIndex = cubit.state.prices.keys.toList().indexOf(label);
      iconColor = iconColors[(newItemIndex + defaultItems.length) % iconColors.length];
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocBuilder<PriceCubit, PriceState>(
          builder: (context, state) {
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
                    child: Icon(icon, size: 40, color: iconColor),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: iconColor,
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
                      errorText: state.showError ? 'Please enter a valid price' : null,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: iconColor),
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
                      onPressed: () {
                        // عند إغلاق الحوار نلغي رسالة الخطأ
                        cubit.setShowError(false); 
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancel', style: TextStyle(color: iconColor)),
                    ),
                    const SizedBox(width: 10),
                    TextButton(
                      onPressed: () async {
                        double? price = double.tryParse(priceController.text);
                        if (price == null || price <= 0) {
                          cubit.setShowError(true);  // تفعيل الرسالة عند إدخال قيمة غير صحيحة
                          return;
                        }
                        cubit.updatePrice(label, price);
                        await SharedPrefsHelper.setDialogShown(label, true);
                        Navigator.of(context).pop();  // إغلاق الحوار بعد التصحيح
                      },
                      child: Text('Save', style: TextStyle(color: iconColor)),
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
                final iconColor = iconColors[index % iconColors.length];

                // تحديد الخلفية بناءً على لون الأيقونة مع تخفيفها
                Color bgColor = iconColor.withAlpha(15);

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

                final iconColor =
                    iconColors[(defaultItems.length + index) % iconColors.length];

                // تحديد الخلفية بناءً على لون الأيقونة مع تخفيفها
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
                  },
                  child: _buildListTile(
                    icon: Icons.add,
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

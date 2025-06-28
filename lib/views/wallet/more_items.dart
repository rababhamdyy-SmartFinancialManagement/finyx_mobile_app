import 'package:finyx_mobile_app/models/applocalization.dart';
import 'package:finyx_mobile_app/widgets/wallet/add_dialog.dart';
import 'package:finyx_mobile_app/widgets/wallet/price_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finyx_mobile_app/cubits/wallet/price_cubit.dart';
import 'package:finyx_mobile_app/models/user_type.dart';
import 'package:finyx_mobile_app/helpers/dynamic_translator.dart';

Future<String> translateSmart(
  String key,
  AppLocalizations loc,
  String langCode,
) async {
  if (loc.has(key)) {
    return loc.translate(key);
  } else {
    return await DynamicTranslator.getTranslated(key, langCode);
  }
}

Future<void> moreItems(BuildContext context, UserType userType) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return BlocBuilder<PriceCubit, PriceState>(
        builder: (context, state) {
          return MoreItems(state: state, userType: userType);
        },
      );
    },
  );
}

class MoreItems extends StatelessWidget {
  final PriceState state;
  final UserType userType;

  const MoreItems({super.key, required this.state, required this.userType});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final cubit = context.read<PriceCubit>();
    final loc = AppLocalizations.of(context)!;

    List<Color> iconColors = [
      Colors.orange,
      Colors.blue,
      Colors.green,
      Colors.purple,
      Colors.pink,
      Colors.teal,
      Colors.indigo,
      Colors.grey,
    ];

    List<Map<String, dynamic>> getItems() {
      if (userType == UserType.individual) {
        return [
          {
            'icon': Icons.sports_tennis_rounded,
            'label': 'Club',
            'translationKey': 'club',
          },
          {
            'icon': Icons.phone_iphone,
            'label': 'Mobile Credit',
            'translationKey': 'mobile_credit',
          },
          {'icon': Icons.car_repair, 'label': 'Car', 'translationKey': 'car'},
          {
            'icon': Icons.wallet,
            'label': 'Voucher',
            'translationKey': 'voucher',
          },
          {
            'icon': Icons.medical_services_outlined,
            'label': 'Assurance',
            'translationKey': 'assurance',
          },
          {
            'icon': Icons.movie_filter_outlined,
            'label': 'Cinema',
            'translationKey': 'cinema',
          },
          {
            'icon': Icons.groups_outlined,
            'label': 'Association',
            'translationKey': 'association',
          },
          {
            'icon': Icons.now_widgets_outlined,
            'label': 'More',
            'translationKey': 'more',
          },
        ];
      } else {
        return [
          {
            'icon': Icons.assignment,
            'label': 'Licenses',
            'translationKey': 'licenses',
          },
          {
            'icon': Icons.money_off,
            'label': 'Accrued Interest',
            'translationKey': 'accrued_interest',
          },
          {
            'icon': Icons.account_balance_wallet,
            'label': 'Admin Expenses',
            'translationKey': 'admin_expenses',
          },
          {
            'icon': Icons.flash_on,
            'label': 'Electricity',
            'translationKey': 'electricity',
          },
          {
            'icon': Icons.wifi,
            'label': 'Internet',
            'translationKey': 'internet',
          },
          {
            'icon': Icons.local_shipping,
            'label': 'Shipping',
            'translationKey': 'shipping',
          },
          {
            'icon': Icons.monetization_on,
            'label': 'Zakat',
            'translationKey': 'zakat',
          },
          {
            'icon': Icons.now_widgets_outlined,
            'label': 'More',
            'translationKey': 'more_business',
          },
        ];
      }
    }

    return AlertDialog(
      backgroundColor: theme.dialogTheme.backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Center(
        child: Text(
          loc.translate('add_new_bill'),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: "Poppins",
          ),
        ),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: Wrap(
          spacing: 20.0,
          runSpacing: 20.0,
          alignment: WrapAlignment.center,
          children: List.generate(getItems().length, (index) {
            final item = getItems()[index];
            final color = iconColors[index];
            final icon = item['icon'];
            final translationKey = item['translationKey'];

            return GestureDetector(
              onTap: () async {
                Navigator.of(context).pop();

                if (translationKey == 'more' ||
                    translationKey == 'more_business') {
                  await showDialog(
                    context: context,
                    builder:
                        (_) => AddDialog(
                          nameController: TextEditingController(),
                          priceController: TextEditingController(),
                          cubit: cubit,
                          state: state,
                        ),
                  );
                } else {
                  await showDialog(
                    context: context,
                    builder:
                        (_) => PriceDialog(
                          priceController: TextEditingController(),
                          cubit: cubit,
                          state: state,
                          label: translationKey,
                          icon: icon,
                          iconColor: color,
                        ),
                  );
                }
              },
              child: SizedBox(
                width: 90,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: color.withAlpha(15),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: color, width: 1.5),
                      ),
                      child: Icon(icon, color: color, size: 28),
                    ),
                    const SizedBox(height: 8),
                    FutureBuilder<String>(
                      future: translateSmart(
                        translationKey,
                        loc,
                        loc.locale?.languageCode ?? 'en',
                      ),
                      builder: (context, snapshot) {
                        final translatedLabel = snapshot.data ?? item['label'];
                        return Text(
                          translatedLabel,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins",
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

import 'package:finyx_mobile_app/widgets/wallet/add_dialog.dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finyx_mobile_app/cubits/wallet/price_cubit.dart';

Future<void> showAddItemDialog(BuildContext context) async {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  final cubit = context.read<PriceCubit>();

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return BlocBuilder<PriceCubit, PriceState>(
        builder: (context, state) {
          return AddDialog(
            nameController: nameController,
            priceController: priceController,
            cubit: cubit,
            state: state,
          );
        },
      );
    },
  );
}

import 'package:finyx_mobile_app/cubits/wallet/price_cubit.dart';
import 'package:finyx_mobile_app/models/applocalization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finyx_mobile_app/cubits/profile/profile_cubit.dart';
import 'package:finyx_mobile_app/cubits/profile/profile_state.dart';
import 'package:finyx_mobile_app/cubits/home/chart_cubit.dart';
import 'package:finyx_mobile_app/models/user_type.dart';
import 'package:finyx_mobile_app/views/home/balance_card.dart';
import 'package:finyx_mobile_app/views/home/information_grid.dart';
import 'package:finyx_mobile_app/widgets/homepage/pie_chart_widget.dart';

class HomepageBody extends StatelessWidget {
  final UserType userType;

  const HomepageBody({super.key, required this.userType});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final loc = AppLocalizations.of(context)!;

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: screenWidth * 0.04,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, profileState) {
                final userName =
                    profileState.name.isNotEmpty
                        ? profileState.name
                        : FirebaseAuth.instance.currentUser?.displayName ??
                            '...';

                return Row(
                  children: [
                    Text(
                      "${loc.translate("hello")}",
                      style: TextStyle(
                        fontSize: screenWidth * 0.06,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Rockwell',
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        userName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: screenWidth * 0.06,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Rockwell',
                        ),
                      ),
                    ),
                    // Optional: Spacer or NotificationButton can be here if needed
                  ],
                );
              },
            ),
            SizedBox(height: 4), // ضيف مسافة صغيرة بين السطرين
            Text(
              loc.translate("available_balance"),
              style: TextStyle(
                fontSize: screenWidth * 0.04,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: screenWidth * 0.08),
            const BalanceCard(),
            SizedBox(height: screenWidth * 0.01),
            BlocProvider(
              create:
                  (_) => ChartCubit(
                    userType: userType,
                    priceCubit: context.read<PriceCubit>(),
                  ),
              child: PieChartWidget(userType: userType),
            ),
            SizedBox(height: screenWidth * 0.001),
            Text(
              loc.translate("information_list"),
              style: TextStyle(
                fontSize: screenWidth * 0.05,
                fontWeight: FontWeight.bold,
                fontFamily: 'Righteous',
              ),
            ),
            SizedBox(height: screenWidth * 0.04),
            InformationGrid(userType: userType),
          ],
        ),
      ),
    );
  }
}
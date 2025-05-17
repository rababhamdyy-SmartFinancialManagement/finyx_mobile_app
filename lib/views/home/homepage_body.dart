import 'package:finyx_mobile_app/cubits/home/chart_cubit.dart';
import 'package:finyx_mobile_app/cubits/profile/profile_cubit.dart';
import 'package:finyx_mobile_app/cubits/profile/profile_state.dart';
import 'package:finyx_mobile_app/models/user_type.dart';
import 'package:finyx_mobile_app/views/home/balance_card.dart';
import 'package:finyx_mobile_app/views/home/information_grid.dart';
import 'package:finyx_mobile_app/widgets/homepage/notification_button.dart';
import 'package:finyx_mobile_app/widgets/homepage/pie_chart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomepageBody extends StatelessWidget {
  final UserType userType;

  const HomepageBody({super.key, required this.userType});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: screenWidth * 0.04,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, profileState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello ${profileState.name.isNotEmpty ? profileState.name : 'User'},",
                          style: TextStyle(
                            fontSize: screenWidth * 0.06,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Rockwell',
                          ),
                        ),
                        Text(
                          "Your available balance",
                          style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    );
                  },
                ),
                Spacer(),
                NotificationButton(),
              ],
            ),
            SizedBox(height: screenWidth * 0.08),
            BalanceCard(),
            SizedBox(height: screenWidth * 0.01),
            BlocProvider(
              create: (_) => ChartCubit(userType: userType),
              child: PieChartWidget(userType: userType),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Information List",
                  style: TextStyle(
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Righteous',
                  ),
                ),
              ],
            ),
            SizedBox(height: screenWidth * 0.04),
            InformationGrid(userType: userType),
          ],
        ),
      ),
    );
  }
}
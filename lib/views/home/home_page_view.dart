import 'package:finyx_mobile_app/cubits/bottom%20nav/navigation_cubit.dart';
import 'package:finyx_mobile_app/cubits/bottom%20nav/navigation_state.dart';
import 'package:finyx_mobile_app/cubits/wallet/price_cubit.dart';
import 'package:finyx_mobile_app/models/user_type.dart';
import 'package:finyx_mobile_app/views/home/homepage_body.dart';
import 'package:finyx_mobile_app/views/profile/profile_view.dart';
import 'package:finyx_mobile_app/views/setting/setting_view.dart';
import 'package:finyx_mobile_app/views/wallet/more_items.dart';
import 'package:finyx_mobile_app/views/wallet/wallet_view.dart';
import 'package:finyx_mobile_app/widgets/homepage/custom_bottom_navbar.dart';
import 'package:finyx_mobile_app/widgets/shared/chat_bots_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageView extends StatelessWidget {
  final UserType userType;
  const HomePageView({super.key, required this.userType});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        final currentIndex = state.index;
        // final screenWidth = MediaQuery.of(context).size.width;

        return Scaffold(
          body: IndexedStack(
            index: currentIndex,
            children: [
              HomepageBody(userType: userType),
              WalletScreen(userType: userType),
              ProfileScreen(),
              SettingScreen(),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (currentIndex == 1) {
                moreItems(context, userType);
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return BlocBuilder<PriceCubit, PriceState>(
                      builder: (context, state) {
                        return ChatDialog(
                          onPressed: () => Navigator.pop(context),
                          userType: userType,
                        );
                      },
                    );
                  },
                );
              }
            },
            backgroundColor: Colors.yellow[700],
            shape: const CircleBorder(),
            child: Padding(
              padding: EdgeInsets.all(
                MediaQuery.of(context).size.width * 0.025,
              ),
              child: Image.asset(
                currentIndex == 1
                    ? 'assets/images/wallet/plus.png'
                    : 'assets/images/home/chatAI.png',
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: const CustomBottomNavbar(),
        );
      },
    );
  }
}

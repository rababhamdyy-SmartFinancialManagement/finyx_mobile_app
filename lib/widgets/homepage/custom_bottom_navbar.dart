import 'package:finyx_mobile_app/cubits/bottom%20nav/navigation_cubit.dart';
// import 'package:finyx_mobile_app/models/user_type.dart';
// import 'package:finyx_mobile_app/views/home/home_page_view.dart';
// import 'package:finyx_mobile_app/views/profile/profile_view.dart';
// import 'package:finyx_mobile_app/views/setting/setting_view.dart';
// import 'package:finyx_mobile_app/views/wallet/wallet_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomBottomNavbar extends StatelessWidget {
  const CustomBottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<NavigationCubit>();
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBody: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action for chat or other functionality
        },
        backgroundColor: Colors.yellow[700],
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(
            cubit.currentIndex == 4 ? Colors.yellowAccent : Colors.white!,
            BlendMode.srcIn,
          ),
          child: Image.asset('assets/images/home/chatAI.png'),
        ),
        elevation: 8,
        shape: CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFF261863),
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        elevation: 10,
        child: SizedBox(
          height: screenHeight * 0.08,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.home,
                    color:
                        cubit.currentIndex == 0
                            ? Color(0xFFDA9220)
                            : Colors.grey[300]!,
                  ),
                  onPressed: () => cubit.changeTab(0),
                ),
                IconButton(
                  icon: Icon(
                    Icons.wallet_rounded,
                    color:
                        cubit.currentIndex == 1
                            ? Color(0xFFDA9220)
                            : Colors.grey[300]!,
                  ),
                
                  onPressed: () => cubit.changeTab(1),
                ),

                const SizedBox(width: 40),

                IconButton(
                  icon: Icon(
                    Icons.person,
                    color:
                        cubit.currentIndex == 2
                            ? Color(0xFFDA9220)
                            : Colors.grey[300]!,
                  ),
                  onPressed: () => cubit.changeTab(2),
                ),
                IconButton(
                  icon: Icon(
                    Icons.settings,
                    color:
                        cubit.currentIndex == 3
                            ? Color(0xFFDA9220)
                            : Colors.grey[300]!,
                  ),
                  onPressed: () => cubit.changeTab(3),
                ),
              ],
            ),
          ),
        ),
      ),
      //change the index of the screen based on the currentIndex
    );
  }
}

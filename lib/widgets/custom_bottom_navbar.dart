import 'package:finyx_mobile_app/models/user_type.dart';
import 'package:finyx_mobile_app/views/homePage_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/navigation_cubit.dart';
import '../views/profile_view.dart';
import '../views/setting_view.dart';
import '../views/wallet_view.dart';

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
        child:  ColorFiltered(
          colorFilter: ColorFilter.mode(
            cubit.currentIndex == 4 ? Colors.yellowAccent : Colors.white!, 
            BlendMode.srcIn
          ),
          child: Image.asset('assets/images/chatAI.png'),
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
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.home, color: cubit.currentIndex == 0 ? Colors.yellowAccent : Colors.grey[300]!),
                    onPressed: () => cubit.changeTab(0),
                  ),
                  IconButton(
                    icon: Icon(Icons.settings, color: cubit.currentIndex == 1 ? Colors.yellowAccent : Colors.grey[300]!),
                    onPressed: () => cubit.changeTab(1),
                  ),
                  const SizedBox(width: 40),
                  IconButton(
                    icon: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        cubit.currentIndex == 2 ? Colors.yellowAccent : Colors.grey[300]!, 
                        BlendMode.srcIn
                      ),
                      child: Image.asset('assets/images/wallet.png'),
                    ),
                    onPressed: () => cubit.changeTab(2),
                  ),
                  IconButton(
                    icon: Icon(Icons.person, color: cubit.currentIndex == 3 ? Colors.yellowAccent : Colors.grey[300]!),
                    onPressed: () => cubit.changeTab(3),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      //change the index of the screen based on the currentIndex
      body: IndexedStack(
        index: cubit.currentIndex,  
        children: const [
          HomepageView(userType: UserType.individual,), 
          SettingsScreen(), 
          WalletScreen(),  
          ProfileScreen(), 
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finyx_mobile_app/cubits/bottom nav/navigation_cubit.dart';
// import 'package:finyx_mobile_app/cubits/bottom nav/navigation_state.dart';

class CustomBottomNavbar extends StatelessWidget {
  const CustomBottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final iconSize = screenWidth * 0.065;

    final currentIndex = context.watch<NavigationCubit>().state.index;

    return BottomAppBar(
      color: const Color(0xFF3E0555),

      shape: const CircularNotchedRectangle(),
      notchMargin: screenWidth * 0.02,
      elevation: 10,
      child: SizedBox(
        height: screenHeight * 0.085,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              iconSize: iconSize,
              icon: Icon(
                Icons.home,
                color:
                    currentIndex == 0
                        ? const Color(0xFFDA9220)
                        : Colors.grey[300],
              ),
              onPressed: () => context.read<NavigationCubit>().changeTab(0),
            ),
            IconButton(
              iconSize: iconSize,
              icon: Icon(
                Icons.wallet_rounded,
                color:
                    currentIndex == 1
                        ? const Color(0xFFDA9220)
                        : Colors.grey[300],
              ),
              onPressed: () => context.read<NavigationCubit>().changeTab(1),
            ),
            SizedBox(width: screenWidth * 0.1),
            IconButton(
              iconSize: iconSize,
              icon: Icon(
                Icons.person,
                color:
                    currentIndex == 2
                        ? const Color(0xFFDA9220)
                        : Colors.grey[300],
              ),
              onPressed: () => context.read<NavigationCubit>().changeTab(2),
            ),
            IconButton(
              iconSize: iconSize,
              icon: Icon(
                Icons.settings,
                color:
                    currentIndex == 3
                        ? const Color(0xFFDA9220)
                        : Colors.grey[300],
              ),
              onPressed: () => context.read<NavigationCubit>().changeTab(3),
            ),
          ],
        ),
      ),
    );
  }
}

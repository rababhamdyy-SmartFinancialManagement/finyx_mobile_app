import 'package:finyx_mobile_app/cubits/profile/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finyx_mobile_app/cubits/profile/profile_cubit.dart';

class BalanceCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final cardWidth = screenWidth * 0.98;
    final cardHeight = screenHeight * 0.16;

    return Center(
      child: SizedBox(
        width: cardWidth,
        height: cardHeight,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04,
            vertical: screenHeight * 0.015,
          ),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF261863), Color(0xFF742388)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "2.70% Today",
                          style: TextStyle(
                            color: Colors.pinkAccent,
                            fontSize: 12,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        SizedBox(height: 6),
                        BlocBuilder<ProfileCubit, ProfileState>(
                          builder: (context, profileState) {
                            final salary = profileState.salary.isNotEmpty
                                ? profileState.salary
                                : "\$0.00";
                            return Text(
                              "\$$salary",  
                              style: TextStyle(
                                fontSize: 26,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.2),
                ],
              ),
              Positioned(
                right: -screenWidth * 0.1,
                top: -screenHeight * 0.08,
                child: Image.asset(
                  'assets/images/home/money.png',
                  width: screenWidth * 0.38,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
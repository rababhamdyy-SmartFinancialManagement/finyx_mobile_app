import 'package:finyx_mobile_app/cubits/home/chart_cubit.dart';
import 'package:finyx_mobile_app/models/user_type.dart';
import 'package:finyx_mobile_app/widgets/homepage/custom_bottom_navbar.dart';
import 'package:finyx_mobile_app/widgets/homepage/pie_chart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomepageView extends StatefulWidget {
  final UserType userType;
  const HomepageView({super.key, required this.userType});

  @override
  State<HomepageView> createState() => _HomepageViewe();
}

class _HomepageViewe extends State<HomepageView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 700),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final chartSize = screenWidth * 0.6;

    return BlocProvider(
      create: (_) => ChartCubit(userType: widget.userType),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  // Action when notification icon is tapped
                },
              ),
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(
                  'assets/images/profile.jpg',
                ), // Replace with your image asset
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello Yennefer Doe,",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: screenWidth * 0.02),
                  Text(
                    "Your available balance",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  SizedBox(height: screenWidth * 0.04),

                  _buildBalanceCard(),
                  SizedBox(height: screenWidth * 0.06),

                  PieChartWidget(
                    chartSize: chartSize,
                    userType: widget.userType,
                  ),
                  SizedBox(height: screenWidth * 0.02),

                  Center(
                    child: Text(
                      "₹1800.00\nAvailable Budget",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.06),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Information List",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("View", style: TextStyle(color: Colors.deepPurple)),
                    ],
                  ),
                  SizedBox(height: screenWidth * 0.04),

                  _buildInformationGrid(widget.userType),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: CustomBottomNavbar(),
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepPurple.shade300, Colors.deepPurple.shade700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "2.70% Today",
            style: TextStyle(color: Colors.pinkAccent, fontSize: 12),
          ),
          SizedBox(height: 8),
          Text(
            "\$15,670.90",
            style: TextStyle(
              fontSize: 28,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              // Action for the button (e.g., navigate or analyze)
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.arrow_forward, color: Colors.white),
                SizedBox(width: 8),
                Text("Analyze Data", style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInformationGrid(UserType userType) {
    List<Map<String, dynamic>> items =
        userType == UserType.individual
            ? [
              {'icon': Icons.flash_on, 'label': 'Electricity'},
              {'icon': Icons.wifi, 'label': 'Internet'},
              {'icon': Icons.fastfood, 'label': 'Food'},
              {'icon': Icons.money, 'label': 'Zakat'},
              {'icon': Icons.shopping_cart, 'label': 'Shopping'},
              {'icon': Icons.local_gas_station, 'label': 'Gas'},
              {'icon': Icons.water_drop, 'label': 'WaterBill'},
              {'icon': Icons.more_horiz, 'label': 'More'},
            ]
            : [
              {'icon': Icons.bar_chart, 'label': 'Total Revenue'},
              {'icon': Icons.stacked_line_chart, 'label': 'Total Expenses'},
              {'icon': Icons.trending_up, 'label': 'Profits'},
              {'icon': Icons.trending_down, 'label': 'Losses'},
              {'icon': Icons.send, 'label': 'Transfer money'},
              {'icon': Icons.attach_money, 'label': 'Employee salaries'},
              {'icon': Icons.account_balance_wallet, 'label': 'Loan'},
              {'icon': Icons.more_horiz, 'label': 'More'},
            ];

    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      childAspectRatio: 0.8,
      children:
          items
              .map(
                (item) => _buildIconText(
                  item['icon'] as IconData,
                  item['label'] as String,
                ),
              )
              .toList(),
    );
  }

  Widget _buildIconText(IconData icon, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.grey[200],
          child: Icon(icon, color: Colors.deepPurple),
        ),
        SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }
}

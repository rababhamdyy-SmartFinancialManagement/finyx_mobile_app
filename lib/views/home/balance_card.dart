import 'package:flutter/material.dart';

class BalanceCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          Text("2.70% Today", style: TextStyle(color: Colors.pinkAccent, fontSize: 12)),
          SizedBox(height: 8),
          Text("\$15,670.90", style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold)),
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
}

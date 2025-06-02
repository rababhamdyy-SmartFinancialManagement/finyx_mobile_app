import 'package:finyx_mobile_app/cubits/wallet/price_cubit.dart';
import 'package:finyx_mobile_app/models/chatBot/financial_tips.dart';
import 'package:finyx_mobile_app/models/user_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatDialog extends StatefulWidget {
  final VoidCallback onPressed;
  final UserType userType;

  const ChatDialog({
    super.key,
    required this.onPressed,
    required this.userType,
  });

  @override
  State<ChatDialog> createState() => _ChatDialogState();
}

class _ChatDialogState extends State<ChatDialog> {
  int? _selectedOption;
  final List<String> _options = [
    "Calculate Zakat",
    "Savings Plan",
    "Expense Analysis",
    "Financial Tips",
  ];
  String _chatContent = "Welcome! How can I help you today?";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[900] : Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Financial Assistant",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Color(0xFF3E0555),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, 
                      color: isDarkMode ? Colors.white : Color(0xFF3E0555)),
                  onPressed: widget.onPressed,
                ),
              ],
            ),

            Divider(height: 20, color: isDarkMode ? Colors.grey[700] : null),

            // Chat Content Area
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Bot Message
                      _buildChatBubble(
                        isUser: false, 
                        message: _chatContent,
                        isDarkMode: isDarkMode,
                      ),

                      const SizedBox(height: 12),

                      // Show options if nothing selected
                      if (_selectedOption == null)
                        ..._options.map(
                          (option) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: _buildOptionButton(option, isDarkMode),
                          ),
                        ),

                      // Show analysis content if option selected
                      if (_selectedOption != null) _buildAnalysisContent(isDarkMode),
                    ],
                  ),
                ),
              ),
            ),

            // Back button when in analysis view
            if (_selectedOption != null)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedOption = null;
                      _chatContent = "What else can I help you with?";
                    });
                  },
                  child: Text(
                    "Back to Menu",
                    style: TextStyle(
                      fontSize: 16, 
                      fontFamily: "Poppins",
                      color: isDarkMode ? Colors.white : Color(0xFF3E0555),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionButton(String option, bool isDarkMode) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isDarkMode ? Colors.grey[800] : Colors.grey[200],
        foregroundColor: isDarkMode ? Colors.white : Color(0xFF3E0555),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
        textStyle: TextStyle(fontSize: 16, fontFamily: "Poppins"),
      ),
      onPressed: () {
        setState(() {
          _selectedOption = _options.indexOf(option);
          _chatContent = "You selected: $option";
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(option, style: TextStyle(fontSize: 16, fontFamily: "Poppins")),
          Icon(Icons.chevron_right, size: 20),
        ],
      ),
    );
  }

  Widget _buildAnalysisContent(bool isDarkMode) {
    if (_selectedOption == null) return const SizedBox();

    final cubit = context.read<PriceCubit>();
    final expenses = cubit.state.prices;

    switch (_selectedOption) {
      case 0: // Zakat
        return _buildZakatContent(expenses, isDarkMode);
      case 1: // Savings
        return _buildSavingsContent(expenses, isDarkMode);
      case 2: // Expenses
        return _buildExpensesContent(expenses, isDarkMode);
      case 3: // Tips
        return _buildTipsContent(isDarkMode);
      default:
        return Text(
          "Select an option",
          style: TextStyle(
            fontSize: 16, 
            fontFamily: "Poppins",
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        );
    }
  }

  Widget _buildChatBubble({
    required bool isUser, 
    required String message,
    required bool isDarkMode,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      margin: EdgeInsets.only(
        right: isUser ? 0 : 40,
        left: isUser ? 40 : 0,
        bottom: 12,
      ),
      decoration: BoxDecoration(
        color: isUser 
          ? isDarkMode ? Colors.blue[900] : Colors.blue[50]
          : isDarkMode ? Colors.grey[800] : Colors.grey[200],
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(16),
          topRight: const Radius.circular(16),
          bottomLeft: isUser ? const Radius.circular(16) : Radius.zero,
          bottomRight: isUser ? Radius.zero : const Radius.circular(16),
        ),
      ),
      child: Text(
        message,
        style: TextStyle(
          fontSize: 16,
          fontFamily: "Poppins",
          color: isUser 
            ? isDarkMode ? Colors.white : Color(0xFF3E0555)
            : isDarkMode ? Colors.white : Colors.grey[900],
        ),
      ),
    );
  }

  Widget _buildZakatContent(Map<String, double> expenses, bool isDarkMode) {
    double total = expenses.values.fold(0.0, (sum, e) => sum + e);
    double zakat = total * 0.025;

    return Column(
      children: [
        _buildChatBubble(
          isUser: false,
          message: "Here's your Zakat calculation:",
          isDarkMode: isDarkMode,
        ),
        _buildChatBubble(
          isUser: false,
          message: "Total Assets: ${total.toStringAsFixed(2)} EGP",
          isDarkMode: isDarkMode,
        ),
        _buildChatBubble(
          isUser: false,
          message: "Zakat Due (2.5%): ${zakat.toStringAsFixed(2)} EGP",
          isDarkMode: isDarkMode,
        ),
        _buildChatBubble(
          isUser: false,
          message: total >= 1000
              ? "✅ You meet the Nisab threshold"
              : "⚠️ Below Nisab (1000 EGP)",
          isDarkMode: isDarkMode,
        ),
      ],
    );
  }

  Widget _buildSavingsContent(Map<String, double> expenses, bool isDarkMode) {
    double total = expenses.values.fold(0.0, (sum, e) => sum + e);
    double savings = total * 0.2;

    return Column(
      children: [
        _buildChatBubble(
          isUser: false, 
          message: "Recommended savings plan:",
          isDarkMode: isDarkMode,
        ),
        _buildChatBubble(
          isUser: false,
          message: "Monthly Expenses: ${total.toStringAsFixed(2)} EGP",
          isDarkMode: isDarkMode,
        ),
        _buildChatBubble(
          isUser: false,
          message: "Suggested Savings (20%): ${savings.toStringAsFixed(2)} EGP",
          isDarkMode: isDarkMode,
        ),
        _buildChatBubble(
          isUser: false,
          message: "💡 Tip: ${FinancialTips.generalTips[0]}",
          isDarkMode: isDarkMode,
        ),
      ],
    );
  }

  Widget _buildExpensesContent(Map<String, double> expenses, bool isDarkMode) {
    if (expenses.isEmpty) {
      return _buildChatBubble(
        isUser: false,
        message: "No expenses recorded yet. Start adding expenses to see analysis.",
        isDarkMode: isDarkMode,
      );
    }

    double total = expenses.values.fold(0.0, (sum, e) => sum + e);
    var sorted =
        expenses.entries.toList()..sort((a, b) => b.value.compareTo(a.value));

    // حساب متوسط المصروفات لكل فئة
    double average = total / expenses.length;

    // تحديد الفئات التي تجاوزت المتوسط
    var exceededCategories = sorted.where((e) => e.value > average).toList();

    return Column(
      children: [
        _buildChatBubble(
          isUser: false,
          message: "📊 Your Detailed Spending Analysis:",
          isDarkMode: isDarkMode,
        ),
        _buildChatBubble(
          isUser: false,
          message: "Total Expenses: ${total.toStringAsFixed(2)} EGP",
          isDarkMode: isDarkMode,
        ),
        _buildChatBubble(
          isUser: false,
          message: "Average per Category: ${average.toStringAsFixed(2)} EGP",
          isDarkMode: isDarkMode,
        ),

        // تحذير إذا تجاوز المصروفات حد معين
        if (total > 5000)
          _buildChatBubble(
            isUser: false,
            message: "⚠️ Warning: Your expenses have exceeded the recommended budget!",
            isDarkMode: isDarkMode,
          ),

        // عرض أهم 3 فئات تصرفًا
        _buildChatBubble(
          isUser: false, 
          message: "Top Spending Categories:",
          isDarkMode: isDarkMode,
        ),
        ...sorted.take(3).map((e) {
          double percent = (e.value / total) * 100;
          return Column(
            children: [
              _buildChatBubble(
                isUser: false,
                message: "${e.key}: ${e.value.toStringAsFixed(2)} EGP (${percent.toStringAsFixed(1)}%)",
                isDarkMode: isDarkMode,
              ),
              if (FinancialTips.categoryTips.containsKey(e.key.toLowerCase()))
                ...FinancialTips.categoryTips[e.key.toLowerCase()]!
                    .take(2)
                    .map(
                      (tip) => _buildChatBubble(
                        isUser: false, 
                        message: "💡 $tip",
                        isDarkMode: isDarkMode,
                      ),
                    ),
            ],
          );
        }),

        // عرض الفئات التي تجاوزت المتوسط
        if (exceededCategories.isNotEmpty)
          _buildChatBubble(
            isUser: false,
            message: "Categories exceeding average:",
            isDarkMode: isDarkMode,
          ),
        ...exceededCategories.take(3).map((e) {
          return _buildChatBubble(
            isUser: false,
            message: "⚠️ ${e.key} (${e.value.toStringAsFixed(2)} EGP)",
            isDarkMode: isDarkMode,
          );
        }),

        // نصائح عامة للتوفير
        _buildChatBubble(
          isUser: false, 
          message: "💎 General Savings Tips:",
          isDarkMode: isDarkMode,
        ),
        ...FinancialTips.generalTips
            .take(3)
            .map((tip) => _buildChatBubble(
                  isUser: false, 
                  message: "✨ $tip",
                  isDarkMode: isDarkMode,
                )),
      ],
    );
  }

  Widget _buildTipsContent(bool isDarkMode) {
    return Column(
      children: [
        _buildChatBubble(
          isUser: false,
          message: "Here are some financial tips:",
          isDarkMode: isDarkMode,
        ),
        ...FinancialTips.generalTips
            .take(3)
            .map((tip) => _buildChatBubble(
                  isUser: false, 
                  message: "💡 $tip",
                  isDarkMode: isDarkMode,
                )),
      ],
    );
  }
}
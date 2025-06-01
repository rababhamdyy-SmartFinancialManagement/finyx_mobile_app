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
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Financial Assistant",
                  style: TextStyle(
                    fontSize: 20, // تم الاحتفاظ بحجم 20 للعنوان الرئيسي
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3E0555),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Color(0xFF3E0555)),
                  onPressed: widget.onPressed,
                ),
              ],
            ),

            const Divider(height: 20),

            // Chat Content Area
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Bot Message
                      _buildChatBubble(isUser: false, message: _chatContent),

                      const SizedBox(height: 12),

                      // Show options if nothing selected
                      if (_selectedOption == null)
                        ..._options.map(
                          (option) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: _buildOptionButton(option),
                          ),
                        ),

                      // Show analysis content if option selected
                      if (_selectedOption != null) _buildAnalysisContent(),
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
                  child: const Text(
                    "Back to Menu",
                    style: TextStyle(fontSize: 16, fontFamily: "Poppins"),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionButton(String option) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[200],
        foregroundColor: Color(0xFF3E0555),
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
          const Icon(Icons.chevron_right, size: 20),
        ],
      ),
    );
  }

  Widget _buildAnalysisContent() {
    if (_selectedOption == null) return const SizedBox();

    final cubit = context.read<PriceCubit>();
    final expenses = cubit.state.prices;

    switch (_selectedOption) {
      case 0: // Zakat
        return _buildZakatContent(expenses);
      case 1: // Savings
        return _buildSavingsContent(expenses);
      case 2: // Expenses
        return _buildExpensesContent(expenses);
      case 3: // Tips
        return _buildTipsContent();
      default:
        return const Text(
          "Select an option",
          style: TextStyle(fontSize: 16, fontFamily: "Poppins"),
        );
    }
  }

  Widget _buildChatBubble({required bool isUser, required String message}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      margin: EdgeInsets.only(
        right: isUser ? 0 : 40,
        left: isUser ? 40 : 0,
        bottom: 12,
      ),
      decoration: BoxDecoration(
        color: isUser ? Colors.blue[50] : Colors.grey[200],
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
          fontSize: 16, // تم تغيير حجم الخط من 15 إلى 16
          fontFamily: "Poppins",
          color: isUser ? Color(0xFF3E0555) : Colors.grey[900],
        ),
      ),
    );
  }

  Widget _buildZakatContent(Map<String, double> expenses) {
    double total = expenses.values.fold(0.0, (sum, e) => sum + e);
    double zakat = total * 0.025;

    return Column(
      children: [
        _buildChatBubble(
          isUser: false,
          message: "Here's your Zakat calculation:",
        ),
        _buildChatBubble(
          isUser: false,
          message: "Total Assets: ${total.toStringAsFixed(2)} EGP",
        ),
        _buildChatBubble(
          isUser: false,
          message: "Zakat Due (2.5%): ${zakat.toStringAsFixed(2)} EGP",
        ),
        _buildChatBubble(
          isUser: false,
          message:
              total >= 1000
                  ? "✅ You meet the Nisab threshold"
                  : "⚠️ Below Nisab (1000 EGP)",
        ),
      ],
    );
  }

  Widget _buildSavingsContent(Map<String, double> expenses) {
    double total = expenses.values.fold(0.0, (sum, e) => sum + e);
    double savings = total * 0.2;

    return Column(
      children: [
        _buildChatBubble(isUser: false, message: "Recommended savings plan:"),
        _buildChatBubble(
          isUser: false,
          message: "Monthly Expenses: ${total.toStringAsFixed(2)} EGP",
        ),
        _buildChatBubble(
          isUser: false,
          message: "Suggested Savings (20%): ${savings.toStringAsFixed(2)} EGP",
        ),
        _buildChatBubble(
          isUser: false,
          message: "💡 Tip: ${FinancialTips.generalTips[0]}",
        ),
      ],
    );
  }

  Widget _buildExpensesContent(Map<String, double> expenses) {
    if (expenses.isEmpty) {
      return _buildChatBubble(
        isUser: false,
        message:
            "No expenses recorded yet. Start adding expenses to see analysis.",
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
        ),
        _buildChatBubble(
          isUser: false,
          message: "Total Expenses: ${total.toStringAsFixed(2)} EGP",
        ),
        _buildChatBubble(
          isUser: false,
          message: "Average per Category: ${average.toStringAsFixed(2)} EGP",
        ),

        // تحذير إذا تجاوز المصروفات حد معين (يمكن تعديل القيمة حسب احتياجاتك)
        if (total > 5000) // مثال: إذا تجاوزت المصروفات 5000 جنيه
          _buildChatBubble(
            isUser: false,
            message:
                "⚠️ Warning: Your expenses have exceeded the recommended budget!",
          ),

        // عرض أهم 3 فئات تصرفًا
        _buildChatBubble(isUser: false, message: "Top Spending Categories:"),
        ...sorted.take(3).map((e) {
          double percent = (e.value / total) * 100;
          return Column(
            children: [
              _buildChatBubble(
                isUser: false,
                message:
                    "${e.key}: ${e.value.toStringAsFixed(2)} EGP (${percent.toStringAsFixed(1)}%)",
              ),
              // إضافة نصائح توفير خاصة بكل فئة
              if (FinancialTips.categoryTips.containsKey(e.key.toLowerCase()))
                ...FinancialTips.categoryTips[e.key.toLowerCase()]!
                    .take(2)
                    .map(
                      (tip) =>
                          _buildChatBubble(isUser: false, message: "💡 $tip"),
                    ),
            ],
          );
        }),

        // عرض الفئات التي تجاوزت المتوسط
        if (exceededCategories.isNotEmpty)
          _buildChatBubble(
            isUser: false,
            message: "Categories exceeding average:",
          ),
        ...exceededCategories.take(3).map((e) {
          return _buildChatBubble(
            isUser: false,
            message: "⚠️ ${e.key} (${e.value.toStringAsFixed(2)} EGP)",
          );
        }),

        // نصائح عامة للتوفير
        _buildChatBubble(isUser: false, message: "💎 General Savings Tips:"),
        ...FinancialTips.generalTips
            .take(3)
            .map((tip) => _buildChatBubble(isUser: false, message: "✨ $tip")),
      ],
    );
  }

  Widget _buildTipsContent() {
    return Column(
      children: [
        _buildChatBubble(
          isUser: false,
          message: "Here are some financial tips:",
        ),
        ...FinancialTips.generalTips
            .take(3)
            .map((tip) => _buildChatBubble(isUser: false, message: "💡 $tip")),
      ],
    );
  }
}

import 'package:finyx_mobile_app/models/applocalization.dart';
import 'package:finyx_mobile_app/cubits/wallet/price_cubit.dart';
import 'package:finyx_mobile_app/models/chatBot/financial_tips.dart';
import 'package:finyx_mobile_app/models/user_type.dart';
import 'package:finyx_mobile_app/views/wallet/more_items.dart';
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
  String _chatContent = "";
  late AppLocalizations loc;
  late String langCode;
  List<String> translatedOptions = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loc = AppLocalizations.of(context)!;
    langCode = Localizations.localeOf(context).languageCode;
    _initTranslations();
  }

  Future<void> _initTranslations() async {
    final welcome = await translateSmart(
      "Welcome! How can I help you today?",
      loc,
      langCode,
    );
    final options = await Future.wait(
      _options.map((e) => translateSmart(e, loc, langCode)),
    );
    setState(() {
      _chatContent = welcome;
      translatedOptions = options;
    });
  }

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FutureBuilder<String>(
                  future: translateSmart("Financial Assistant", loc, langCode),
                  builder:
                      (context, snapshot) => Text(
                        snapshot.data ?? "Financial Assistant",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold,
                          color:
                              isDarkMode
                                  ? Colors.white
                                  : const Color(0xFF3E0555),
                        ),
                      ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.close,
                    color: isDarkMode ? Colors.white : const Color(0xFF3E0555),
                  ),
                  onPressed: widget.onPressed,
                ),
              ],
            ),
            Divider(height: 20, color: isDarkMode ? Colors.grey[700] : null),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildChatBubble(
                        isUser: false,
                        message: _chatContent,
                        isDarkMode: isDarkMode,
                      ),
                      const SizedBox(height: 12),
                      if (_selectedOption == null &&
                          translatedOptions.isNotEmpty)
                        ...translatedOptions.asMap().entries.map(
                          (entry) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: _buildOptionButton(
                              entry.key,
                              entry.value,
                              isDarkMode,
                            ),
                          ),
                        ),
                      if (_selectedOption != null)
                        _buildAnalysisContent(isDarkMode),
                    ],
                  ),
                ),
              ),
            ),
            if (_selectedOption != null)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: TextButton(
                  onPressed: () async {
                    final text = await translateSmart(
                      "What else can I help you with?",
                      loc,
                      langCode,
                    );
                    setState(() {
                      _selectedOption = null;
                      _chatContent = text;
                    });
                  },
                  child: FutureBuilder<String>(
                    future: translateSmart("Back to Menu", loc, langCode),
                    builder:
                        (context, snapshot) => Text(
                          snapshot.data ?? "Back to Menu",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Poppins",
                            color:
                                isDarkMode
                                    ? Colors.white
                                    : const Color(0xFF3E0555),
                          ),
                        ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionButton(int index, String text, bool isDarkMode) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isDarkMode ? Colors.grey[800] : Colors.grey[200],
        foregroundColor: isDarkMode ? Colors.white : const Color(0xFF3E0555),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
        textStyle: const TextStyle(fontSize: 16, fontFamily: "Poppins"),
      ),
      onPressed: () {
        setState(() {
          _selectedOption = index;
          _chatContent = "";
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(fontSize: 16, fontFamily: "Poppins"),
          ),
          const Icon(Icons.chevron_right, size: 20),
        ],
      ),
    );
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
        color:
            isUser
                ? isDarkMode
                    ? Colors.blue[900]
                    : Colors.blue[50]
                : isDarkMode
                ? Colors.grey[800]
                : Colors.grey[200],
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
          color:
              isUser
                  ? isDarkMode
                      ? Colors.white
                      : const Color(0xFF3E0555)
                  : isDarkMode
                  ? Colors.white
                  : Colors.grey[900],
        ),
      ),
    );
  }

  Widget _buildAnalysisContent(bool isDarkMode) {
    final cubit = context.read<PriceCubit>();
    final expenses = cubit.state.prices;

    switch (_selectedOption) {
      case 0:
        return _buildZakatContent(expenses, isDarkMode);
      case 1:
        return _buildSavingsContent(expenses, isDarkMode);
      case 2:
        return _buildExpensesContent(expenses, isDarkMode);
      case 3:
        return _buildTipsContent(isDarkMode);
      default:
        return Container();
    }
  }

  Widget _buildZakatContent(Map<String, double> expenses, bool isDarkMode) {
    double total = expenses.values.fold(0.0, (sum, e) => sum + e);
    double zakat = total * 0.025;

    return FutureBuilder<List<String>>(
      future: Future.wait([
        translateSmart("Here's your Zakat calculation:", loc, langCode),
        translateSmart("Total Assets: ", loc, langCode),
        translateSmart("Zakat Due (2.5%): ", loc, langCode),
        translateSmart(
          total >= 1000
              ? "✅ You meet the Nisab threshold"
              : "⚠️ Below Nisab (1000 EGP)",
          loc,
          langCode,
        ),
      ]),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox();
        final data = snapshot.data!;
        return Column(
          children: [
            _buildChatBubble(
              isUser: false,
              message: data[0],
              isDarkMode: isDarkMode,
            ),
            _buildChatBubble(
              isUser: false,
              message: "${data[1]}${total.toStringAsFixed(2)} EGP",
              isDarkMode: isDarkMode,
            ),
            _buildChatBubble(
              isUser: false,
              message: "${data[2]}${zakat.toStringAsFixed(2)} EGP",
              isDarkMode: isDarkMode,
            ),
            _buildChatBubble(
              isUser: false,
              message: data[3],
              isDarkMode: isDarkMode,
            ),
          ],
        );
      },
    );
  }

  Widget _buildSavingsContent(Map<String, double> expenses, bool isDarkMode) {
    double total = expenses.values.fold(0.0, (sum, e) => sum + e);
    double savings = total * 0.2;

    return FutureBuilder<List<String>>(
      future: Future.wait([
        translateSmart("Recommended savings plan:", loc, langCode),
        translateSmart("Monthly Expenses: ", loc, langCode),
        translateSmart("Suggested Savings (20%): ", loc, langCode),
        translateSmart("💡 Tip: ", loc, langCode),
        translateSmart(FinancialTips.generalTips[0], loc, langCode),
      ]),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox();
        final data = snapshot.data!;
        return Column(
          children: [
            _buildChatBubble(
              isUser: false,
              message: data[0],
              isDarkMode: isDarkMode,
            ),
            _buildChatBubble(
              isUser: false,
              message: "${data[1]}${total.toStringAsFixed(2)} EGP",
              isDarkMode: isDarkMode,
            ),
            _buildChatBubble(
              isUser: false,
              message: "${data[2]}${savings.toStringAsFixed(2)} EGP",
              isDarkMode: isDarkMode,
            ),
            _buildChatBubble(
              isUser: false,
              message: "${data[3]}${data[4]}",
              isDarkMode: isDarkMode,
            ),
          ],
        );
      },
    );
  }

  Widget _buildExpensesContent(Map<String, double> expenses, bool isDarkMode) {
    if (expenses.isEmpty) {
      return FutureBuilder<String>(
        future: translateSmart(
          "No expenses recorded yet. Start adding expenses to see analysis.",
          loc,
          langCode,
        ),
        builder:
            (context, snapshot) =>
                snapshot.hasData
                    ? _buildChatBubble(
                      isUser: false,
                      message: snapshot.data!,
                      isDarkMode: isDarkMode,
                    )
                    : const SizedBox(),
      );
    }

    double total = expenses.values.fold(0.0, (sum, e) => sum + e);
    var sorted =
        expenses.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    double average = total / expenses.length;
    var exceededCategories = sorted.where((e) => e.value > average).toList();

    return FutureBuilder<List<String>>(
      future: Future.wait([
        translateSmart("📊 Your Detailed Spending Analysis:", loc, langCode),
        translateSmart("Total Expenses: ", loc, langCode),
        translateSmart("Average per Category: ", loc, langCode),
        translateSmart(
          "⚠️ Warning: Your expenses have exceeded the recommended budget!",
          loc,
          langCode,
        ),
        translateSmart("Top Spending Categories:", loc, langCode),
        translateSmart("Categories exceeding average:", loc, langCode),
        translateSmart("💎 General Savings Tips:", loc, langCode),
      ]),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox();
        final data = snapshot.data!;
        return Column(
          children: [
            _buildChatBubble(
              isUser: false,
              message: data[0],
              isDarkMode: isDarkMode,
            ),
            _buildChatBubble(
              isUser: false,
              message: "${data[1]}${total.toStringAsFixed(2)} EGP",
              isDarkMode: isDarkMode,
            ),
            _buildChatBubble(
              isUser: false,
              message: "${data[2]}${average.toStringAsFixed(2)} EGP",
              isDarkMode: isDarkMode,
            ),
            if (total > 5000)
              _buildChatBubble(
                isUser: false,
                message: data[3],
                isDarkMode: isDarkMode,
              ),
            _buildChatBubble(
              isUser: false,
              message: data[4],
              isDarkMode: isDarkMode,
            ),
            ...sorted.take(3).map((e) {
              double percent = (e.value / total) * 100;
              return Column(
                children: [
                  _buildChatBubble(
                    isUser: false,
                    message:
                        "${e.key}: ${e.value.toStringAsFixed(2)} EGP (${percent.toStringAsFixed(1)}%)",
                    isDarkMode: isDarkMode,
                  ),
                  if (FinancialTips.categoryTips.containsKey(
                    e.key.toLowerCase(),
                  ))
                    ...FinancialTips.categoryTips[e.key.toLowerCase()]!
                        .take(2)
                        .map(
                          (tip) => FutureBuilder<String>(
                            future: translateSmart(tip, loc, langCode),
                            builder:
                                (context, tipSnap) =>
                                    tipSnap.hasData
                                        ? _buildChatBubble(
                                          isUser: false,
                                          message: "💡 ${tipSnap.data!}",
                                          isDarkMode: isDarkMode,
                                        )
                                        : const SizedBox(),
                          ),
                        ),
                ],
              );
            }),
            if (exceededCategories.isNotEmpty)
              _buildChatBubble(
                isUser: false,
                message: data[5],
                isDarkMode: isDarkMode,
              ),
            ...exceededCategories
                .take(3)
                .map(
                  (e) => _buildChatBubble(
                    isUser: false,
                    message: "⚠️ ${e.key} (${e.value.toStringAsFixed(2)} EGP)",
                    isDarkMode: isDarkMode,
                  ),
                ),
            _buildChatBubble(
              isUser: false,
              message: data[6],
              isDarkMode: isDarkMode,
            ),
            ...FinancialTips.generalTips
                .take(3)
                .map(
                  (tip) => FutureBuilder<String>(
                    future: translateSmart(tip, loc, langCode),
                    builder:
                        (context, tipSnap) =>
                            tipSnap.hasData
                                ? _buildChatBubble(
                                  isUser: false,
                                  message: "✨ ${tipSnap.data!}",
                                  isDarkMode: isDarkMode,
                                )
                                : const SizedBox(),
                  ),
                ),
          ],
        );
      },
    );
  }

  Widget _buildTipsContent(bool isDarkMode) {
    return FutureBuilder<String>(
      future: translateSmart("Here are some financial tips:", loc, langCode),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox();
        return Column(
          children: [
            _buildChatBubble(
              isUser: false,
              message: snapshot.data!,
              isDarkMode: isDarkMode,
            ),
            ...FinancialTips.generalTips
                .take(3)
                .map(
                  (tip) => FutureBuilder<String>(
                    future: translateSmart(tip, loc, langCode),
                    builder:
                        (context, tipSnap) =>
                            tipSnap.hasData
                                ? _buildChatBubble(
                                  isUser: false,
                                  message: "💡 ${tipSnap.data!}",
                                  isDarkMode: isDarkMode,
                                )
                                : const SizedBox(),
                  ),
                ),
          ],
        );
      },
    );
  }
}

// financial_tips.dart
class FinancialTips {
  static const Map<String, List<String>> categoryTips = {
    // Individual Categories
    'electricity': [
      "• Switch to LED bulbs (30% lighting savings)",
      "• Unplug devices (5-10% standby power reduction)",
      "• Use smart power strips (15% savings)",
      "• Set AC to 24°C (20% cooling cost reduction)",
      "• Wash clothes in cold water (90% less energy)",
      "• Use natural light during daytime",
      "• Install motion sensor lights",
      "• Clean AC filters monthly (15% more efficient)"
    ],
    'internet': [
      "• Downgrade speed if not needed (20-40% savings)",
      "• Bundle services (15-30% discount)",
      "• Negotiate annually (10-15% reduction)",
      "• Use WiFi hotspots when available",
      "• Monitor data usage to avoid overage fees",
      "• Buy your own modem (saves rental fees)",
      "• Look for loyalty discounts",
      "• Consider prepaid plans for light users"
    ],
    // Add all other categories with 8 tips each...
  };

  static const List<String> generalTips = [
    "💰 Pay yourself first: Save 20% immediately when income arrives",
    "📉 Implement the 72-hour rule for non-essential purchases",
    "🔄 Review subscriptions monthly (cancel unused services)",
    "🍎 Meal prep Sundays (25% food cost reduction)",
    "🚗 Carpool twice weekly (40% fuel savings)",
    "📱 Use budgeting apps for real-time tracking",
    "🧾 Keep all receipts for spending analysis",
    "🎯 Set specific financial goals each quarter"
  ];

  static const List<String> businessTips = [
    "📊 Negotiate vendor contracts annually (10-20% savings)",
    "🔄 Implement paperless billing (30% cost reduction)",
    "🤝 Cross-train employees (25% more flexibility)",
    "📦 Optimize inventory (15% less waste)",
    "💡 Use energy-efficient equipment (20% utility savings)",
    "📅 Schedule equipment maintenance (40% longer lifespan)",
    "🌱 Go green (tax incentives available)",
    "📱 Adopt digital tools (30% productivity boost)"
  ];
}
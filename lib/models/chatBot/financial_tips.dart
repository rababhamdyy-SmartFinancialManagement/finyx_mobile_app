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
      "• Clean AC filters monthly (15% more efficient)",
    ],

    'internet': [
      "• Downgrade speed if not needed (20-40% savings)",
      "• Bundle services (15-30% discount)",
      "• Negotiate annually (10-15% reduction)",
      "• Use WiFi hotspots when available",
      "• Monitor data usage to avoid overage fees",
      "• Buy your own modem (saves rental fees)",
      "• Look for loyalty discounts",
      "• Consider prepaid plans for light users",
    ],

    'food': [
      "• Meal prep weekly (25% food cost reduction)",
      "• Buy in bulk for staples (15-30% cheaper)",
      "• Use grocery lists to avoid impulse buys",
      "• Cook at home 5+ days/week (40% savings)",
      "• Shop seasonal produce (20-50% cheaper)",
      "• Reduce meat consumption 2 days/week",
      "• Use leftovers creatively",
      "• Compare unit prices when shopping",
    ],

    'zakat': [
      "• Calculate zakat accurately to avoid overpayment",
      "• Pay zakat early to maximize benefits",
      "• Distribute zakat throughout the year",
      "• Consider zakat-eligible investment options",
      "• Keep records of zakat payments",
      "• Verify eligibility of recipients",
      "• Combine zakat with sadaqah for greater impact",
      "• Use zakat calculators for complex assets",
    ],

    'shopping': [
      "• Implement 30-day rule for non-essential purchases",
      "• Use cashback apps and loyalty programs",
      "• Shop during sales seasons (30-70% off)",
      "• Compare prices online before buying",
      "• Buy quality items that last longer",
      "• Avoid impulse purchases at checkout",
      "• Unsubscribe from marketing emails",
      "• Set monthly shopping budgets",
    ],

    'gas': [
      "• Maintain proper tire pressure (3% better mileage)",
      "• Use cruise control on highways (7% savings)",
      "• Combine errands to reduce trips",
      "• Carpool 2+ days/week (40% savings)",
      "• Avoid aggressive driving (20% more efficient)",
      "• Use public transport when possible",
      "• Remove roof racks when not in use",
      "• Regular engine maintenance (15% better efficiency)",
    ],

    'waterbill': [
      "• Fix leaks immediately (10% savings)",
      "• Install low-flow showerheads (30% less usage)",
      "• Water plants early morning (50% less evaporation)",
      "• Use dishwasher only when full",
      "• Collect rainwater for gardening",
      "• Take shorter showers (20% reduction)",
      "• Turn off tap while brushing teeth",
      "• Upgrade to water-efficient appliances",
    ],

    'club': [
      "• Evaluate membership usage annually",
      "• Share family memberships when possible",
      "• Negotiate corporate discounts",
      "• Look for off-peak membership rates",
      "• Consider pay-per-use alternatives",
      "• Bundle with other services",
      "• Ask about loyalty discounts",
      "• Pause membership during travel",
    ],

    'mobilecredit': [
      "• Use VoIP apps for international calls",
      "• Monitor data usage to avoid overages",
      "• Buy bundles in bulk (20% cheaper)",
      "• Use WiFi calling when available",
      "• Compare operator promotions monthly",
      "• Consider dual-SIM for best rates",
      "• Set usage alerts and limits",
      "• Downgrade plan if consistently underusing",
    ],

    'car': [
      "• Regular maintenance saves long-term costs",
      "• Consider carpooling 2+ days/week",
      "• Use fuel-efficient driving techniques",
      "• Compare insurance rates annually",
      "• Park in shade to reduce AC usage",
      "• Remove unnecessary weight from trunk",
      "• Plan routes to avoid traffic",
      "• Consider electric/hybrid for next purchase",
    ],

    'voucher': [
      "• Buy vouchers in bulk during promotions",
      "• Use voucher aggregation apps",
      "• Combine with cashback offers",
      "• Check expiry dates regularly",
      "• Share unused vouchers with family",
      "• Use for recurring expenses",
      "• Verify terms and conditions",
      "• Prioritize vouchers for high-frequency purchases",
    ],

    'assurance': [
      "• Compare insurance policies annually",
      "• Increase deductibles to lower premiums",
      "• Bundle multiple policies (15% discount)",
      "• Maintain good credit score for better rates",
      "• Ask about loyalty discounts",
      "• Review coverage needs regularly",
      "• Consider term life for temporary needs",
      "• Use preventive care benefits",
    ],

    'cinema': [
      "• Attend matinee shows (30% cheaper)",
      "• Use loyalty programs for free tickets",
      "• Share large combos with friends",
      "• Look for weekday specials",
      "• Consider subscription services",
      "• Bring your own snacks",
      "• Wait for streaming release",
      "• Buy tickets in advance online",
    ],

    'association': [
      "• Evaluate membership benefits annually",
      "• Share membership with colleagues",
      "• Attend free events to maximize value",
      "• Network to find partnership discounts",
      "• Claim all available tax deductions",
      "• Volunteer for reduced fees",
      "• Use member-only resources fully",
      "• Combine with professional development",
    ],

    // Business Categories
    'licenses': [
      "• Renew early for early bird discounts",
      "• Bundle multiple licenses",
      "• Negotiate volume discounts",
      "• Outsource compliance monitoring",
      "• Use digital licenses when possible",
      "• Track renewal dates carefully",
      "• Qualify for small business exemptions",
      "• Deduct license fees from taxes",
    ],

    'accruedinterest': [
      "• Negotiate lower interest rates",
      "• Make early payments when possible",
      "• Refinance high-interest debt",
      "• Consolidate multiple loans",
      "• Use balance transfer offers",
      "• Prioritize high-interest debt",
      "• Automate payments to avoid penalties",
      "• Deduct business interest expenses",
    ],

    'adminexpenses': [
      "• Go paperless to reduce costs",
      "• Automate repetitive tasks",
      "• Outsource non-core functions",
      "• Negotiate with suppliers annually",
      "• Implement energy-saving measures",
      "• Use shared office spaces",
      "• Track all expenses for tax deductions",
      "• Review subscriptions quarterly",
    ],

    'shipping': [
      "• Negotiate bulk shipping rates",
      "• Use regional carriers for local deliveries",
      "• Consolidate shipments when possible",
      "• Implement inventory management system",
      "• Offer pickup options to customers",
      "• Use flat-rate boxes when advantageous",
      "• Automate shipping labels",
      "• Track packages to avoid losses",
    ],

    'esalaries': [
      "• Implement performance-based bonuses",
      "• Offer non-cash benefits",
      "• Cross-train employees for flexibility",
      "• Outsource specialized tasks",
      "• Use freelancers for peak periods",
      "• Implement productivity tools",
      "• Offer remote work options",
      "• Review payroll structure annually",
    ],

    'loan': [
      "• Refinance when rates drop",
      "• Make extra principal payments",
      "• Negotiate better terms annually",
      "• Consolidate multiple loans",
      "• Maintain excellent credit score",
      "• Choose variable rates when appropriate",
      "• Automate payments for discounts",
      "• Deduct business loan interest",
    ],
  };

  static const List<String> generalTips = [
    "💰 Pay yourself first: Save 20% immediately when income arrives",
    "📉 Implement the 72-hour rule for non-essential purchases",
    "🔄 Review subscriptions monthly (cancel unused services)",
    "🍎 Meal prep Sundays (25% food cost reduction)",
    "🚗 Carpool twice weekly (40% fuel savings)",
    "📱 Use budgeting apps for real-time tracking",
    "🧾 Keep all receipts for spending analysis",
    "🎯 Set specific financial goals each quarter",
  ];

  static const List<String> businessTips = [
    "📊 Negotiate vendor contracts annually (10-20% savings)",
    "🔄 Implement paperless billing (30% cost reduction)",
    "🤝 Cross-train employees (25% more flexibility)",
    "📦 Optimize inventory (15% less waste)",
    "💡 Use energy-efficient equipment (20% utility savings)",
    "📅 Schedule equipment maintenance (40% longer lifespan)",
    "🌱 Go green (tax incentives available)",
    "📱 Adopt digital tools (30% productivity boost)",
  ];
}

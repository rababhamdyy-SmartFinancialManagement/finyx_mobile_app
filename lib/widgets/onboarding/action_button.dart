import 'package:flutter/material.dart';
import 'package:finyx_mobile_app/widgets/shared/button_widget.dart';
import '../../models/applocalization.dart';

class OnboardingActionButton extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final VoidCallback onNextPressed;

  const OnboardingActionButton({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onNextPressed,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return ButtonWidget(
      text: currentPage < totalPages - 1
          ? loc.translate("next")
          : loc.translate("get_started"),
      width: 198,
      height: 53,
      onPressed: onNextPressed,
    );
  }
}

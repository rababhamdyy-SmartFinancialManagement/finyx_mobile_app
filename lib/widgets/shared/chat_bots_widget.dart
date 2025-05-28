import 'package:finyx_mobile_app/models/applocalization.dart';
import 'package:finyx_mobile_app/services/hugging_face_service.dart';
import 'package:flutter/material.dart';

class ChatDialog extends StatefulWidget {
  final VoidCallback onPressed;

  const ChatDialog({super.key, required this.onPressed});

  @override
  _ChatDialogState createState() => _ChatDialogState();
}

class _ChatDialogState extends State<ChatDialog> {
  String botResponse = "";
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double dialogHeight = MediaQuery.of(context).size.height * 0.6;
    double dialogWidth = MediaQuery.of(context).size.width * 0.8;
    final loc = AppLocalizations.of(context)!;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        height: dialogHeight,
        width: dialogWidth,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF3E0555).withAlpha(15),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withAlpha(15),
                      blurRadius: 15,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: IconButton(
                  icon: const Icon(Icons.close, color: Color(0xFF3E0555)),
                  onPressed: widget.onPressed,
                ),
              ),
            ),
            Text(
              loc.translate("chat_bot_title"),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: "REM",
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: isLoading && botResponse.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                        child: Text(
                          botResponse.isEmpty
                              ? loc.translate("chat_start_message")
                              : botResponse,
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Poppins",
                            color:
                                Theme.of(context).textTheme.bodyMedium!.color!,
                          ),
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () async {
                      setState(() {
                        isLoading = true;
                        botResponse = "";
                      });
                      final service = HuggingFaceService();
                      String reply =
                          await service.getModelPrediction("start");
                      setState(() {
                        botResponse = reply;
                        isLoading = false;
                      });
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3E0555),
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                loc.translate("start_button"),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontFamily: "Poppins",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        height: dialogHeight,
        width: dialogWidth,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 222, 206, 240),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: IconButton(
                  icon: Icon(Icons.close, color: Colors.red),
                  onPressed: widget.onPressed,
                ),
              ),
            ),
            Text(
              'Chat Bot',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                color: Colors.grey[200],
                child: SingleChildScrollView(
                  child: Text(
                    botResponse.isEmpty
                        ? "Press start to begin..."
                        : botResponse,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () async {
                      setState(() {
                        isLoading = true;
                        botResponse = "Loading...";
                      });
                      final service = HuggingFaceService();
                      String reply = await service.getModelPrediction("start");
                      setState(() {
                        botResponse = reply;
                        isLoading = false;
                      });
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF3E0555),
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text("Start", style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}

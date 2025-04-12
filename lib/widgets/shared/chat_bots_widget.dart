import 'package:flutter/material.dart';

class ChatDialog extends StatefulWidget {
  final VoidCallback onPressed;  // Block to be executed when pressed

  const ChatDialog({super.key, required this.onPressed});

  @override
  _ChatDialogState createState() => _ChatDialogState();
}

class _ChatDialogState extends State<ChatDialog> {
  TextEditingController _controller = TextEditingController();  // Controller for the TextField

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        height: 400, // Default height for the Dialog
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Title of the chat
            Text(
              'Chat Bot',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Column(
                children: [
                  // Chat content (here you can integrate the chat bot or any other content)
                  Container(
                    height: 300,
                    color: Colors.grey[200],
                    child: Center(child: Text("Chat content will appear here")),
                  ),
                  // Chat input section
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              hintText: 'Type a message...',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () {
                            // Handle send action (you can send the message here)
                            String message = _controller.text;
                            if (message.isNotEmpty) {
                              // Process the message or send it
                              print('Message sent: $message');
                              _controller.clear();  // Clear the text field after sending
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Close button
            ElevatedButton(
              onPressed: widget.onPressed,  // Using the passed block to close the Dialog
              child: Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}

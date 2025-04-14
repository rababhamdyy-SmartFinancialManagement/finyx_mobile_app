import 'package:flutter/material.dart';

class ChatDialog extends StatefulWidget {
  final VoidCallback onPressed; // Block to be executed when pressed

  const ChatDialog({super.key, required this.onPressed});

  @override
  _ChatDialogState createState() => _ChatDialogState();
}

class _ChatDialogState extends State<ChatDialog> {
  TextEditingController _controller =
      TextEditingController(); // Controller for the TextField

  @override
  Widget build(BuildContext context) {
    // استخدام MediaQuery للحصول على الأبعاد
    double dialogHeight =
        MediaQuery.of(context).size.height * 0.6; // 60% من ارتفاع الشاشة
    double dialogWidth =
        MediaQuery.of(context).size.width * 0.8; // 80% من عرض الشاشة

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // جعل الزوايا أكثر نعومة
      ),
      child: Container(
        height: dialogHeight, // تحديد ارتفاع الـ Dialog بناءً على حجم الشاشة
        width: dialogWidth, // تحديد عرض الـ Dialog بناءً على حجم الشاشة
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 222, 206, 240), // لون بنفسجي شفاف خفيف
          borderRadius: BorderRadius.circular(16), // زوايا دائرية
        ),
        child: Column(
          children: [
            // الجزء العلوي مع الأيقونة
            Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: EdgeInsets.all(6), // حجم padding حول الأيقونة
                decoration: BoxDecoration(
                  color: Colors.white, // خلفية بيضاء للأيقونة
                  shape: BoxShape.circle, // جعل الأيقونة داخل دائرة
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 5,
                      offset: Offset(0, 3), // ظل بسيط تحت الأيقونة
                    ),
                  ],
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.purple,
                  ), // أيقونة إغلاق بلون أحمر
                  onPressed: widget.onPressed, // إغلاق الـ Dialog عند الضغط
                ),
              ),
            ),
            // عنوان الشات
            Text(
              'Chat Bot',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple, // لون بنفسجي للنص
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // محتوى الشات (يمكن دمج الشات بوت هنا أو أي محتوى آخر)
                    Container(
                      height: dialogHeight * 0.6, // 60% من ارتفاع الـ Dialog
                      color: Colors.grey[200],
                      child: Center(
                        child: Text("Chat content will appear here"),
                      ),
                    ),
                    // قسم إدخال الرسائل
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
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 10,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.send,
                              color: Colors.purple,
                            ), // أيقونة إرسال بنفسجي
                            onPressed: () {
                              // التعامل مع إرسال الرسالة (يمكنك إرسال الرسالة هنا)
                              String message = _controller.text;
                              if (message.isNotEmpty) {
                                // معالجة الرسالة أو إرسالها
                                print('Message sent: $message');
                                _controller
                                    .clear(); // مسح الحقل النصي بعد الإرسال
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

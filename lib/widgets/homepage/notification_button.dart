import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFF3E0555);

class NotificationItem {
  final String title;
  final String subtitle;
  bool isRead;

  NotificationItem({
    required this.title,
    required this.subtitle,
    this.isRead = false,
  });
}

class NotificationTile extends StatelessWidget {
  final NotificationItem notif;
  final VoidCallback onTap;

  const NotificationTile({required this.notif, required this.onTap, Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            if (!notif.isRead)
              Container(
                width: 5,
                height: 48,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            if (!notif.isRead) SizedBox(width: 10),
            Icon(
              notif.isRead
                  ? Icons.notifications_none
                  : Icons.notifications_active,
              color: notif.isRead ? Colors.grey.shade500 : primaryColor,
              size: 26,
            ),
            SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notif.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                      color: notif.isRead ? Colors.black87 : primaryColor,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    notif.subtitle,
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationButton extends StatefulWidget {
  const NotificationButton({Key? key}) : super(key: key);

  @override
  _NotificationButtonState createState() => _NotificationButtonState();
}

class _NotificationButtonState extends State<NotificationButton> {
  final GlobalKey _key = GlobalKey();

  List<NotificationItem> notifications = [
    NotificationItem(
      title: 'New Message',
      subtitle: 'You have a new message from Ahmed',
    ),
    NotificationItem(
      title: 'Update',
      subtitle: 'The app has been updated',
      isRead: true,
    ),
    NotificationItem(
      title: 'Alert',
      subtitle: 'Please update your profile info',
    ),
  ];

  void _showNotificationsMenu() async {
    final RenderBox renderBox =
        _key.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy + size.height,
        offset.dx + size.width,
        offset.dy,
      ),
      constraints: BoxConstraints(maxWidth: 320, maxHeight: 400),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      items: [
        PopupMenuItem(
          enabled: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Notifications',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  minimumSize: Size(0, 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () {
                  setState(() {
                    for (var n in notifications) {
                      n.isRead = true;
                    }
                  });
                  Navigator.pop(context);
                  _showNotificationsMenu();
                },
                child: Text(
                  'Mark all as read',
                  style: TextStyle(
                    fontSize: 13,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (notifications.isEmpty)
          const PopupMenuItem(
            enabled: false,
            child: Center(
              child: Text(
                'No notifications',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ...notifications.map(
          (notif) => PopupMenuItem<NotificationItem>(
            value: notif,
            enabled: false,
            padding: EdgeInsets.zero,
            child: NotificationTile(
              notif: notif,
              onTap: () {
                setState(() {
                  notif.isRead = true;
                });
                Navigator.pop(context);
                _showNotificationsMenu();
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    int unreadCount = notifications.where((n) => !n.isRead).length;

    return Stack(
      children: [
        IconButton(
          key: _key,
          icon: Icon(Icons.notifications, size: 32, color: primaryColor),
          onPressed: _showNotificationsMenu,
          tooltip: 'Notifications',
        ),
        if (unreadCount > 0)
          Positioned(
            right: 6,
            top: 6,
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Color(0xFFDA9220),
                shape: BoxShape.circle,
              ),
              constraints: BoxConstraints(minWidth: 20, minHeight: 20),
              child: Center(
                child: Text(
                  '$unreadCount',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

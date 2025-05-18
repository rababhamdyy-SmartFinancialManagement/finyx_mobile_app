// import 'package:finyx_mobile_app/cubits/profile/profile_cubit.dart';
// import 'package:finyx_mobile_app/cubits/profile/profile_state.dart';
// import 'package:finyx_mobile_app/models/notification/notification_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class NotificationItem {
//   final String title;
//   final String subtitle;
//   bool isRead;
//   final DateTime timestamp;

//   NotificationItem({
//     required this.title,
//     required this.subtitle,
//     this.isRead = false,
//     required this.timestamp,
//   });
// }

// class NotificationTile extends StatelessWidget {
//   final NotificationItem notif;
//   final VoidCallback onTap;

//   const NotificationTile({
//     required this.notif,
//     required this.onTap,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
//         padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
//         decoration: BoxDecoration(
//           color: notif.isRead ? Colors.grey.shade100 : Colors.white,
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.shade300,
//               blurRadius: 4,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             if (!notif.isRead)
//               Container(
//                 width: 5,
//                 height: 48,
//                 decoration: BoxDecoration(
//                   color: Colors.purple,
//                   borderRadius: BorderRadius.circular(2),
//                 ),
//               ),
//             if (!notif.isRead) const SizedBox(width: 10),
//             Icon(
//               notif.isRead ? Icons.notifications_none : Icons.notifications_active,
//               color: notif.isRead ? Colors.grey.shade500 : Colors.purple,
//               size: 26,
//             ),
//             const SizedBox(width: 14),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     notif.title,
//                     style: TextStyle(
//                       fontWeight: FontWeight.w800,
//                       fontSize: 15,
//                       color: notif.isRead ? Colors.black87 : Colors.purple,
//                     ),
//                   ),
//                   const SizedBox(height: 6),
//                   Text(
//                     notif.subtitle,
//                     style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     _formatDate(notif.timestamp),
//                     style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   String _formatDate(DateTime date) {
//     return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
//   }
// }

// class NotificationButton extends StatelessWidget {
//   const NotificationButton({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ProfileCubit, ProfileState>(
//       builder: (context, state) {
//         final unreadCount = state.notifications.where((n) => !n.isRead).length;
        
//         return Stack(
//           children: [
//             IconButton(
//               icon: const Icon(Icons.notifications, size: 32, color: Colors.purple),
//               onPressed: () => _showNotificationsMenu(context, state.notifications),
//             ),
//             if (unreadCount > 0)
//               Positioned(
//                 right: 6,
//                 top: 6,
//                 child: Container(
//                   padding: const EdgeInsets.all(4),
//                   decoration: const BoxDecoration(
//                     color: Color(0xFFDA9220),
//                     shape: BoxShape.circle,
//                   ),
//                   constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
//                   child: Center(
//                     child: Text(
//                       unreadCount > 9 ? '9+' : '$unreadCount',
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 11,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//           ],
//         );
//       },
//     );
//   }

//   void _showNotificationsMenu(
//     BuildContext context,
//     List<AppNotification> notifications,
//   ) {
//     final cubit = context.read<ProfileCubit>();
    
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),),
//       builder: (context) {
//         return Container(
//           height: MediaQuery.of(context).size.height * 0.8,
//           padding: const EdgeInsets.only(top: 16),
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       'الإشعارات',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         cubit.markAllNotificationsAsRead();
//                         Navigator.pop(context);
//                         _showNotificationsMenu(
//                           context, 
//                           notifications.map((n) => n..isRead = true).toList(),
//                         );
//                       },
//                       child: const Text(
//                         'تعيين الكل كمقروء',
//                         style: TextStyle(color: Colors.purple),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const Divider(height: 20, thickness: 1),
//               Expanded(
//                 child: notifications.isEmpty
//                     ? const Center(
//                         child: Text(
//                           'لا توجد إشعارات جديدة',
//                           style: TextStyle(color: Colors.grey),
//                         ),
//                       )
//                     : ListView.separated(
//                         itemCount: notifications.length,
//                         separatorBuilder: (context, index) => const Divider(height: 1),
//                         itemBuilder: (context, index) {
//                           final notification = notifications[index];
//                           return NotificationTile(
//                             notif: NotificationItem(
//                               title: notification.title,
//                               subtitle: notification.message,
//                               isRead: notification.isRead,
//                               timestamp: notification.timestamp,
//                             ),
//                             onTap: () {
//                               cubit.markNotificationAsRead(notification.id);
//                               Navigator.pop(context);
//                               _handleNotificationAction(context, notification);
//                             },
//                           );
//                         },
//                       ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   void _handleNotificationAction(BuildContext context, AppNotification notification) {
//     // يمكنك إضافة منطق معالجة النقر على إشعار معين هنا
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('تم فتح الإشعار: ${notification.title}'),
//         duration: const Duration(seconds: 2),
//       ),
//     );
//   }
// }
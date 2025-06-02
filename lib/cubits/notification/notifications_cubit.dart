import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsCubit extends Cubit<bool> {
  NotificationsCubit() : super(true) {
    _loadNotificationStatus();
  }

  static const String _notificationKey = 'notifications_enabled';

  Future<void> _loadNotificationStatus() async {
    final prefs = await SharedPreferences.getInstance();
    emit(prefs.getBool(_notificationKey) ?? true);
  }

  Future<void> toggleNotifications(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_notificationKey, enabled);
    emit(enabled);
  }
}
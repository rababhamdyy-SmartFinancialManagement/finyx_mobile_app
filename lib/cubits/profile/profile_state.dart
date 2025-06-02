import 'package:finyx_mobile_app/models/notification/notification_model.dart';

class ProfileState {
  final String name;
  final String email;
  final String birthDate;
  final String location;
  final String idNumber;
  final String salary;
  final String? imagePath;
  final List<AppNotification> notifications;

  ProfileState({
    this.name = '',
    this.email = '',
    this.birthDate = '',
    this.location = '',
    this.idNumber = '',
    this.salary = '',
    this.imagePath,
    this.notifications = const [],
  });

  ProfileState copyWith({
    String? name,
    String? email,
    String? birthDate,
    String? location,
    String? idNumber,
    String? salary,
    String? imagePath,
    List<AppNotification>? notifications,
  }) {
    return ProfileState(
      name: name ?? this.name,
      email: email ?? this.email,
      birthDate: birthDate ?? this.birthDate,
      location: location ?? this.location,
      idNumber: idNumber ?? this.idNumber,
      salary: salary ?? this.salary,
      imagePath: imagePath ?? this.imagePath,
      notifications: notifications ?? this.notifications,
    );
  }

  // أضف هذه الدالة الجديدة
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'birthDate': birthDate,
      'location': location,
      'idNumber': idNumber,
      'salary': salary,
      'imagePath': imagePath,
      'notifications': notifications.map((n) => n.toMap()).toList(),
    };
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finyx_mobile_app/cubits/profile/profile_state.dart';
import 'package:finyx_mobile_app/models/notification/notification_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final FlutterLocalNotificationsPlugin notificationsPlugin;
  
  ProfileCubit(this.notificationsPlugin) : super(ProfileState()) {
    _init();
  }

  void _init() {
    loadUserData();
    _setupNotifications();
    listenToAuthChanges(); // بدء الاستماع لتغييرات حالة المصادقة
  }
  Future<void> _setupNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await notificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _addNotification(AppNotification notification) async {
    final newNotifications = List<AppNotification>.from(state.notifications)
      ..insert(0, notification);

    emit(state.copyWith(notifications: newNotifications));

    await _showLocalNotification(notification);
  }

  Future<void> _showLocalNotification(AppNotification notification) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          'profile_updates', // Channel ID
          'Profile Updates', // Channel Name
          importance: Importance.high,
          priority: Priority.high,
          channelShowBadge: true,
          showWhen: true,
        );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    await notificationsPlugin.show(
      notification.id.hashCode,
      notification.title,
      notification.message,
      notificationDetails,
    );
  }
  // في ملف profile_cubit.dart
void resetState() {
  emit(ProfileState()); // إعادة تعيين الحالة إلى الحالة الأولية
}

void listenToAuthChanges() {
  FirebaseAuth.instance.authStateChanges().listen((user) async {
    if (user != null) {
      await loadUserData(); // جلب بيانات المستخدم الجديد
    } else {
      resetState(); // إعادة تعيين الحالة إذا لم يكن هناك مستخدم مسجل دخول
    }
  });
}

  Future<void> updateProfileField(String field, String value) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final userDoc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();

      if (userDoc.exists) {
        final userType = userDoc.data()?['userType'] ?? 'individual';
        final collectionName =
            userType == 'individual' ? 'individuals' : 'businesses';

        String firestoreField = _getFirestoreFieldName(field, userType);

        await FirebaseFirestore.instance
            .collection(collectionName)
            .doc(user.uid)
            .update({firestoreField: value});

        switch (field) {
          case 'Name':
            emit(state.copyWith(name: value));
            break;
          case 'Email':
            emit(state.copyWith(email: value));
            break;
          case 'Birth Date':
            emit(state.copyWith(birthDate: value));
            break;
          case 'Location':
            emit(state.copyWith(location: value));
            break;
          case 'ID Number':
            emit(state.copyWith(idNumber: value));
            break;
          case 'Salary':
            emit(state.copyWith(salary: value));
            break;
        }

        await _addNotification(
          AppNotification(
            id: '${DateTime.now().millisecondsSinceEpoch}',
            title: 'Profile Update',
            message: '$field updated to $value',
            timestamp: DateTime.now(),
          ),
        );
      }
    } catch (e) {
      throw Exception('Failed to update $field: ${e.toString()}');
    }
  }

  // Future<void> _loadUserData() async {
  //   try {
  //     final user = FirebaseAuth.instance.currentUser;
  //     if (user == null) return;

  //     final prefs = await SharedPreferences.getInstance();
  //     final cachedImagePath = prefs.getString('imagePath');

  //     final userDoc =
  //         await FirebaseFirestore.instance
  //             .collection('users')
  //             .doc(user.uid)
  //             .get();

  //     if (userDoc.exists) {
  //       final userType = userDoc.data()?['userType'] ?? 'individual';
  //       final collectionName =
  //           userType == 'individual' ? 'individuals' : 'businesses';

  //       final detailsDoc =
  //           await FirebaseFirestore.instance
  //               .collection(collectionName)
  //               .doc(user.uid)
  //               .get();

  //       if (detailsDoc.exists) {
  //         final data = detailsDoc.data()!;
  //         final firestoreImagePath = data['profileImage'] as String?;
  //         final imagePath = firestoreImagePath ?? cachedImagePath;

  //         emit(
  //           state.copyWith(
  //             name: data['fullName'] ?? '',
  //             email: userDoc.data()?['email'] ?? '',
  //             birthDate: data['dob'] ?? data['budget'] ?? '',
  //             location: data['address'] ?? data['companyLocation'] ?? '',
  //             idNumber: data['nationalId'] ?? data['numberOfEmployees'] ?? '',
  //             salary: data['income'] ?? data['budget'] ?? '',
  //             imagePath: imagePath,
  //           ),
  //         );

  //         if (firestoreImagePath != null &&
  //             firestoreImagePath != cachedImagePath) {
  //           await prefs.setString('imagePath', firestoreImagePath);
  //         }
  //       }
  //     } else {
  //       emit(state.copyWith(imagePath: cachedImagePath));
  //     }
  //   } catch (e) {
  //     // print('Error loading user data: $e');
  //     emit(state.copyWith());
  //   }
  // }

  Future<void> loadUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final userDoc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();

      String? imageUrl = user.photoURL;
      String? name = user.displayName;
      String? email = user.email;
      String birthDate = '';
      String location = '';
      String idNumber = '';
      String salary = '';

      if (userDoc.exists) {
        final userType = userDoc.data()?['userType'] ?? 'individual';
        final collectionName =
            userType == 'individual' ? 'individuals' : 'businesses';

        final detailsDoc =
            await FirebaseFirestore.instance
                .collection(collectionName)
                .doc(user.uid)
                .get();

        if (detailsDoc.exists) {
          final data = detailsDoc.data()!;
          imageUrl = data['profileImage'] ?? imageUrl;
          name = data['fullName'] ?? name;
          email = data['email'] ?? email;
          birthDate = data['dob'] ?? data['budget'] ?? '';
          location = data['address'] ?? data['companyLocation'] ?? '';
          idNumber = data['nationalId'] ?? data['numberOfEmployees'] ?? '';
          salary = data['income'] ?? data['budget'] ?? '';
        }
      }

      emit(
        state.copyWith(
          name: name ?? '',
          email: email ?? '',
          birthDate: birthDate,
          location: location,
          idNumber: idNumber,
          salary: salary,
          imagePath: imageUrl,
        ),
      );

    } catch (e) {
      debugPrint('Error loading user data: $e');
      emit(state.copyWith());
    }
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image != null) {
        emit(state.copyWith(imagePath: image.path));

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('imagePath', image.path);

        final user = FirebaseAuth.instance.currentUser;
        if (user == null) return;

        final userDoc =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .get();

        if (userDoc.exists) {
          final userType = userDoc.data()?['userType'] ?? 'individual';
          final collectionName =
              userType == 'individual' ? 'individuals' : 'businesses';

          await FirebaseFirestore.instance
              .collection(collectionName)
              .doc(user.uid)
              .update({'profileImage': image.path});
        }
      }
    } catch (e) {
      // print('Error picking image: $e');
    }
  }

  Future<void> updateImagePath(String newPath) async {
    try {
      emit(state.copyWith(imagePath: newPath));

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('imagePath', newPath);

      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final userDoc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();

      if (userDoc.exists) {
        final userType = userDoc.data()?['userType'] ?? 'individual';
        final collectionName =
            userType == 'individual' ? 'individuals' : 'businesses';

        await FirebaseFirestore.instance
            .collection(collectionName)
            .doc(user.uid)
            .update({'profileImage': newPath});
      }
    } catch (e) {
      // print('Error updating image path: $e');
      final prefs = await SharedPreferences.getInstance();
      final oldPath = prefs.getString('imagePath');
      emit(state.copyWith(imagePath: oldPath));
      rethrow;
    }
  }

  Future<void> refreshProfileImage() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final userDoc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();

      if (userDoc.exists) {
        final userType = userDoc.data()?['userType'] ?? 'individual';
        final collectionName =
            userType == 'individual' ? 'individuals' : 'businesses';

        final detailsDoc =
            await FirebaseFirestore.instance
                .collection(collectionName)
                .doc(user.uid)
                .get();

        if (detailsDoc.exists) {
          final imagePath = detailsDoc.data()?['profileImage'] as String?;
          if (imagePath != null && imagePath != state.imagePath) {
            emit(state.copyWith(imagePath: imagePath));
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('imagePath', imagePath);
          }
        }
      }
    } catch (e) {
      // print('Error refreshing profile image: $e');
    }
  }

  Future<void> deleteAccount() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;

  try {
    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

    if (userDoc.exists) {
      final userType = userDoc.data()?['userType'] ?? 'individual';
      final collectionName =
          userType == 'individual' ? 'individuals' : 'businesses';

      await FirebaseFirestore.instance.collection(collectionName).doc(user.uid).delete();
      await FirebaseFirestore.instance.collection('users').doc(user.uid).delete();
    }

    await user.delete();

    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  } catch (e) {
    rethrow;
  }
}

 Future<bool> reauthenticate(String credentialInput) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return false;

  final providerId = user.providerData.first.providerId;

  try {
    if (providerId == 'google.com') {
      final googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser?.authentication;
      if (googleAuth == null) return false;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await user.reauthenticateWithCredential(credential);
      return true;
    } else {
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: credentialInput,
      );
      await user.reauthenticateWithCredential(credential);
      return true;
    }
  } catch (_) {
    return false;
  }
}

  String _getFirestoreFieldName(String field, String userType) {
    switch (field) {
      case 'Name':
        return 'fullName';
      case 'Email':
        return 'email';
      case 'Birth Date':
        return userType == 'individual' ? 'dob' : 'budget';
      case 'Location':
        return userType == 'individual' ? 'address' : 'companyLocation';
      case 'ID Number':
        return userType == 'individual' ? 'nationalId' : 'numberOfEmployees';
      case 'Salary':
        return userType == 'individual' ? 'income' : 'budget';
      default:
        return field.toLowerCase();
    }
  }
}
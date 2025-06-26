import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finyx_mobile_app/cubits/profile/profile_state.dart';
import 'package:finyx_mobile_app/models/notification/notification_model.dart';
import 'package:finyx_mobile_app/models/user_type.dart';
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
    listenToAuthChanges();
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
          'profile_updates',
          'Profile Updates',
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

  void resetState() {
    emit(ProfileState());
  }

  void listenToAuthChanges() {
    FirebaseAuth.instance.authStateChanges().listen((user) async {
      if (user != null) {
        await loadUserData();
      } else {
        emit(ProfileState());
      }
    });
  }

  Future<void> updateProfileField(String field, String value) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      // Update local state
      final newState = _updateLocalState(field, value);
      emit(newState);

      // Update in Firestore
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get(GetOptions(source: Source.server));

      if (userDoc.exists) {
        final userType =
            userDoc.data()?['userType'] == 'business'
                ? UserType.business
                : UserType.individual;

        final collectionName =
            userType == UserType.individual ? 'individuals' : 'businesses';

        final firestoreField = _getFirestoreFieldName(field, userType);

        if (field == 'Name') {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .update({'fullName': value});
        } else {
          await FirebaseFirestore.instance
              .collection(collectionName)
              .doc(user.uid)
              .update({
                firestoreField: value,
                'lastUpdated': FieldValue.serverTimestamp(),
              });
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
      debugPrint('Error updating $field: $e');
      await loadUserData();
      rethrow;
    }
  }

  ProfileState _updateLocalState(String field, String value) {
    switch (field) {
      case 'Name':
        return state.copyWith(name: value);
      case 'Email':
        return state.copyWith(email: value);
      case 'Birth Date':
        return state.copyWith(birthDate: value);
      case 'Location':
        return state.copyWith(location: value);
      case 'ID Number':
        return state.copyWith(idNumber: value);
      case 'Salary':
        return state.copyWith(salary: value);
      default:
        return state;
    }
  }

  Future<void> loadUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        emit(ProfileState());
        return;
      }

      await user.reload();
      final refreshedUser = FirebaseAuth.instance.currentUser;

      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get(GetOptions(source: Source.server));

      if (!userDoc.exists) {
        emit(
          ProfileState(
            name: refreshedUser?.displayName ?? '',
            email: refreshedUser?.email ?? '',
          ),
        );
        return;
      }

      final userType =
          userDoc.data()?['userType'] == 'business'
              ? UserType.business
              : UserType.individual;

      final collectionName =
          userType == UserType.individual ? 'individuals' : 'businesses';

      final detailsDoc = await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(user.uid)
          .get(GetOptions(source: Source.server));

      final prefs = await SharedPreferences.getInstance();
      final cachedImagePath = prefs.getString('imagePath');

      if (detailsDoc.exists) {
        final data = detailsDoc.data()!;
        final firestoreImagePath = data['profileImage'] as String?;
        final userImagePath = userDoc.data()?['profileImage'] as String?;
        final imagePath =
            firestoreImagePath ??
            userImagePath ??
            cachedImagePath ??
            refreshedUser?.photoURL;

        emit(
          ProfileState(
            name:
                userDoc.data()?['fullName'] ?? refreshedUser?.displayName ?? '',
            email: userDoc.data()?['email'] ?? refreshedUser?.email ?? '',
            birthDate: data['dob'] ?? '',
            location: data['address'] ?? data['companyLocation'] ?? '',
            idNumber: data['nationalId'] ?? data['numberOfEmployees'] ?? '',
            salary: data['income'] ?? data['budget'] ?? '',
            imagePath: imagePath,
            userType: userType,
          ),
        );

        if ((firestoreImagePath ?? userImagePath) != null &&
            (firestoreImagePath ?? userImagePath) != cachedImagePath) {
          await prefs.setString(
            'imagePath',
            firestoreImagePath ?? userImagePath!,
          );
        }
      } else {
        final userImagePath = userDoc.data()?['profileImage'] as String?;
        final imagePath =
            userImagePath ?? cachedImagePath ?? refreshedUser?.photoURL;

        emit(
          ProfileState(
            name:
                userDoc.data()?['fullName'] ?? refreshedUser?.displayName ?? '',
            email: userDoc.data()?['email'] ?? refreshedUser?.email ?? '',
            imagePath: imagePath,
            userType: userType,
          ),
        );

        if (userImagePath != null && userImagePath != cachedImagePath) {
          await prefs.setString('imagePath', userImagePath);
        }
      }
    } catch (e) {
      debugPrint('Error loading user data: $e');
      emit(ProfileState());
    }
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image != null) {
        await _updateProfileImage(image.path);
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  Future<void> _updateProfileImage(String imagePath) async {
    try {
      emit(state.copyWith(imagePath: imagePath));

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('imagePath', imagePath);

      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final userDoc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();

      if (userDoc.exists) {
        final userType =
            userDoc.data()?['userType'] == 'business'
                ? UserType.business
                : UserType.individual;

        final collectionName =
            userType == UserType.individual ? 'individuals' : 'businesses';

        await FirebaseFirestore.instance
            .collection(collectionName)
            .doc(user.uid)
            .update({
              'profileImage': imagePath,
              'lastUpdated': FieldValue.serverTimestamp(),
            });
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({'profileImage': imagePath});
      }
    } catch (e) {
      debugPrint('Error updating profile image: $e');
      final prefs = await SharedPreferences.getInstance();
      final oldPath = prefs.getString('imagePath');
      emit(state.copyWith(imagePath: oldPath));
      rethrow;
    }
  }

  Future<void> updateImagePath(String newPath) async {
    await _updateProfileImage(newPath);
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
        final userType =
            userDoc.data()?['userType'] == 'business'
                ? UserType.business
                : UserType.individual;

        final collectionName =
            userType == UserType.individual ? 'individuals' : 'businesses';

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
      debugPrint('Error refreshing profile image: $e');
    }
  }

  Future<void> deleteAccount() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      final userDoc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();

      if (userDoc.exists) {
        final userType =
            userDoc.data()?['userType'] == 'business'
                ? UserType.business
                : UserType.individual;

        final collectionName =
            userType == UserType.individual ? 'individuals' : 'businesses';

        await FirebaseFirestore.instance
            .collection(collectionName)
            .doc(user.uid)
            .delete();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .delete();
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

  String _getFirestoreFieldName(String field, UserType userType) {
    switch (field) {
      case 'Name':
        return 'fullName';
      case 'Email':
        return 'email';
      case 'Birth Date':
        return userType == UserType.individual ? 'dob' : 'budget';
      case 'Location':
        return userType == UserType.individual ? 'address' : 'companyLocation';
      case 'ID Number':
        return userType == UserType.individual
            ? 'nationalId'
            : 'numberOfEmployees';
      case 'Salary':
        return userType == UserType.individual ? 'income' : 'budget';
      default:
        return field.toLowerCase();
    }
  }
}

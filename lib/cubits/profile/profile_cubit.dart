import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState()) {
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      // Load from SharedPreferences first for quick display
      final prefs = await SharedPreferences.getInstance();
      final cachedImagePath = prefs.getString('imagePath');

      if (cachedImagePath != null) {
        emit(state.copyWith(imagePath: cachedImagePath));
      }

      // Load from Firestore
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
          final data = detailsDoc.data()!;
          emit(
            state.copyWith(
              name: data['fullName'] ?? '',
              email: userDoc.data()?['email'] ?? '',
              birthDate: data['dob'] ?? data['budget'] ?? '',
              location: data['address'] ?? data['companyLocation'] ?? '',
              idNumber: data['nationalId'] ?? data['numberOfEmployees'] ?? '',
              salary: data['income'] ?? data['budget'] ?? '',
              imagePath: cachedImagePath, // Keep the cached image path
            ),
          );
        }
      }
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  Future<void> _saveData(String key, String value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(key, value);
    } catch (e) {
      print('Error saving data: $e');
    }
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

        // Update local state
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

        await _saveData(field.toLowerCase(), value);
      }
    } catch (e) {
      print('Error updating profile field: $e');
      rethrow;
    }
  }

  Future<void> updateImagePath(String newPath) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      // Update in Firestore
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

      // Update local state and cache
      emit(state.copyWith(imagePath: newPath));
      await _saveData('imagePath', newPath);
    } catch (e) {
      print('Error updating image path: $e');
      rethrow;
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

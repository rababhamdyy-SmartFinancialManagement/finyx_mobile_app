import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String birthDate;
  final String location;
  final String idNumber;
  final String salary;
  final String? profileImage;
  final String userType;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.birthDate,
    required this.location,
    required this.idNumber,
    required this.salary,
    this.profileImage,
    required this.userType,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc, String userType) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: doc.id,
      name: data['fullName'] ?? '',
      email: data['email'] ?? '',
      birthDate: data['dob'] ?? data['budget'] ?? '',
      location: data['address'] ?? data['companyLocation'] ?? '',
      idNumber: data['nationalId'] ?? data['numberOfEmployees'] ?? '',
      salary: data['income'] ?? data['budget'] ?? '',
      userType: userType,
    );
  }
}

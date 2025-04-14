import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState()) {
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    emit(state.copyWith(
      imagePath: prefs.getString('imagePath') ?? state.imagePath,
      name: prefs.getString('name') ?? state.name,
      email: prefs.getString('email') ?? state.email,
      birthDate: prefs.getString('birthDate') ?? state.birthDate,
      location: prefs.getString('location') ?? state.location,
      idNumber: prefs.getString('idNumber') ?? state.idNumber,
      salary: prefs.getString('salary') ?? state.salary,
    ));
  }

  Future<void> _saveData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  void pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      emit(state.copyWith(imagePath: image.path));
      await _saveData('imagePath', image.path);
    }
  }

  void updateName(String newName) {
    emit(state.copyWith(name: newName));
    _saveData('name', newName);
  }

  void updateEmail(String newEmail) {
    emit(state.copyWith(email: newEmail));
    _saveData('email', newEmail);
  }

  void updateBirthDate(String newBirthDate) {
    emit(state.copyWith(birthDate: newBirthDate));
    _saveData('birthDate', newBirthDate);
  }

  void updateLocation(String newLocation) {
    emit(state.copyWith(location: newLocation));
    _saveData('location', newLocation);
  }

  void updateIdNumber(String newIdNumber) {
    emit(state.copyWith(idNumber: newIdNumber));
    _saveData('idNumber', newIdNumber);
  }

  void updateSalary(String newSalary) {
    emit(state.copyWith(salary: newSalary));
    _saveData('salary', newSalary);
  }

  void updateImagePath(String newPath) {
    emit(state.copyWith(imagePath: newPath));
    _saveData('imagePath', newPath);
  }
}
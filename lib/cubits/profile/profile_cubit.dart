// In your ProfileCubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState());

  void pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      emit(state.copyWith(imagePath: image.path));
    }
  }

  // Define updateImagePath to update the image path directly
  void updateImagePath(String newPath) {
    emit(state.copyWith(imagePath: newPath));
  }
}

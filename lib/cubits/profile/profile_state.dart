class ProfileState {
  final String imagePath;

  ProfileState({this.imagePath = ''});

  ProfileState copyWith({String? imagePath}) {
    return ProfileState(
      imagePath: imagePath ?? this.imagePath,
    );
  }
}

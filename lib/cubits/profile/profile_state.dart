class ProfileState {
  final String name;
  final String email;
  final String birthDate;
  final String location;
  final String idNumber;
  final String salary;
  final String? imagePath;

  ProfileState({
    this.name = '',
    this.email = '',
    this.birthDate = '',
    this.location = '',
    this.idNumber = '',
    this.salary = '',
    this.imagePath,
  });

  ProfileState copyWith({
    String? name,
    String? email,
    String? birthDate,
    String? location,
    String? idNumber,
    String? salary,
    String? imagePath,
  }) {
    return ProfileState(
      name: name ?? this.name,
      email: email ?? this.email,
      birthDate: birthDate ?? this.birthDate,
      location: location ?? this.location,
      idNumber: idNumber ?? this.idNumber,
      salary: salary ?? this.salary,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}
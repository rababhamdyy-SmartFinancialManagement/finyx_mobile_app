class ProfileState {
  final String imagePath;
  final String name;
  final String email;
  final String birthDate;
  final String location;
  final String idNumber;
  final String salary;

  ProfileState({
    this.imagePath = '',
    this.name = 'Yennefer Doe',
    this.email = 'Yennefer22@gmail.com',
    this.birthDate = '22 / 2 / 1990',
    this.location = 'Cairo , Egypt',
    this.idNumber = '30225696944566',
    this.salary = '2000\$',
  });

  ProfileState copyWith({
    String? imagePath,
    String? name,
    String? email,
    String? birthDate,
    String? location,
    String? idNumber,
    String? salary,
  }) {
    return ProfileState(
      imagePath: imagePath ?? this.imagePath,
      name: name ?? this.name,
      email: email ?? this.email,
      birthDate: birthDate ?? this.birthDate,
      location: location ?? this.location,
      idNumber: idNumber ?? this.idNumber,
      salary: salary ?? this.salary,
    );
  }
}

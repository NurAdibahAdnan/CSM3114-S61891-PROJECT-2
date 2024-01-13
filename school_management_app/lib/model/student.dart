class Student {
  String id;
  String name;
  int age;
  String address;
  String disciplineStatus;
  String email;
  String password;
  String about;
  String profilePictureUrl;

  Student({
    required this.id,
    required this.name,
    required this.age,
    required this.address,
    this.disciplineStatus = "Good",
    required this.email,
    required this.password,
    required this.about,
    required this.profilePictureUrl
  });

}

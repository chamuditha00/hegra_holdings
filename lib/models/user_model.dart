class UserModel {
  final String? id;
  final String name;
  final String email;
  final String password;
  final String area;
  final String position;

  const UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.area,
    required this.position,
  });

  toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'area': area,
      'position': position,
    };
  }
}

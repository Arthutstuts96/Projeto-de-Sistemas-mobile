class User {
  String email;
  String firstName;
  String lastName;
  String completeName;
  String cpf;
  String phone;
  String password;
  bool isSuperuser;
  bool isActive;
  bool isStaff;
  DateTime lastLogin;
  DateTime dateJoined;

  User({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.completeName,
    required this.cpf,
    required this.phone,
    required this.password,
    this.isSuperuser = false,
    this.isActive = true,
    this.isStaff = false,
    required this.lastLogin,
    required this.dateJoined,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      completeName: json['completeName'],
      cpf: json['cpf'],
      phone: json['phone'],
      password: json['password'],
      isSuperuser: json['is_superuser'] ?? false,
      isActive: json['is_active'] ?? true,
      isStaff: json['is_staff'] ?? false,
      lastLogin: DateTime.parse(json['last_login']),
      dateJoined: DateTime.parse(json['date_joined']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'completeName': completeName,
      'cpf': cpf,
      'phone': phone,
      'password': password,
      'is_superuser': isSuperuser,
      'is_active': isActive,
      'is_staff': isStaff,
      'last_login': lastLogin.toIso8601String(),
      'date_joined': dateJoined.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'User(email: $email, name: $completeName)';
  }
}

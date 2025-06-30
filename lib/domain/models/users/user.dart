// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  int? id;
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
    this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.completeName,
    required this.cpf,
    required this.phone,
    required this.password,
    required this.isSuperuser,
    required this.isActive,
    required this.isStaff,
    required this.lastLogin,
    required this.dateJoined,
  });

  User copyWith({
    int? id,
    String? email,
    String? firstName,
    String? lastName,
    String? completeName,
    String? cpf,
    String? phone,
    String? password,
    bool? isSuperuser,
    bool? isActive,
    bool? isStaff,
    DateTime? lastLogin,
    DateTime? dateJoined,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      completeName: completeName ?? this.completeName,
      cpf: cpf ?? this.cpf,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      isSuperuser: isSuperuser ?? this.isSuperuser,
      isActive: isActive ?? this.isActive,
      isStaff: isStaff ?? this.isStaff,
      lastLogin: lastLogin ?? this.lastLogin,
      dateJoined: dateJoined ?? this.dateJoined,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'completeName': completeName,
      'cpf': cpf,
      'phone': phone,
      'password': password,
      'isSuperuser': isSuperuser,
      'isActive': isActive,
      'isStaff': isStaff,
      'lastLogin': lastLogin.millisecondsSinceEpoch,
      'dateJoined': dateJoined.millisecondsSinceEpoch,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] != null ? map['id'] as int : null,
      email: map['email'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      completeName: map['completeName'] as String,
      cpf: map['cpf'] as String,
      phone: map['phone'] as String,
      password: map['password'] as String,
      isSuperuser: map['isSuperuser'] as bool,
      isActive: map['isActive'] as bool,
      isStaff: map['isStaff'] as bool,
      lastLogin: DateTime.fromMillisecondsSinceEpoch(map['lastLogin'] as int),
      dateJoined: DateTime.fromMillisecondsSinceEpoch(map['dateJoined'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, email: $email, firstName: $firstName, lastName: $lastName, completeName: $completeName, cpf: $cpf, phone: $phone, password: $password, isSuperuser: $isSuperuser, isActive: $isActive, isStaff: $isStaff, lastLogin: $lastLogin, dateJoined: $dateJoined)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.email == email &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.completeName == completeName &&
        other.cpf == cpf &&
        other.phone == phone &&
        other.password == password &&
        other.isSuperuser == isSuperuser &&
        other.isActive == isActive &&
        other.isStaff == isStaff &&
        other.lastLogin == lastLogin &&
        other.dateJoined == dateJoined;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        completeName.hashCode ^
        cpf.hashCode ^
        phone.hashCode ^
        password.hashCode ^
        isSuperuser.hashCode ^
        isActive.hashCode ^
        isStaff.hashCode ^
        lastLogin.hashCode ^
        dateJoined.hashCode;
  }
}

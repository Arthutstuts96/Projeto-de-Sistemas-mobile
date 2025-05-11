import 'package:projeto_de_sistemas/domain/models/users/user.dart';

class Address {
  User user;
  String city;
  String state;
  String street;
  String number;
  String neighborhood;

  Address({
    required this.user,
    required this.city,
    required this.state,
    required this.street,
    required this.number,
    required this.neighborhood,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      user: User.fromJson(json['user']),
      city: json['city'],
      state: json['state'],
      street: json['street'],
      number: json['number'],
      neighborhood: json['neighborhood'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'city': city,
      'state': state,
      'street': street,
      'number': number,
      'neighborhood': neighborhood,
    };
  }

  @override
  String toString() {
    return '$street, $number - $neighborhood, $city/$state';
  }
}

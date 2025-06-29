// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Address {
  int? id;
  int user;
  String zip_code;
  String street;
  String city;
  String state;
  String number;
  String complement;
  String neighborhood;
  
  Address({
    this.id,
    required this.user,
    required this.zip_code,
    required this.street,
    required this.city,
    required this.state,
    required this.number,
    required this.complement,
    required this.neighborhood,
  });

  Address copyWith({
    int? id,
    int? user,
    String? zip_code,
    String? street,
    String? city,
    String? state,
    String? number,
    String? complement,
    String? neighborhood,
  }) {
    return Address(
      id: id ?? this.id,
      user: user ?? this.user,
      zip_code: zip_code ?? this.zip_code,
      street: street ?? this.street,
      city: city ?? this.city,
      state: state ?? this.state,
      number: number ?? this.number,
      complement: complement ?? this.complement,
      neighborhood: neighborhood ?? this.neighborhood,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user': user,
      'zip_code': zip_code,
      'street': street,
      'city': city,
      'state': state,
      'number': number,
      'complement': complement,
      'neighborhood': neighborhood,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      id: map['id'] != null ? map['id'] as int : null,
      user: map['user'] as int,
      zip_code: map['zip_code'] as String,
      street: map['street'] as String,
      city: map['city'] as String,
      state: map['state'] as String,
      number: map['number'] as String,
      complement: map['complement'] as String,
      neighborhood: map['neighborhood'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) =>
      Address.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Address(id: $id, user: $user, zip_code: $zip_code, street: $street, city: $city, state: $state, number: $number, complement: $complement, neighborhood: $neighborhood)';
  }

  @override
  bool operator ==(covariant Address other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.user == user &&
        other.zip_code == zip_code &&
        other.street == street &&
        other.city == city &&
        other.state == state &&
        other.number == number &&
        other.complement == complement &&
        other.neighborhood == neighborhood;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        user.hashCode ^
        zip_code.hashCode ^
        street.hashCode ^
        city.hashCode ^
        state.hashCode ^
        number.hashCode ^
        complement.hashCode ^
        neighborhood.hashCode;
  }
}

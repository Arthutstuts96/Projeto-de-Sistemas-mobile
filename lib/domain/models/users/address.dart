import 'dart:convert';
import 'package:projeto_de_sistemas/domain/models/users/user.dart';

class Address {
  User user;
  String city;
  String state;
  String street;
  String number;
  String neighborhood;
  String quadra;
  String lote;
  String reference;
  String observation;
  Address({
    required this.user,
    required this.city,
    required this.state,
    required this.street,
    required this.number,
    required this.neighborhood,
    required this.quadra,
    required this.lote,
    required this.reference,
    required this.observation,
  });

  Address copyWith({
    User? user,
    String? city,
    String? state,
    String? street,
    String? number,
    String? neighborhood,
    String? quadra,
    String? lote,
    String? reference,
    String? observation,
  }) {
    return Address(
      user: user ?? this.user,
      city: city ?? this.city,
      state: state ?? this.state,
      street: street ?? this.street,
      number: number ?? this.number,
      neighborhood: neighborhood ?? this.neighborhood,
      quadra: quadra ?? this.quadra,
      lote: lote ?? this.lote,
      reference: reference ?? this.reference,
      observation: observation ?? this.observation,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user.toMap(),
      'city': city,
      'state': state,
      'street': street,
      'number': number,
      'neighborhood': neighborhood,
      'quadra': quadra,
      'lote': lote,
      'reference': reference,
      'observation': observation,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      user: User.fromMap(map['user'] as Map<String, dynamic>),
      city: map['city'] as String,
      state: map['state'] as String,
      street: map['street'] as String,
      number: map['number'] as String,
      neighborhood: map['neighborhood'] as String,
      quadra: map['quadra'] as String,
      lote: map['lote'] as String,
      reference: map['reference'] as String,
      observation: map['observation'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) =>
      Address.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Address(user: $user, city: $city, state: $state, street: $street, number: $number, neighborhood: $neighborhood, quadra: $quadra, lote: $lote, reference: $reference, observation: $observation)';
  }

  @override
  bool operator ==(covariant Address other) {
    if (identical(this, other)) return true;

    return other.user == user &&
        other.city == city &&
        other.state == state &&
        other.street == street &&
        other.number == number &&
        other.neighborhood == neighborhood &&
        other.quadra == quadra &&
        other.lote == lote &&
        other.reference == reference &&
        other.observation == observation;
  }

  @override
  int get hashCode {
    return user.hashCode ^
        city.hashCode ^
        state.hashCode ^
        street.hashCode ^
        number.hashCode ^
        neighborhood.hashCode ^
        quadra.hashCode ^
        lote.hashCode ^
        reference.hashCode ^
        observation.hashCode;
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:projeto_de_sistemas/domain/models/users/user.dart';

class Address {
  int? id;
  User? user;
  String city;
  String state;
  String street;
  String number;
  String quadra;
  String lote;
  String reference;
  String observation;

  Address({
    this.id,
    this.user,
    required this.city,
    required this.state,
    required this.street,
    required this.number,
    required this.quadra,
    required this.lote,
    required this.reference,
    required this.observation,
  });

  Address copyWith({
    int? id,
    User? user,
    String? city,
    String? state,
    String? street,
    String? number,
    String? quadra,
    String? lote,
    String? reference,
    String? observation,
  }) {
    return Address(
      id: id ?? this.id,
      user: user ?? this.user,
      city: city ?? this.city,
      state: state ?? this.state,
      street: street ?? this.street,
      number: number ?? this.number,
      quadra: quadra ?? this.quadra,
      lote: lote ?? this.lote,
      reference: reference ?? this.reference,
      observation: observation ?? this.observation,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user': user?.toMap(),
      'city': city,
      'state': state,
      'street': street,
      'number': number,
      'quadra': quadra,
      'lote': lote,
      'reference': reference,
      'observation': observation,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      id: map['id'] ?? 0,
      user:
          map['user'] != null
              ? User.fromMap(map['user'] as Map<String, dynamic>)
              : null,
      city: map['city'] ?? '',
      state: map['state'] ?? '',
      street: map['street'] ?? '',
      number: map['number'] ?? '',
      quadra: map['quadra'] ?? '',
      lote: map['lote'] ?? '',
      reference: map['reference'] ?? '',
      observation: map['observation'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) =>
      Address.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Address(id: $id, user: $user, city: $city, state: $state, street: $street, number: $number, quadra: $quadra, lote: $lote, reference: $reference, observation: $observation)';
  }

  @override
  bool operator ==(covariant Address other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.user == user &&
        other.city == city &&
        other.state == state &&
        other.street == street &&
        other.number == number &&
        other.quadra == quadra &&
        other.lote == lote &&
        other.reference == reference &&
        other.observation == observation;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        user.hashCode ^
        city.hashCode ^
        state.hashCode ^
        street.hashCode ^
        number.hashCode ^
        quadra.hashCode ^
        lote.hashCode ^
        reference.hashCode ^
        observation.hashCode;
  }
}

import 'dart:convert';
import 'package:projeto_de_sistemas/domain/models/users/user.dart';

class Address {
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

  factory Address.fromJson(String source) {
    final decoded = json.decode(source);

    // Garante que seja um Map
    if (decoded is Map<String, dynamic>) {
      return Address.fromMap(decoded);
    } else {
      throw Exception("JSON inválido para Address");
    }
  }

  @override
  String toString() {
    return 'Address(user: $user, city: $city, state: $state, street: $street, number: $number, quadra: $quadra, lote: $lote, reference: $reference, observation: $observation)';
  }

  @override
  bool operator ==(covariant Address other) {
    if (identical(this, other)) return true;

    return other.user == user &&
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
    return user.hashCode ^
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

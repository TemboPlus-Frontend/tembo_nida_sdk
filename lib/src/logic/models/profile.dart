import 'dart:convert';

class Profile {
  final String id;
  final String firstName;
  final String lastName;
  final String? phone;
  final String? email;
  final String? accountNo;

  String get name => "$firstName $lastName";

  const Profile({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.phone,
    this.accountNo,
    this.email,
  });

  Profile copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? businessName,
    String? phone,
    String? accountNo,
  }) {
    return Profile(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      accountNo: accountNo ?? this.accountNo,
      email: email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'accountNo': accountNo,
      'email': email,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      id: map['id'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      phone: map['phone'] != null ? map['phone'] as String : null,
      accountNo: map['accountNo'] as String,
      email: map["email"] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Profile.fromJson(String source) =>
      Profile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Profile(id: $id, firstName: $firstName, lastName: $lastName, phone: $phone, accountNo: $accountNo, email: $email)';
  }

  @override
  bool operator ==(covariant Profile other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.phone == phone &&
        other.email == email &&
        other.accountNo == accountNo;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        phone.hashCode ^
        email.hashCode ^
        accountNo.hashCode;
  }
}

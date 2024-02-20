// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:tembo_nida_sdk/source.dart';

/* 

 body: {
  "token":"Dz8foGhsj6xN3BJ6l1KTzioXWU8BombQmrmvQufkjRXw2uMJ2HFmSbgQB43VkC9I",
  "profile":{
    "id":"Xs85qILMXEn5",
    "firstName":"John",
    "lastName":"Doe",
    "phone":"255788908899",
    "isPhoneVerified":false,
    "email":"admin@temboplus.com",
    "isEmailVerified":true,
    "nin":"19830610141280000121",
    "cardIssueDate":"2012-08-11T00:00:00.000Z",
    "cardExpiryDate":"2024-09-10T00:00:00.000Z",
    "onboardId":null,
    "accountNo":null,
    "createdAt":"2024-02-19T09:10:30.000Z",
    "updatedAt":"2024-02-20T06:23:02.000Z"
    }
  }
 */

class Profile {
  final String id;
  final PhoneNumber? phone;
  final DateTime? cardIssueDate;
  final DateTime? cardExpiryDate;
  final String? nin;
  final String? email;
  final String? onboardId;

  const Profile({
    required this.id,
    this.cardIssueDate,
    this.cardExpiryDate,
    this.nin,
    this.phone,
    this.email,
    this.onboardId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'cardIssueDate': cardIssueDate,
      'cardExpiryDate': cardExpiryDate,
      'nin': nin,
      'phone': phone,
      'email': email,
      'onboardId': onboardId,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      id: map['id'] as String,
      cardIssueDate: map['cardIssueDate'] != null
          ? DateTimeExt.fromJson(map["cardIssueDate"])
          : null,
      cardExpiryDate: map['cardExpiryDate'] != null
          ? DateTimeExt.fromJson(map["cardExpiryDate"])
          : null,
      nin: map['nin'] != null ? map['nin'] as String : null,
      phone: map['phone'] != null ? PhoneNumber.from(map['phone']) : null,
      email: map['email'] != null ? map['email'] as String : null,
      onboardId: map['onboardId']!= null? map['onboardId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Profile.fromJson(String source) =>
      Profile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Profile(id: $id, phone: $phone, cardIssueDate: $cardIssueDate, cardExpiryDate: $cardExpiryDate, nin: $nin, email: $email, onboardId: $onboardId)';
  }

  @override
  bool operator ==(covariant Profile other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.phone == phone &&
      other.cardIssueDate == cardIssueDate &&
      other.cardExpiryDate == cardExpiryDate &&
      other.nin == nin &&
      other.email == email &&
      other.onboardId == onboardId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      phone.hashCode ^
      cardIssueDate.hashCode ^
      cardExpiryDate.hashCode ^
      nin.hashCode ^
      email.hashCode ^
      onboardId.hashCode;
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:tembo_nida_sdk/source.dart';

class Session {
  final String nin;
  final String onboardId;
  final String applicationId;

  const Session({
    required this.nin,
    required this.onboardId,
    required this.applicationId,
  });

  const Session.initial({
    this.nin = "",
    this.onboardId = "",
    this.applicationId = "",
  });

  Session copyWith({
    String? nin,
    String? onboardId,
    String? applicationId,
  }) {
    return Session(
      nin: nin ?? this.nin,
      onboardId: onboardId ?? this.onboardId,
      applicationId: applicationId ?? this.applicationId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nin': nin,
      'id': onboardId,
      'applicationId': applicationId,
    };
  }

  factory Session.fromMap(Map<String, dynamic> map) {
    return Session(
      nin: map['nin'] as String,
      onboardId: map['id'] as String,
      applicationId: map['applicationId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Session.fromJson(String source) =>
      Session.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Session(nin: $nin, onboardId: $onboardId, applicationId: $applicationId)';

  @override
  bool operator ==(covariant Session other) {
    if (identical(this, other)) return true;

    return other.nin == nin &&
        other.onboardId == onboardId &&
        other.applicationId == applicationId;
  }

  @override
  int get hashCode =>
      nin.hashCode ^ onboardId.hashCode ^ applicationId.hashCode;
}

class SessionCreateData {
  final String nin;
  final ParsedPhoneNumber phone;
  final String email;

  final DateTime issueDate;
  final DateTime expiryDate;

  const SessionCreateData({
    required this.nin,
    required this.phone,
    required this.email,
    required this.issueDate,
    required this.expiryDate,
  });
}

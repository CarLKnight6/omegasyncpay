// import 'package:equatable/equatable.dart';
// import 'package:json_annotation/json_annotation.dart';

// part 'user_key.g.dart';

// typedef UserID = String;

// @JsonSerializable(explicitToJson: true)
// class UserKey extends Equatable {
//   final String? aggregateId;
//   final String? lastName;
//   final String? middleName;
//   final String? firstName;
//   final String? email;
//   final String? shardKey;

//   const UserKey({
//     this.aggregateId,
//     this.lastName,
//     this.middleName,
//     this.firstName,
//     this.email,
//     this.shardKey,
//   });

//   @override
//   List<Object?> get props =>
//       [aggregateId, lastName, middleName, firstName, email, shardKey];

//   factory UserKey.fromJson(Map<String, dynamic> json) =>
//       _$UserKeyFromJson(json);

//   Map<String, dynamic> toJson() => _$UserKeyToJson(this);

//   // factory UserAuthentication.fromJson(Map<String, dynamic> json, UserID id) => UserAuthentication (
//   //   id: id,
//   //   name: json['name'] as String?,
//   //   password: json['password'] as String?,
//   //   jwtAccessToken: json['jwtAccessToken'] as String?,
//   //   jwtRefreshoken: json['jwtRefreshoken'] as String?
//   // );

//   // Map<String, dynamic> toJson() => {
//   //   'id': id,
//   //   'name': name,
//   //   'password': password,
//   //   'jwtAccessToken': jwtAccessToken,
//   //   'jwtRefreshoken': jwtRefreshoken
//   // };
// }

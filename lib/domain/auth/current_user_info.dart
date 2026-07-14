// import 'package:coamplifi_pro/domain/auth/user_key.dart';
// import 'package:equatable/equatable.dart';
// import 'package:json_annotation/json_annotation.dart';

// part 'current_user_info.g.dart';

// typedef UserID = String;

// @JsonSerializable(explicitToJson: true)
// class CurrentUserInfo extends Equatable {
//   final String? homeState;
//   final UserKey userKey;
//   //final  TenantAssociation tenantAssociation;
//   final String defaultTenantId;
//   final String defaultTenantType;
//   final List<String> roles;

//   const CurrentUserInfo(
//     this.homeState,
//     this.userKey,
//     this.defaultTenantId,
//     this.defaultTenantType,
//     this.roles,
//   );

//   @override
//   List<Object?> get props =>
//       [homeState, userKey, defaultTenantId, defaultTenantType, roles];

//   factory CurrentUserInfo.fromJson(Map<String, dynamic> json) =>
//       _$CurrentUserInfoFromJson(json);

//   Map<String, dynamic> toJson() => _$CurrentUserInfoToJson(this);

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

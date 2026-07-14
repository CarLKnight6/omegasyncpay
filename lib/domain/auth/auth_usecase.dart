// import 'dart:convert';
// import 'dart:developer';

// import 'package:coamplifi_pro/data/api/api_client/response/error_response.dart';
// import 'package:coamplifi_pro/data/datasource/auth/auth_remote_datasource_type.dart';
// import 'package:coamplifi_pro/data/dto/uaa_dto.dart';
// import 'package:coamplifi_pro/domain/auth/auth_repository_type.dart';
// import 'package:coamplifi_pro/domain/auth/auth_usecase_type.dart';
// import 'package:coamplifi_pro/domain/auth/demo_user.dart';
// import 'package:coamplifi_pro/domain/auth/tenant_info.dart';
// import 'package:coamplifi_pro/domain/auth/user_auth_entity.dart';
// import 'package:coamplifi_pro/domain/auth/failure.dart';
// import 'package:dartz/dartz.dart';
// import 'package:jwt_decode/jwt_decode.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../data/api/security_storage_client/security_storgage_client.dart';
// import 'current_user_info.dart';

// class AuthUsecase implements AuthUsecaseType {
//   final AuthRepositoryType authRepository;

//   final AuthRemoteDatasourceType authRemoteDatasource;

//   AuthUsecase(
//       {required this.authRemoteDatasource, required this.authRepository});

//   @override
//   Future<Either<Failure, UserAuthEntity>> login(
//       String name, String password, String recaptchaToken) async {
//     Either<Failure, UaaDTO> result = await authRemoteDatasource.getUaa(
//         name, password, false, recaptchaToken);

//     return result.fold(
//       (failure) => Left(failure),
//       (uaaDTO) => _onGetUaaSuccess(uaaDTO),
//     );
//   }

//   @override
//   Future<Either<Failure, UserAuthEntity>> assistant(
//       String name, String password) async {
//     Either<Failure, UaaDTO> result =
//         await authRemoteDatasource.getUaa(name, password, true, '');

//     return result.fold(
//       (failure) => Left(failure),
//       (uaaDTO) => _onAssistantSuccess(uaaDTO),
//     );
//   }

//   @override
//   Future<void> endAssistant() async {
//     Either<ErrorResponse, UserAuthEntity> result =
//         await authRepository.getUserAuth();

//     result.fold((l) => Left(l), (r) async {
//       UserAuthEntity userAuthEntity = UserAuthEntity(
//           r.id,
//           r.name,
//           r.password,
//           r.jwtAccessToken,
//           r.jwtRefreshToken,
//           r.currentTenantId,
//           r.aggregateId,
//           r.tenants,
//           assistant: false);

//       await authRepository.saveUserAuth(userAuthEntity);
//     });
//   }

//   @override
//   Future<void> logout() async {
//     await authRepository.deleteUserAuth();
//   }

//   Future<Either<Failure, UserAuthEntity>> _onGetUaaSuccess(UaaDTO dto) async {
//     final prefs = await SharedPreferences.getInstance();
//     bool emailPref = prefs.getBool('saveEmail') ?? false;
//     String? email;

//     if (emailPref) {
//       email = dto.name;

//       prefs.setString('email', email);
//     }

//     UserAuthEntity userAuthEntity = UserAuthEntity(
//         dto.id,
//         dto.name,
//         dto.password,
//         dto.jwtAccessToken,
//         dto.jwtRefreshToken,
//         dto.currentTenantId,
//         dto.aggregateId,
//         dto.tenants);
//     // Store the password securely
//     await SecurityStorageClient.storage
//         .write(key: 'password', value: userAuthEntity.password);
//     await authRepository.saveUserAuth(userAuthEntity);
//     return Right(userAuthEntity);
//   }

//   Future<Either<Failure, UserAuthEntity>> _onAssistantSuccess(
//       UaaDTO dto) async {
//     UserAuthEntity userAuthEntity = const UserAuthEntity(
//         'id',
//         'name',
//         'password',
//         'jwtAccessToken',
//         'jwtRefreshToken',
//         'currentTenantId',
//         'aggregateId', []);

//     Either<ErrorResponse, UserAuthEntity> result =
//         await authRepository.getUserAuth();

//     result.fold((l) {
//       return Left(l);
//     }, (r) {
//       userAuthEntity = UserAuthEntity(
//           r.id,
//           r.name,
//           r.password,
//           r.jwtAccessToken,
//           r.jwtRefreshToken,
//           r.currentTenantId,
//           r.aggregateId,
//           r.tenants,
//           assistant: true,
//           assistantId: dto.aggregateId,
//           assistantName: dto.name,
//           assistantAccessToken: dto.jwtAccessToken,
//           assistantRefreshToken: dto.jwtRefreshToken);
//       // _decodeAuthorities(userAuthEntity);
//     });

//     await authRepository.saveUserAuth(userAuthEntity);
//     return Right(userAuthEntity);
//   }

//   @override
//   Future<Either<Failure, bool>> hasJwtToken() async {
//     Either<ErrorResponse, UserAuthEntity> result =
//         await authRepository.getUserAuth();

//     return result.fold(
//       (left) => Left(Failure(message: "xxx")),
//       (right) => Right(true),
//     );
//   }

//   @override
//   Future<Either<Failure, CurrentUserInfo>> getCurrentUserInfo() async {
//     print('Fetching user info');
//     Either<Failure, CurrentUserInfo> cachedResult = await sharedPrefsUser();

//     return cachedResult.fold(
//       (failure) async {
//         // Shared preferences failed, fetching as normal
//         Either<ErrorResponse, UserAuthEntity> result =
//             await authRepository.getUserAuth();

//         // Handle the result of fetching user auth
//         return result.fold(
//           (errorResponse) {
//             // Log the error and return a failure
//             print('Error fetching user auth: ${errorResponse.message}');
//             return Left(Failure(message: errorResponse.message));
//           },
//           (userAuthEntity) {
//             // Handle successful user auth entity retrieval
//             return _onUserAuthEntitySuccess(userAuthEntity);
//           },
//         );
//       },
//       (currentUserInfo) {
//         // Successfully retrieved from shared preferences
//         return Right(currentUserInfo);
//       },
//     );
//   }

//   @override
//   Future<Either<Failure, CurrentUserInfo>> sharedPrefsUser() async {
//     final prefs = await SharedPreferences.getInstance();
//     String? info = await prefs.getString('currentUserInfo');

//     if (info == null) {
//       return const Left(Failure(message: 'no info found'));
//     }
//     return Right(CurrentUserInfo.fromJson(jsonDecode(info)));
//   }

//   @override
//   Future<Either<Failure, List<TenantInfo>>> fetchTenants() async {
//     Either<ErrorResponse, UserAuthEntity> result =
//         await authRepository.getUserAuth();

//     return result.fold(
//       (errorResponse) => Left(Failure(message: errorResponse.message)),
//       (userAuthEntity) async {
//         Either<Failure, List<TenantInfo>> tenantInfoList =
//             await authRemoteDatasource.getTenantInfo(userAuthEntity.tenants!);
//         return tenantInfoList.fold((l) => Left(l), (r) => Right(r));
//       },
//     );
//   }

//   @override
//   Future<Either<Failure, String>> tenantSwitch(String tenantId) async {
//     Either<ErrorResponse, UserAuthEntity> result =
//         await authRepository.getUserAuth();

//     return result.fold(
//       (left) {
//         return Left(Failure(message: "xxx"));
//       },
//       (right) async {
//         Either<Failure, UaaDTO> result =
//             await authRemoteDatasource.switchTenant(
//                 tenantId, right.jwtRefreshToken, right.name, right.password);

//         return result.fold(
//           (failure) => Left(failure),
//           (uaaDTO) async {
//             final prefs = await SharedPreferences.getInstance();
//             prefs.setString('aggregateId', uaaDTO.aggregateId!);
//             prefs.setString('currentTenantId', uaaDTO.currentTenantId!);

//             await _onGetUaaSuccess(uaaDTO);
//             return const Right('Finish');
//           },
//         );
//       },
//     );
//   }

//   @override
//   Future<Either<Failure, List<dynamic>?>> getAuthorities() async {
//     Either<ErrorResponse, UserAuthEntity> result =
//         await authRepository.getUserAuth();
//     return result.fold((ErrorResponse) => Left(Failure(message: "xxx")),
//         (userAuthEntity) => _decodeAuthorities(userAuthEntity));
//   }

//   Future<Either<Failure, List<dynamic>?>> _decodeAuthorities(
//       UserAuthEntity userAuthEntity) async {
//     Map<String, dynamic> decodedToken;
//     if (userAuthEntity.assistant == true) {
//       decodedToken = Jwt.parseJwt(userAuthEntity.assistantAccessToken!);
//     } else {
//       decodedToken = Jwt.parseJwt(userAuthEntity.jwtAccessToken);
//     }
//     List<dynamic>? authorities = decodedToken['authorities'];
//     return Right(authorities);
//   }

//   Future<Either<Failure, CurrentUserInfo>> _onUserAuthEntitySuccess(
//       UserAuthEntity userAuthEntity) async {
//     Map<String, dynamic> decodedToken = {};

//     if (userAuthEntity.assistant != null) {
//       if (userAuthEntity.assistant!) {
//         decodedToken = Jwt.parseJwt(userAuthEntity.assistantAccessToken!);
//       } else {
//         decodedToken = Jwt.parseJwt(userAuthEntity.jwtAccessToken);
//       }
//     } else {
//       decodedToken = Jwt.parseJwt(userAuthEntity.jwtAccessToken);
//     }
//     String jsonString = decodedToken['currentUserInfo'];
//     CurrentUserInfo currentUserInfo =
//         CurrentUserInfo.fromJson(jsonDecode(jsonString));

//     final prefs = await SharedPreferences.getInstance();
//     prefs.setString('currentUserInfo', jsonString);

// //Converts to some kind of demo user every single time??
//     return Right(toDemoUserInfo(currentUserInfo));
// //    return Right(currentUserInfo);
//   }
// }

// import 'package:coamplifi_pro/domain/auth/failure.dart';
// import 'package:coamplifi_pro/domain/auth/user_key.dart';
// import 'package:coamplifi_pro/domain/password/password_usecase_type.dart';

// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';
// import '../../data/datasource/currentuser/currentuser_remote_datasource_type.dart';
// import '../../data/datasource/password/password_remote_datasource_type.dart';
// import 'password_repository_type.dart';

// class PasswordUsecase implements PasswordUsecaseType {
//   final PasswordRepositoryType passwordRepository;

//   final PasswordRemoteDatasourceType passwordRemoteDatasource;

//   PasswordUsecase(
//       {required this.passwordRemoteDatasource,
//       required this.passwordRepository});

//   @override
//   Future<dynamic> forgotPassword(Map<String, dynamic> data) async {
//     final result = await passwordRepository.forgotPassword(data);

//     return result.fold((l) {
//       return Left(l);
//     }, (r) {
//       return Right(r);
//     });
//   }

//   @override
//   Future<dynamic> updatePassword(Map<String, dynamic> data) async {
//     final result = await passwordRepository.updatePassword(data);

//     return result.fold((l) {
//       return Left(l);
//     }, (r) {
//       return Right(r);
//     });
//   }
// }
// //TODO:modified

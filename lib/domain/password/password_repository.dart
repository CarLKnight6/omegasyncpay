// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';

// import '../../data/datasource/password/password_local_datasource_type.dart';
// import '../../data/datasource/password/password_remote_datasource_type.dart';
// import '../auth/failure.dart';
// import '../auth/user_key.dart';
// import 'password_repository_type.dart';

// class PasswordRepository implements PasswordRepositoryType {
//   final PasswordLocalDatasourceType passwordLocalDatasource;
//   final PasswordRemoteDatasourceType passwordRemoteDatasource;

//   PasswordRepository(
//       {required this.passwordLocalDatasource,
//       required this.passwordRemoteDatasource});

//   @override
//   Future forgotPassword(Map<String, dynamic> data) async {
//     try {
//       final fetchCurrentUser =
//           await passwordRemoteDatasource.forgotPassword(data);
//       return Right(fetchCurrentUser);
//     } catch (e) {
//       return Left(Failure(message: e.toString()));
//     }
//   }

//   @override
//   Future updatePassword(Map<String, dynamic> data) async {
//     try {
//       final fetchCurrentUser =
//           await passwordRemoteDatasource.updatePassword(data);
//       return Right(fetchCurrentUser);
//     } catch (e) {
//       return Left(Failure(message: e.toString()));
//     }
//   }
// }
// //TODO:modified

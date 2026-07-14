// import 'package:coamplifi_pro/data/dto/organization_service_current_dto.dart';
// import 'package:coamplifi_pro/model/position.dart';
// import 'package:coamplifi_pro/model/position_dto.dart';
// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';
// import '../../data/datasource/currentuser/currentuser_remote_datasource_type.dart';
// import '../auth/failure.dart';
// import '../auth/user_key.dart';
// import 'currentuser_repository_type.dart';

// class CurrentUserRepository implements CurrentUserRepositoryType {
//   final CurrentUserRemoteDatasourceType currentuserRemoteDatasource;

//   CurrentUserRepository({required this.currentuserRemoteDatasource});

//   @override
//   Future<Either<Failure, UserKey>> fetchCurrentUser() async {
//     try {
//       final fetchCurrentUser =
//           await currentuserRemoteDatasource.getCurrentUser();
//       return Right(fetchCurrentUser);
//     } catch (e) {
//       return Left(Failure(message: e.toString()));
//     }
//   }

//   @override
//   Future postAvatar(String shardKey, FormData payload) async {
//     try {
//       final fetchCurrentUser =
//           await currentuserRemoteDatasource.postAvatar(shardKey, payload);
//       return Right(fetchCurrentUser);
//     } catch (e) {
//       return Left(Failure(message: e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, dynamic>> updatePassword(
//       Map<String, dynamic> payload) async {
//     try {
//       final updatePass =
//           await currentuserRemoteDatasource.updatePassword(payload);
//       return Right(updatePass);
//     } catch (e) {
//       return Left(Failure(message: e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, Position>> fetchCurrentPosition(
//       List<String> data) async {
//     try {
//       final currentPosition =
//           await currentuserRemoteDatasource.getCurrentPosition(data);
//       return Right(currentPosition);
//     } catch (e) {
//       return Left(Failure(message: e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, PositionDTO>> fetchCurrentPositionByUserId(
//       String userId) async {
//     try {
//       final currentPosition =
//           await currentuserRemoteDatasource.getPositionsByUserId(userId);
//       return Right(currentPosition);
//     } catch (e) {
//       return Left(Failure(message: e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, OrganizationServiceCurrentDTO>>
//       getVisibilityData() async {
//     try {
//       final result = await currentuserRemoteDatasource.getVisibilityData();
//       return Right(result);
//     } catch (e) {
//       return Left(Failure(message: e.toString()));
//     }
//   }
// }
// //TODO:modified
